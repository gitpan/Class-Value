use 5.008;
use strict;
use warnings;

package Class::Value::Enum;
our $VERSION = '1.100840';
# ABSTRACT: An enumeration value object
use parent 'Class::Value';
sub get_valid_values_list           { () }
sub get_value_normalization_hashref { {} }

sub normalize_value {
    my ($self, $value) = @_;
    $self->normalize_enum_value($value);
}

sub normalize_enum_value {
    my ($self, $value) = @_;
    return unless defined $value;
    my $ref = ref $self;
    our %cache;
    $cache{$ref} ||=
      { map { $_ => 1 } @{ scalar $self->get_valid_values_list } };
    return $value if $cache{$ref}{$value};
    $self->get_value_normalization_hashref->{ lc $value };

    # automatically returns undef if it doesn't exist
}

sub as_plaintext {
    my $self   = shift;
    my %lookup = reverse %{ $self->get_value_normalization_hashref };
    $lookup{ $self->value };
}
1;


__END__
=pod

=head1 NAME

Class::Value::Enum - An enumeration value object

=head1 VERSION

version 1.100840

=head1 DESCRIPTION

This is a value object that only takes one of a given list of values. See
L<Class::Value::Boolean> for an example.

=head1 METHODS

=head2 as_plaintext

Returns the denormalized value, that is, the value that would be normalized to
the currently set value. This obviously only works well if there is a
one-to-one relationships between denormalized and normalized values. If this
is not the case for your specific enumeration value object, then override this
method.

=head2 get_valid_values_list

Returns the list of values that this value object will accept. In this base
class, the empty list is returned, so you will need to override it in subclasses.

=head2 get_value_normalization_hashref

Returns a hash reference that shows how to normalize values. For each hash
entry, the key is the denormalized value and the value is the normalized
value. See L<Class::Value::Boolean> for an example. In this base class, an
empty hash reference is returned, so you will need to override it in
subclasses.

=head2 normalize_enum_value

Normalizes the given value. If the argument is one of the values this value
object can take according to C<get_valid_values_list()> - the result of which
are cached for performance reasons -, then it is returned unaltered, otherwise
C<get_value_normalization_hashref()> is consulted.

=head2 normalize_value

Hands over normalization to C<normalize_enum_value>.

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

