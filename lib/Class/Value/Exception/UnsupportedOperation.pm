use 5.008;
use strict;
use warnings;

package Class::Value::Exception::UnsupportedOperation;
our $VERSION = '1.100840';
# ABSTRACT: An unsupported operation was performed on a value object
use parent 'Class::Value::Exception';
__PACKAGE__->mk_scalar_accessors(qw(opname));
use constant default_message =>
  'Value object of type [%s], value [%s], does not support operation [%s]';
use constant PROPERTIES => ('opname');
1;


__END__
=pod

=head1 NAME

Class::Value::Exception::UnsupportedOperation - An unsupported operation was performed on a value object

=head1 VERSION

version 1.100840

=head1 DESCRIPTION

This exception is thrown by L<Class::Value> if you attempt to use a value
object in a way that has not been defined for it, that is, the operation
doesn't have an overload defined for it.

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

