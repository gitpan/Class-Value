use 5.008;
use strict;
use warnings;

package Class::Value::Boolean;
our $VERSION = '1.100840';
# ABSTRACT: A boolean value object
use parent 'Class::Value::Enum';
sub get_valid_values_list { (0, 1) }

sub get_value_normalization_hashref {
    {   J => 1,
        j => 1,
        Y => 1,
        y => 1,
        N => 0,
        n => 0,
    };
}

# override to just use the value, no denormalization
sub as_plaintext { $_[0]->value }
1;


__END__
=pod

=head1 NAME

Class::Value::Boolean - A boolean value object

=head1 VERSION

version 1.100840

=head1 SYNOPSIS

    my $v = Class::Value::Boolean->new('Y');

=head1 DESCRIPTION

This is an enumerator value object that only accepts the value 0 and 1.

=head1 METHODS

=head2 as_plaintext

Returns the value.

=head2 get_valid_values_list

Returns the list of valid values: 0 and 1.

=head2 get_value_normalization_hashref

Returns a hash reference that shows how to normalize values. Any of the
characters C<[JjYy]> will be normalized to 1, any of the characters C<[Nn]>
will be normalized to 0.

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

