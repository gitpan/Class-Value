package Class::Value::DefaultNotify;

use strict;
use warnings;


our $VERSION = '0.06';


use base 'Class::Value::Notify';


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



=head1 NAME

Class::Value::DefaultNotify - the Value Object design pattern

=head1 SYNOPSIS

    Class::Value::DefaultNotify->new;

=head1 DESCRIPTION

None yet. This is an early release; fully functional, but undocumented. The
next release will have more documentation.

=head1 METHODS

=over 4



=back

Class::Value::DefaultNotify inherits from L<Class::Value::Notify>.

The superclass L<Class::Value::Notify> defines these methods and functions:

    new(), init()

The superclass L<Class::Accessor::Complex> defines these methods and
functions:

    mk_abstract_accessors(), mk_array_accessors(), mk_boolean_accessors(),
    mk_class_array_accessors(), mk_class_hash_accessors(),
    mk_class_scalar_accessors(), mk_concat_accessors(),
    mk_forward_accessors(), mk_hash_accessors(), mk_integer_accessors(),
    mk_new(), mk_object_accessors(), mk_scalar_accessors(),
    mk_set_accessors(), mk_singleton()

The superclass L<Class::Accessor> defines these methods and functions:

    _carp(), _croak(), _mk_accessors(), accessor_name_for(),
    best_practice_accessor_name_for(), best_practice_mutator_name_for(),
    follow_best_practice(), get(), make_accessor(), make_ro_accessor(),
    make_wo_accessor(), mk_accessors(), mk_ro_accessors(),
    mk_wo_accessors(), mutator_name_for(), set()

The superclass L<Class::Accessor::Installer> defines these methods and
functions:

    install_accessor()

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests through the web interface at
L<http://rt.cpan.org>.

=head1 INSTALLATION

See perlmodinstall for information and options on installing Perl modules.

=head1 AVAILABILITY

The latest version of this module is available from the Comprehensive Perl
Archive Network (CPAN). Visit <http://www.perl.com/CPAN/> to find a CPAN
site near you. Or see <http://www.perl.com/CPAN/authors/id/M/MA/MARCEL/>.

=head1 AUTHORS

Marcel GrE<uuml>nauer, C<< <marcel@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2004-2008 by the authors.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

