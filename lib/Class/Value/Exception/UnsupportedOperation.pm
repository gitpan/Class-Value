package Class::Value::Exception::UnsupportedOperation;

use warnings;
use strict;


our $VERSION = '0.02';


use base 'Class::Value::Exception';


__PACKAGE__->mk_scalar_accessors(qw(opname));


use constant default_message =>
    'Value object of type [%s], value [%s], does not support operation [%s]';


use constant PROPERTIES => ( 'opname' );


1;


__END__

=head1 NAME

Class::Value::Exception::UnsupportedOperation - unsupported operation exception

=head1 SYNOPSIS

None; this class is internal.

=head1 DESCRIPTION

This exception is thrown by Class::Value if you attempt to use a value object
in a way that has not been defined for it (i.e., the operation doesn't have an
overload defined for it).

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

