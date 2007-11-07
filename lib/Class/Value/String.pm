package Class::Value::String;

# $Id: String.pm 13667 2007-11-07 08:14:13Z gr $

use strict;
use warnings;


our $VERSION = '0.02';


use base 'Class::Value';


__PACKAGE__->mk_class_scalar_accessors(qw(string_delegate));


use constant HYGIENIC => ('string_delegate');


sub charset_handler {
    my $self = shift;

    # Do we even have a delegate from which we can get the information?
    my $string_delegate = $self->string_delegate;
    return unless
        ref($string_delegate) &&
        UNIVERSAL::can($string_delegate, 'get_charset_handler_for');

    $string_delegate->get_charset_handler_for($self);
}


sub max_length {
    my $self = shift;

    # Do we even have a delegate from which we can get the information?
    my $string_delegate = $self->string_delegate;
    return 0 unless
        ref($string_delegate) &&
        UNIVERSAL::can($string_delegate, 'get_max_length_for');

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

