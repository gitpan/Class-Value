use 5.008;
use strict;
use warnings;

package Class::Value::String;
our $VERSION = '1.100840';
# ABSTRACT: String value object with length and character set checking
use parent 'Class::Value';
__PACKAGE__->mk_class_scalar_accessors(qw(string_delegate));
use constant HYGIENIC => ('string_delegate');

sub charset_handler {
    my $self = shift;

    # Do we even have a delegate from which we can get the information?
    my $string_delegate = $self->string_delegate;
    return
      unless ref($string_delegate)
          && UNIVERSAL::can($string_delegate, 'get_charset_handler_for');
    $string_delegate->get_charset_handler_for($self);
}

sub max_length {
    my $self = shift;

    # Do we even have a delegate from which we can get the information?
    my $string_delegate = $self->string_delegate;
    return 0
      unless ref($string_delegate)
          && UNIVERSAL::can($string_delegate, 'get_max_length_for');
    $string_delegate->get_max_length_for($self);
}

sub is_valid_normalized_value {
    my ($self, $value) = @_;
    return 0 unless $self->SUPER::is_valid_normalized_value($value);
    $self->is_valid_string_value($value);
}

sub is_valid_string_value {
    my ($self, $value) = @_;

    # string can be undef
    return 1 unless defined($value) && length($value);
    $self->max_length && return 0 if length($value) > $self->max_length;
    local $_ = $self->charset_handler;
    return 1 unless ref $_ && $_->can('is_valid_string');
    $_->is_valid_string($value);
}
1;


__END__
=pod

=head1 NAME

Class::Value::String - String value object with length and character set checking

=head1 VERSION

version 1.100840

=head1 DESCRIPTION

This is a value object for strings. It can check for string length and
character set restrictions.

=head1 METHODS

=head2 charset_handler

Returns the character set handler for this value object. This method asks the
value object's C<string_delegate()> to get a character set handler. The
character set handler needs to have an C<is_valid_string()> method.

=head2 is_valid_normalized_value

In additional to the checks of this class' superclass, this method also asks
C<is_valid_string_value()>.

=head2 is_valid_string_value

This method verifies that the argument value is not longer than the allowed
maximum length and that the value object's character set handler says that it
is a valid string.

=head2 max_length

Returns the maximum string length for this value object. This method asks the
value object's C<string_delegate()> to get the maximum length.

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

