package Class::Value::Test;

# $Id: Test.pm 13666 2007-11-07 07:53:28Z gr $

use strict;
use warnings;
use Test::More;


our $VERSION = '0.01';


use base 'Test::CompanionClasses::Base';


use constant well_formed_values     => ();
use constant not_well_formed_values => ();


sub PLAN {
    my $self = shift;

    # make sure $self is an object, not just a package name, so we can call
    # well_formed_values() etc. as methods; subclasses might override and
    # extend well_formed_values() etc.

    $self = $self->new unless ref $self;
    my @well_formed_values = $self->every_list('well_formed_values');
    my @not_well_formed_values = $self->every_list('not_well_formed_values');

    # don't inline the above calls because every_*() behaves strangely in
    # scalar context

    @well_formed_values + @not_well_formed_values;
}


sub run {
    my $self = shift;
    $self->SUPER::run(@_);

    my @well_formed_values     = $self->every_list('well_formed_values');
    my @not_well_formed_values = $self->every_list('not_well_formed_values');

    my $obj = $self->make_real_object;

    ok($obj->is_well_formed_value($_), "well formed: $_")
        for @well_formed_values;
    ok(!$obj->is_well_formed_value($_), "not well formed: $_")
        for @not_well_formed_values;
}


1;


__END__

=head1 NAME

Class::Value - foobar

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

