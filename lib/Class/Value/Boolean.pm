package Class::Value::Boolean;

# $Id: Boolean.pm 11570 2006-06-06 13:29:50Z gr $

use strict;
use warnings;


our $VERSION = '0.01';


use base 'Class::Value::Enum';


sub get_valid_values_list           { (0, 1) }

sub get_value_normalization_hashref { {
    J => 1,
    j => 1,
    Y => 1,
    y => 1,
    N => 0,
    n => 0,
} }


# override to just use the value, no denormalization

sub as_plaintext { $_[0]->value }


1;


__END__

=head1 NAME

Class::Value::Boolean - a boolean value object

=head1 SYNOPSIS

    my $v = Class::Value::Boolean->new('Y');

=head1 DESCRIPTION

=head1 TAGS

If you talk about this module in blogs, on del.icio.us or anywhere else,
please use the C<classvalue> tag.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-class-value@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit <http://www.perl.com/CPAN/> to find a CPAN
site near you. Or see <http://www.perl.com/CPAN/authors/id/M/MA/MARCEL/>.

=head1 AUTHOR

Marcel GrE<uuml>nauer, C<< <marcel@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Marcel GrE<uuml>nauer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

