package Class::Value::Exception::NotWellFormedValue;

# $Id: NotWellFormedValue.pm 9003 2005-05-12 13:33:49Z gr $

use warnings;
use strict;


our $VERSION = '0.04';


use base 'Class::Value::Exception';


use constant default_message =>
    'Value object of type [%s] does not accept not well-formed value [%s]';

1;


__END__



=head1 NAME

Class::Value::Exception::NotWellFormedValue - the Value Object design pattern

=head1 SYNOPSIS

    Class::Value::Exception::NotWellFormedValue->new;

=head1 DESCRIPTION

None yet. This is an early release; fully functional, but undocumented. The
next release will have more documentation.

Class::Value::Exception::NotWellFormedValue inherits from
L<Class::Value::Exception>.

The superclass L<Class::Value::Exception> defines these methods and
functions:

    PROPERTIES(), clear_ref(), clear_value(), ref(), ref_clear(), value(),
    value_clear()

The superclass L<Error::Hierarchy> defines these methods and functions:

    NameSpace_DNS(), NameSpace_OID(), NameSpace_URL(), NameSpace_X500(),
    _depth_accessor(), _exception_hostname_accessor(),
    _filename_accessor(), _line_accessor(), _message_accessor(),
    _package_accessor(), _stacktrace_accessor(), _uuid_accessor(),
    acknowledged(), acknowledged_clear(), acknowledged_set(), carp(),
    clear_acknowledged(), clear_is_optional(), comparable(), confess(),
    croak(), depth(), error_depth(), exception_hostname(), filename(),
    get_properties(), hostname(), init(), is_optional(),
    is_optional_clear(), is_optional_set(), line(), message(), package(),
    properties_as_hash(), set_acknowledged(), set_is_optional(),
    stacktrace(), stringify(), transmute(), uuid()

The superclass L<Error::Hierarchy::Base> defines these methods and
functions:

    new(), (""(), ()(), (cmp(), dump_as_yaml(), dump_raw()

The superclass L<Error> defines these methods and functions:

    (0+(), (bool(), _throw_Error_Simple(), associate(), catch(), file(),
    flush(), import(), object(), prior(), record(), text(), throw(), with()

The superclass L<Data::Inherited> defines these methods and functions:

    every_hash(), every_list(), flush_every_cache_by_key()

The superclass L<Class::Accessor::Complex> defines these methods and
functions:

    cluck(), flatten(), mk_abstract_accessors(), mk_array_accessors(),
    mk_boolean_accessors(), mk_class_array_accessors(),
    mk_class_hash_accessors(), mk_class_scalar_accessors(),
    mk_concat_accessors(), mk_forward_accessors(), mk_hash_accessors(),
    mk_integer_accessors(), mk_new(), mk_object_accessors(),
    mk_scalar_accessors(), mk_set_accessors(), mk_singleton()

The superclass L<Class::Accessor> defines these methods and functions:

    _carp(), _croak(), _mk_accessors(), accessor_name_for(),
    best_practice_accessor_name_for(), best_practice_mutator_name_for(),
    follow_best_practice(), get(), make_accessor(), make_ro_accessor(),
    make_wo_accessor(), mk_accessors(), mk_ro_accessors(),
    mk_wo_accessors(), mutator_name_for(), set()

The superclass L<Class::Accessor::Installer> defines these methods and
functions:

    install_accessor(), subname()

=head1 METHODS

=over 4



=back

=head1 TAGS

If you talk about this module in blogs, on del.icio.us or anywhere else,
please use the C<classvalue> tag.

=head1 VERSION 
                   
This document describes version 0.04 of L<Class::Value::Exception::NotWellFormedValue>.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<<bug-class-value@rt.cpan.org>>, or through the web interface at
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

Copyright 2004-2007 by Marcel GrE<uuml>nauer

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut

