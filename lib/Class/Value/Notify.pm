use 5.008;
use strict;
use warnings;

package Class::Value::Notify;
our $VERSION = '1.100840';
# ABSTRACT: Base class for notification delegates
use parent 'Class::Accessor::Complex';
__PACKAGE__->mk_new;
sub init                        { }
sub notify_value_not_wellformed { }
sub notify_value_invalid        { }
1;


__END__
=pod

=head1 NAME

Class::Value::Notify - Base class for notification delegates

=head1 VERSION

version 1.100840

=head1 DESCRIPTION

This class is the base class for the notification delegate used in
L<Class::Value>. When a value object is checked, one or more notifications may
be sent, for example, when setting invalid or non-well-formed values. These
notifications are handled by a delegate. A delegate might want to throw an
exception on invalid values. See L<Class::Value::DefaultNotify> for an
example.

=head1 METHODS

=head2 init

Empty in this base class; override as necessary in subclasses.

=head2 notify_value_invalid

Empty in this base class; override as necessary in subclasses.

=head2 notify_value_not_wellformed

Empty in this base class; override as necessary in subclasses.

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

