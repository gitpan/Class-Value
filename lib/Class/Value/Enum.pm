package Class::Value::Enum;

# $Id: Enum.pm 8411 2005-02-16 16:04:09Z gr $

use strict;
use warnings;


our $VERSION = '0.02';


use base 'Class::Value';


sub get_valid_values_list           { () }
sub get_value_normalization_hashref { {} }


sub normalize_value {
    my ($self, $value) = @_;
    $self->normalize_enum_value($value);
}


sub normalize_enum_value {
    my ($self, $value) = @_;
    return unless defined $value;
    return $value if grep { $_ eq $value } $self->get_valid_values_list;
    $self->get_value_normalization_hashref->{lc $value};
    # automatically returns undef if it doesn't exist
}


sub as_plaintext {
    my $self = shift;
    my %lookup = reverse %{ $self->get_value_normalization_hashref };
    $lookup{$self->value};
}


1;


__END__

=head1 NAME

Class::Value - the Value Object design pattern

=head1 SYNOPSIS

None yet (see below).

=head1 DESCRIPTION

None yet. This is an early release; fully functional, but undocumented. The
next release will have more documentation.

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

