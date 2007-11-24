package Class::Value::Test;

# $Id: Test.pm 13666 2007-11-07 07:53:28Z gr $

use strict;
use warnings;
use Test::More;


our $VERSION = '0.04';


use base 'Data::Semantic::Test';


1;


__END__



=head1 NAME

Class::Value::Test - Testing value objects

=head1 SYNOPSIS

    Class::Value::Test->new;

=head1 DESCRIPTION

This is just a subclass of L<Data::Semantic::Test> so that specific value
object test classes can inherit from it. They don't inherit from
Data::Semantic::Test directly because methods common to all value class tests
might emerge and they'd go into this class.

Class::Value::Test inherits from L<Data::Semantic::Test>.

The superclass L<Data::Semantic::Test> defines these methods and functions:

    PLAN(), munge_args(), run(), test_is_invalid(), test_is_valid()

The superclass L<Test::CompanionClasses::Base> defines these methods and
functions:

    new(), clear_package(), make_real_object(), package(), package_clear(),
    planned_test_count()

The superclass L<Class::Accessor::Complex> defines these methods and
functions:

    carp(), cluck(), croak(), flatten(), mk_abstract_accessors(),
    mk_array_accessors(), mk_boolean_accessors(),
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

    install_accessor(), subname()

The superclass L<Data::Inherited> defines these methods and functions:

    every_hash(), every_list(), flush_every_cache_by_key()

=head1 METHODS

=over 4



=back

=head1 TAGS

If you talk about this module in blogs, on del.icio.us or anywhere else,
please use the C<classvalue> tag.

=head1 VERSION 
                   
This document describes version 0.04 of L<Class::Value::Test>.

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

