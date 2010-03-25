use 5.008;
use strict;
use warnings;

package Class::Value::Exception;
our $VERSION = '1.100840';
# ABSTRACT: Base class for value-related exceptions
use parent 'Class::Value::Exception::Base';
__PACKAGE__->mk_scalar_accessors(qw(ref value));
use constant default_message =>
  'General value object exception for type [%s], value [%s]';
use constant PROPERTIES => (qw/ref value/);


__END__
=pod

=head1 NAME

Class::Value::Exception - Base class for value-related exceptions

=head1 VERSION

version 1.100840

=head1 DESCRIPTION

This is a base class for value object exceptions that are related to the
value. For example, exceptions thrown on setting invalid or non-well-formed
values derive from this class.

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

