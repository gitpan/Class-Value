package Class::Value::Exception::UnsupportedOperation;
use warnings;
use strict;
our $VERSION = '0.07';
use base 'Class::Value::Exception';
__PACKAGE__->mk_scalar_accessors(qw(opname));
use constant default_message =>
  'Value object of type [%s], value [%s], does not support operation [%s]';
use constant PROPERTIES => ('opname');
1;
__END__



=head1 NAME

Class::Value::Exception::UnsupportedOperation - unsupported operation exception

=head1 SYNOPSIS

    # None; this class is internal.

=head1 DESCRIPTION

This exception is thrown by Class::Value if you attempt to use a value object
in a way that has not been defined for it (i.e., the operation doesn't have an
overload defined for it).

=head1 METHODS

=over 4

=item C<clear_opname>

    $obj->clear_opname;

Clears the value.

=item C<opname>

    my $value = $obj->opname;
    $obj->opname($value);

A basic getter/setter method. If called without an argument, it returns the
value. If called with a single argument, it sets the value.

=item C<opname_clear>

    $obj->opname_clear;

Clears the value.

=back

Class::Value::Exception::UnsupportedOperation inherits from
L<Class::Value::Exception>.

The superclass L<Class::Value::Exception> defines these methods and
functions:

    clear_ref(), clear_value(), ref(), ref_clear(), value(), value_clear()

The superclass L<Error::Hierarchy> defines these methods and functions:

    acknowledged(), acknowledged_clear(), acknowledged_set(),
    clear_acknowledged(), clear_is_optional(), comparable(), error_depth(),
    get_properties(), init(), is_optional(), is_optional_clear(),
    is_optional_set(), properties_as_hash(), set_acknowledged(),
    set_is_optional(), stringify(), transmute()

The superclass L<Error::Hierarchy::Base> defines these methods and
functions:

    new(), dump_as_yaml(), dump_raw()

The superclass L<Error> defines these methods and functions:

    _throw_Error_Simple(), associate(), catch(), file(), flush(), import(),
    object(), prior(), record(), text(), throw(), with()

The superclass L<Data::Inherited> defines these methods and functions:

    every_hash(), every_list(), flush_every_cache_by_key()

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
site near you. Or see L<http://search.cpan.org/dist/Class-Value/>.

=head1 AUTHORS

Marcel GrE<uuml>nauer, C<< <marcel@cpan.org> >>

=head1 COPYRIGHT AND LICENSE

Copyright 2004-2009 by the authors.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

