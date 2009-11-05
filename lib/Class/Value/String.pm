package Class::Value::String;
use strict;
use warnings;
our $VERSION = '0.07';
use base 'Class::Value';
__PACKAGE__->mk_class_scalar_accessors(qw(string_delegate));
use constant HYGIENIC => ('string_delegate');

sub charset_handler {
    my $self = shift;

    # Do we even have a delegate from which we can get the information?
    my $string_delegate = $self->string_delegate;
    return
      unless ref($string_delegate)
          && UNIVERSAL::can($string_delegate, 'get_charset_handler_for');
    $string_delegate->get_charset_handler_for($self);
}

sub max_length {
    my $self = shift;

    # Do we even have a delegate from which we can get the information?
    my $string_delegate = $self->string_delegate;
    return 0
      unless ref($string_delegate)
          && UNIVERSAL::can($string_delegate, 'get_max_length_for');
    $string_delegate->get_max_length_for($self);
}

sub is_valid_normalized_value {
    my ($self, $value) = @_;
    return 0 unless $self->SUPER::is_valid_normalized_value($value);
    $self->is_valid_string_value($value);
}

sub is_valid_string_value {
    my ($self, $value) = @_;

    # string can be undef
    return 1 unless defined($value) && length($value);
    $self->max_length && return 0 if length($value) > $self->max_length;
    local $_ = $self->charset_handler;
    return 1 unless ref $_ && $_->can('is_valid_string');
    $_->is_valid_string($value);
}
1;
__END__



=head1 NAME

Class::Value::String - the Value Object design pattern

=head1 SYNOPSIS

    Class::Value::String->new;

=head1 DESCRIPTION

None yet. This is an early release; fully functional, but undocumented. The
next release will have more documentation.

=head1 METHODS

=over 4

=item C<clear_string_delegate>

    $obj->clear_string_delegate;

Clears the value. Since this is a class variable, the value will be undefined
for all instances of this class.

=item C<string_delegate>

    my $value = $obj->string_delegate;
    $obj->string_delegate($value);

A basic getter/setter method. This is a class variable, so it is shared
between all instances of this class. Changing it in one object will change it
for all other objects as well. If called without an argument, it returns the
value. If called with a single argument, it sets the value.

=item C<string_delegate_clear>

    $obj->string_delegate_clear;

Clears the value. Since this is a class variable, the value will be undefined
for all instances of this class.

=back

Class::Value::String inherits from L<Class::Value>.

The superclass L<Class::Value> defines these methods and functions:

    new(), MUNGE_CONSTRUCTOR_ARGS(), check(), clear_exception_container(),
    clear_notify_delegate(), comparable(), exception_container(),
    exception_container_clear(), get_value(), init(), is_defined(),
    is_valid(), is_valid_value(), is_well_formed(), is_well_formed_value(),
    normalize(), normalize_value(), notify_delegate(),
    notify_delegate_clear(), run_checks(),
    run_checks_with_exception_container(), send_notify_value_invalid(),
    send_notify_value_normalized(), send_notify_value_not_wellformed(),
    set_value(), skip_checks(), skip_dirtying(), skip_normalizations(),
    str_cmp(), stringify(), throw_single_exception(), value()

The superclass L<Class::Accessor::Complex> defines these methods and
functions:

    mk_abstract_accessors(), mk_array_accessors(), mk_boolean_accessors(),
    mk_class_array_accessors(), mk_class_hash_accessors(),
    mk_class_scalar_accessors(), mk_concat_accessors(),
    mk_forward_accessors(), mk_hash_accessors(), mk_integer_accessors(),
    mk_new(), mk_object_accessors(), mk_scalar_accessors(),
    mk_set_accessors(), mk_singleton()

The superclass L<Class::Accessor> defines these methods and functions:

    _carp(), _croak(), _mk_accessors(), accessor_name_for(),
    best_practice_accessor_name_for(), best_practice_mutator_name_for(),
    follow_best_practice(), get(), make_accessor(), make_ro_accessor(),
    make_wo_accessor(), mk_accessors(), mk_ro_accessors(),
    mk_wo_accessors(), mutator_name_for(), set()

The superclass L<Class::Accessor::Installer> defines these methods and
functions:

    install_accessor()

The superclass L<Class::Accessor::Constructor> defines these methods and
functions:

    _make_constructor(), mk_constructor(), mk_constructor_with_dirty(),
    mk_singleton_constructor()

The superclass L<Data::Inherited> defines these methods and functions:

    every_hash(), every_list(), flush_every_cache_by_key()

The superclass L<Class::Accessor::Constructor::Base> defines these methods
and functions:

    STORE(), clear_dirty(), clear_hygienic(), clear_unhygienic(),
    contains_hygienic(), contains_unhygienic(), delete_hygienic(),
    delete_unhygienic(), dirty(), dirty_clear(), dirty_set(),
    elements_hygienic(), elements_unhygienic(), hygienic(),
    hygienic_clear(), hygienic_contains(), hygienic_delete(),
    hygienic_elements(), hygienic_insert(), hygienic_is_empty(),
    hygienic_size(), insert_hygienic(), insert_unhygienic(),
    is_empty_hygienic(), is_empty_unhygienic(), set_dirty(),
    size_hygienic(), size_unhygienic(), unhygienic(), unhygienic_clear(),
    unhygienic_contains(), unhygienic_delete(), unhygienic_elements(),
    unhygienic_insert(), unhygienic_is_empty(), unhygienic_size()

The superclass L<Tie::StdHash> defines these methods and functions:

    CLEAR(), DELETE(), EXISTS(), FETCH(), FIRSTKEY(), NEXTKEY(), SCALAR(),
    TIEHASH()

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://rt.cpan.org>.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit <http://www.perl.com/CPAN/> to find a CPAN
site near you. Or see L<http://search.cpan.org/dist/Class-Value/>.

=head1 AUTHORS

Marcel GrE<uuml>nauer, C<< <marcel@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2004-2009 by the authors.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut
