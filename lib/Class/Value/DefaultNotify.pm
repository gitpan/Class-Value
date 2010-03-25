use 5.008;
use strict;
use warnings;

package Class::Value::DefaultNotify;
our $VERSION = '1.100840';
# ABSTRACT: Default notification delegate for value objects
use parent 'Class::Value::Notify';

sub notify_value_not_wellformed {
    my ($self, $ref, $value) = @_;
    throw Class::Value::Exception::NotWellFormedValue(
        ref   => $ref,
        value => $value,
    );
}

sub notify_value_invalid {
    my ($self, $ref, $value) = @_;
    throw Class::Value::Exception::InvalidValue(
        ref   => $ref,
        value => $value,
    );
}

sub notify_value_normalized {
    my ($self, $ref, $value, $normalized) = @_;

    # do nothing; normalization is ok here
}
1;


__END__
=pod

=head1 NAME

Class::Value::DefaultNotify - Default notification delegate for value objects

=head1 VERSION

version 1.100840

=head1 DESCRIPTION

This class is the default notification delegate used in L<Class::Value>. When
a value object is checked, one or more notifications may be sent, for example,
when setting invalid or non-well-formed values. These notifications are
handled by a delegate. This delegate throws appropriate exception objects.

=head1 METHODS

=head2 notify_value_invalid

Throws a L<Class::Value::Exception::InvalidValue> exception.

=head2 notify_value_normalized

This method is called when a value has been normalized. In this default
notification delegate this is ignored silently.

=head2 notify_value_not_wellformed

Throws a L<Class::Value::Exception::NotWellFormedValue> exception.

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

