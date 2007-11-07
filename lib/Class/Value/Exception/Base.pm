package Class::Value::Exception::Base;

# $Id: Base.pm 13653 2007-10-22 09:11:20Z gr $

use warnings;
use strict;


our $VERSION = '0.02';


# Base class to mark exceptions thrown by value classes; all such exceptions
# should subclass this class.

use base qw(Error::Hierarchy Class::Accessor::Complex);


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

