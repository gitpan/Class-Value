use 5.008;
use strict;
use warnings;

package Class::Value;
our $VERSION = '1.100840';
# ABSTRACT: Implements the Value Object Design Pattern
use Error ':try';
use Class::Value::DefaultNotify;
use Error::Hierarchy::Container;
use parent qw(Class::Accessor::Complex Class::Accessor::Constructor);

# Use strings for overloading sub names so they're interpreted as method names
# and the methods can be overridden in subclasses while continuing to work as
# expected. The overloaded operations have been chosen so that as much as
# necessary can be autogenerated (see "perldoc overload": MAGIC
# AUTOGENERATION). Subclasses are free to provide custom overloads of
# autogenerated methods, of course.
use overload
  '+'     => 'add',
  '-'     => 'subtract',
  '*'     => 'multiply',
  '/'     => 'divide',
  '**'    => 'power',
  '%'     => 'modulo',
  cmp     => 'str_cmp',
  '<=>'   => 'num_cmp',
  '<<'    => 'bit_shift_left',
  '>>'    => 'bit_shift_right',
  '&'     => 'bit_and',
  '|'     => 'bit_or',
  '^'     => 'bit_xor',
  '~'     => 'bit_not',
  'atan2' => 'atan2',
  'cos'   => 'cos',
  'sin'   => 'sin',
  'exp'   => 'exp',
  'log'   => 'log',
  'sqrt'  => 'sqrt',
  'int'   => 'int',
  '""'    => 'stringify',
  '<>'    => 'iterate';
__PACKAGE__
    ->mk_constructor
    ->mk_scalar_accessors(qw(notify_delegate))
    ->mk_object_accessors(
        'Error::Hierarchy::Container' => 'exception_container'
    );
use constant UNHYGIENIC => (qw/value/);

# our(), not a static boolean method, so it can be local()'ed.
our $SkipChecks           = 1;
our $SkipNormalizations   = 0;
our $ThrowSingleException = 0;

sub skip_checks {
    our $SkipChecks;
    return $SkipChecks if @_ == 1;
    $SkipChecks = $_[1];
}

sub skip_normalizations {
    our $SkipNormalizations;
    return $SkipNormalizations if @_ == 1;
    $SkipNormalizations = $_[1];
}

sub throw_single_exception {
    our $ThrowSingleException;
    return $ThrowSingleException if @_ == 1;
    $ThrowSingleException = $_[1];
}

# Every value object gets the same notify delegate object
use constant DEFAULTS =>
  (notify_delegate => (our $DELEGATE ||= Class::Value::DefaultNotify->new),);
use constant FIRST_CONSTRUCTOR_ARGS => ('notify_delegate');

sub MUNGE_CONSTRUCTOR_ARGS {
    my $self = shift;

    # if (@_ == 1 && ref($_[0]) eq 'HASH') {
    #     @_ = %{ $_[0] };
    # } elsif (@_ % 2) {
    if (@_ % 2) {

        # odd number of args
        unshift @_, 'value';
    }
    my $ref = ref $self;
    our %cache_isa;

    # cache hash value is 0 or 1, so need to use exists()
    unless (exists $cache_isa{$ref}) {
        $cache_isa{$ref} = UNIVERSAL::isa($self, 'Class::Scaffold::Storable');
    }
    if ($cache_isa{$ref}) {
        return $self->Class::Scaffold::Storable::MUNGE_CONSTRUCTOR_ARGS(@_);
    }
    @_;
}
sub init { }

sub value {
    my $self = shift;
    return $self->get_value unless @_;
    my $value = shift;

    # run_checks() returns normalized value; check even undefined values -
    # individual value objects have to decide whether undef is an acceptable
    # value for them.
    if (our $SkipChecks) {

        our $SkipNormalizations;
        if (defined($value) && !$SkipNormalizations) {
            my $normalized = $self->normalize_value($value);
            $value = $normalized if defined $normalized;
        }
    } else {
        $value = $self->run_checks($value);
    }
    $self->set_value($value);

    $value;    # return for convenience
}

# Subclasses might want to override this if they don't use a custom notify
# delegate but choose to throw a fixed exception.
sub send_notify_value_not_wellformed {
    my ($self, $value) = @_;
    $self->notify_delegate->notify_value_not_wellformed(ref($self), $value);
}

sub send_notify_value_invalid {
    my ($self, $value) = @_;
    $self->notify_delegate->notify_value_invalid(ref($self), $value);
}

sub send_notify_value_normalized {
    my ($self, $value, $normalized) = @_;
    $self->notify_delegate->notify_value_normalized(ref($self), $value,
        $normalized);
}
sub get_value { $_[0]->{_value} }
sub set_value { $_[0]->{_value} = $_[1] }

sub is_defined {
    my $self = shift;
    defined $self->get_value;
}

sub is_well_formed {
    my $self = shift;
    $self->is_well_formed_value(@_ ? shift : $self->value);
}
sub is_well_formed_value { 1 }

sub is_valid {
    my $self = shift;
    $self->is_valid_value(@_ ? shift : $self->value);
}

sub is_valid_value {
    my ($self, $value) = @_;

    # value can be undef
    return 1 unless defined $value;
    my $normalized = $self->normalize_value($value);
    return 0 unless defined $normalized;
    $self->is_valid_normalized_value($normalized);
}

sub is_valid_normalized_value {
    my ($self, $normalized) = @_;
    defined $normalized && $self->is_well_formed($normalized);
}

sub normalize_value {
    my ($self, $value) = @_;
    $value;
}

sub check {
    my $self = shift;
    my $value = @_ ? shift : $self->value;
    $self->is_well_formed($value) && $self->is_valid($value);
}

sub run_checks {
    my $self = shift;
    $self->exception_container->items_clear;
    my $value = @_ ? shift : $self->value;
    $self->is_well_formed($value)
      || $self->send_notify_value_not_wellformed($value);
    $self->is_valid($value) || $self->send_notify_value_invalid($value);
    my $normalized = $self->normalize($value);
    if (defined($value) && defined($normalized) && ($value ne $normalized)) {
        $self->send_notify_value_normalized($value, $normalized);
    }
    if (my $count = $self->exception_container->items_count) {
        if ($count == 1 && our $ThrowSingleException) {
            $self->exception_container->items->[0]->throw;
        } else {
            $self->exception_container->throw;
        }
    }
    $normalized;
}

sub run_checks_with_exception_container {
    my $self                = shift;
    my $exception_container = shift;
    my $value               = @_ ? shift : $self->value;
    try {
        $self->run_checks($value);
    }
    catch Error with {
        $exception_container->items_set_push($_[0]);
    };

    # We only needed to fill the value object's exception container during
    # run_checks; now the exceptions have wandered into the exception
    # container that was passed to us, we don't need the value object's
    # exception container anymore.
    $self->exception_container->items_clear;
}

sub normalize {
    my ($self, $value) = @_;
    my $normalized = $self->normalize_value($value);
    if (defined $value) {
        if (defined $normalized) {
            if ($value ne $normalized) {
                $self->send_notify_value_normalized($value, $normalized);
            }
        } else {

            # can't normalize; treat as invalid value
            $self->send_notify_value_invalid($value);
        }
    }
    $normalized;
}

# have the Class::Value be restrictive with respect to operations on the
# value; subclasses can then define certain operations.
for my $op (
    qw/add subtract multiply divide power modulo num_cmp
    bit_shift_left bit_shift_right bit_and bit_or bit_xor bit_not
    atan2 cos sin exp log sqrt int iterate
    /
  ) {
    no strict 'refs';
    *{$op} = sub {
        require Class::Value::Exception::UnsupportedOperation;
        throw Class::Value::Exception::UnsupportedOperation(
            ref    => ref($_[0]),
            value  => $_[0],
            opname => $op,
        );
    };
}

sub str_cmp {
    sprintf("%s", ($_[0] || '')) cmp sprintf("%s", ($_[1] || ''));
}
sub stringify { $_[0]->value }

sub comparable {
    my $self  = shift;
    my $value = $self->value;

    # Convert the value into a string, because eq_or_diff seems to make a
    # difference between strings and numbers.
    defined $value ? "$value" : '';
}
1;


__END__
=pod

=head1 NAME

Class::Value - Implements the Value Object Design Pattern

=head1 VERSION

version 1.100840

=for stopwords exp

=head1 SYNOPSIS

    Class::Value::Boolean->new("Y");      # ok
    Class::Value::Boolean->new("hoge");   # fails 

=head1 DESCRIPTION

This class, and other classes in its namespace, implement the Value Object
Design Pattern. A value object encapsulates its value and adds semantic
information. For example, an IPv4 address is not just a string of arbitrary
characters. You can detect whether a given string is a well-formed IPv4
address and perform certain operations on it. Value objects provide a
consistent interface to do this for all kinds of semantically-enhanced values.

=head1 METHODS

=head2 value

This is the method to use when getting or setting values. It includes the
checks for well-formedness and validity. The values of C<$SkipChecks> and
C<$SkipNormalizations> are respected.

When skipping checks, we still try to normalize the value, unless told not to
by C<$SkipNormalizations>. If we can't normalize it, that is,
C<normalize_value()> returns C<undef>, we use the value we were given. We
don't try to normalize an undefined value lest some overridden
C<normalize_value()> method checks via C<assert_defined()>.

Skipping even normalization is useful if you want to purposefully set an
denormalized value and later check whether C<run_checks()> properly normalizes
it.

If you absolutely need to set an value that will not be validated, use
C<set_value()> for that. The value stored by C<set_value()> could be anything
- a scalar, array, hash, coderef, another object etc. Specific value objects
could also accept various input and decode it into the underlying components.

Consider, for example, a date value class that internally stores year, month
and day components, for example using accessors generated by
L<Class::Accessor::Complex>. The public interface for the value object would
still be C<value()>; outside code never needs to know what's happening behind
the scenes. However, outside code could call C<year()>, C<month()> and
C<day()> on the value object and get at the components.

The date value class would override C<set_value()> to parse the input and
split it into the components. It would also override C<is_well_formed_value()>
and/or C<is_valid_value()> to do some checking. And it would override
get_value to return the components joined up into a date string. Thus,
C<stringify()> would continue to work as expected.

=head2 MUNGE_CONSTRUCTOR_ARGS

This is called by the constructor before setting attributes with the
constructor's arguments. If the number of arguments is an odd value, it
prepends the word C<value>. This allows you to write:

    My::Class::Value->new('my_value');

instead of having to write

    My::Class::Value->new(value => 'my_value');

=head2 add

This method is used as the overload handler for the C<+> operation. It can be
overridden in subclasses. In this base class it throws an
L<Class::Value::Exception::UnsupportedOperation> exception.

=head2 atan2

Like C<add()> but affects the C<atan2> operation.

=head2 bit_and

Like C<add()> but affects the C<&> operation.

=head2 bit_not

Like C<add()> but affects the C<~> operation.

=head2 bit_or

Like C<add()> but affects the C<|> operation.

=head2 bit_shift_left

Like C<add()> but affects the C<< << >> operation.

=head2 bit_shift_right

Like C<add()> but affects the C<< >> >> operation.

=head2 bit_xor

Like C<add()> but affects the C<^> operation.

=head2 check

Takes the argument value, if given, or the object's currently set value and
checks whether it is well-formed and valid.

=head2 comparable

As support for L<Data::Comparable>, this method stringifies the value object.
If no value is set, it returns the empty string.

=head2 cos

Like C<add()> but affects the C<cos> operation.

=head2 divide

Like C<add()> but affects the C</> operation.

=head2 exp

Like C<add()> but affects the C<exp> operation.

=head2 get_value

Returns the value object's currently stored value.

=head2 int

Like C<add()> but affects the C<int> operation.

=head2 is_defined

Returns whether the currently stored value is defined. If there is no value
set on the value object, it will return C<undef>.

=head2 is_valid

Takes the argument value, if given, or the object's currently set value and
checks whether it is valid.

=head2 is_valid_normalized_value

Takes a normalized value as an argument and checks whether it is well-formed.

=head2 is_valid_value

Takes a value as an argument, normalizes it and checks whether the normalized
value is valid. If normalization fails, that is, if it returns C<undef>, then
this method will return 0. If the argument value - before normalization - is
not defined, this method returns 1, because when no value has been set on the
value object yet we don't want it to report an invalid value. If you need a
different behaviour, subclass and override this method.

=head2 is_well_formed

Takes the argument value, if given, or the object's currently set value and
checks whether it is well-formed.

=head2 is_well_formed_value

Takes an argument value and checks whether it is well-formed. In this base
class, this method always returns 1.

=head2 iterate

Like C<add()> but affects the C<< <> >> operation.

=head2 log

Like C<add()> but affects the C<log> operation.

=head2 modulo

Like C<add()> but affects the C<%> operation.

=head2 multiply

Like C<add()> but affects the C<*> operation.

=head2 normalize

Takes an argument value and tries to normalize it. If the normalized value is
different from the argument value, it sends out a notification by calling
C<send_notify_value_normalized()> - this will most likely be just
informational. If normalization failed because C<normalize_value()> returned
C<undef>, a different notification is being sent using
C<send_notify_value_invalid()>.

=head2 normalize_value

Takes an argument value and normalizes it. In this base class, the value is
returned as is, but in subclasses you could customize this behaviour. For
example, in a date-related value object you might accept various date input
formats but normalize it to one specific format. Also see
L<Class::Value::Boolean> and its superclass L<Class::Value::Enum> as an
example.

This method should just normalize the value and return C<undef> if it can't do
so. It should not send any notifications; they are handled by C<normalize()>.

=head2 num_cmp

Like C<add()> but affects the C<< <=> >> operation.

=head2 power

Like C<add()> but affects the C<**> operation.

=head2 run_checks

Takes the argument value, if given, or the object's currently set value and
checks whether it is valid and well-formed. The value object's exception
container is cleared before those checks so notification delegates can store
exceptions in this container.

If only one exception has been recorded and C<$ThrowSingleException> is true
then this individual exception will be thrown. Otherwise the whole exception
container will be thrown.

=head2 run_checks_with_exception_container

Like C<run_checks()>, except that it takes as an additional first argument an
exception container object. The exceptions accumulated during the checks are
stored in this container. The container will not be thrown. This is useful if
you have various value objects and you want to accumulate all exceptions in
one big exception container.

The value object's own exception container will be modified during the checks
and cleared afterwards.

=head2 send_notify_value_invalid

Calls C<notify_value_invalid()> on the notification delegate.

=head2 send_notify_value_normalized

Calls C<notify_value_normalized()> on the notification delegate.

=head2 send_notify_value_not_wellformed

Calls C<notify_value_not_wellformed()> on the notification delegate.

=head2 set_value

Directly sets the argument value on the value object without any checks.

=head2 sin

Like C<add()> but affects the C<sin> operation.

=head2 skip_checks

You can tell the value object to omit all checks that would be run during
C<value()>. If this method is given an argument value, it will set the
package-global C<$SkipChecks>. If no argument is given, it will return the
current value of C<$SkipChecks>. Note that this is not a per-object setting.

Temporarily skipping checks is useful if you want to set a series of value
objects to values that might be invalid, for example when reading them from a
data source such as a database or a configuration file, and later call
C<run_checks_with_exception_container()> on all of them.

You can use

    Class::Value->skip_checks(1);

to temporarily skip checks, but you have to remember to call

    Class::Value->skip_checks(0);

afterwards. An alternative way would be to bypass this method:

    {
        local $Class::Value::SkipChecks = 1;
        ...
    }

=head2 skip_normalizations

Like C<skip_checks()>, but it affects the normalizations that would be done
during C<value()>.

=head2 sqrt

Like C<add()> but affects the C<sqrt> operation.

=head2 str_cmp

Like C<add()> but affects the C<cmp> operation.

=head2 stringify

Like C<add()> but affects the C<""> operation.

=head2 subtract

Like C<add()> but affects the C<-> operation.

=head2 throw_single_exception

Like C<skip_checks()>, but affects C<$ThrowSingleException>.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://rt.cpan.org/Public/Dist/Display.html?Name=Class-Value>.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit L<http://www.perl.com/CPAN/> to find a CPAN
site near you, or see
L<http://search.cpan.org/dist/Class-Value/>.

The development version lives at
L<http://github.com/hanekomu/Class-Value/>.
Instead of sending patches, please fork this project using the standard git
and github infrastructure.

=head1 AUTHOR

  Marcel Gruenauer <marcel@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2004 by Marcel Gruenauer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

