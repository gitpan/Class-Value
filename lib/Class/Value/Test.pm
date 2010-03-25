use 5.008;
use strict;
use warnings;

package Class::Value::Test;
our $VERSION = '1.100840';
# ABSTRACT: Base class for testing value objects
use Test::More;
use Class::Value;
use parent 'Data::Semantic::Test';

sub run {
    my $self = shift;
    $Class::Value::SkipChecks = 0;
    $self->SUPER::run(@_);
}
1;


__END__
=pod

=head1 NAME

Class::Value::Test - Base class for testing value objects

=head1 VERSION

version 1.100840

=head1 DESCRIPTION

This is just a subclass of L<Data::Semantic::Test> so that specific value
object test classes can inherit from it. They don't inherit from
L<Data::Semantic::Test> directly because methods common to all value class tests
might emerge and they'd go into this class.

=head1 METHODS

=head2 run

Before calling the superclass' C<run()> method, it tell L<Class::Value> not to
skip checks.

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

