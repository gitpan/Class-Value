
use strict;
use warnings;

 BEGIN { require 5.008; } 

use ExtUtils::MakeMaker 6.11;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'Class::Value',
                       'DISTNAME' => 'Class-Value',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.11'
                                               },
                       'AUTHOR' => 'Marcel Gruenauer <marcel@cpan.org>',
                       'BUILD_REQUIRES' => {},
                       'ABSTRACT' => 'Implements the Value Object Design Pattern',
                       'EXE_FILES' => [],
                       'VERSION' => '1.100840',
                       'PREREQ_PM' => {
                                        'Scalar::Util' => '0',
                                        'Error' => '0',
                                        'Class::Accessor::Constructor' => '0',
                                        'File::Find' => '0',
                                        'Error::Hierarchy' => '0',
                                        'Error::Hierarchy::Test' => '0',
                                        'Class::Accessor::Complex' => '0',
                                        'Error::Hierarchy::Container' => '0',
                                        'English' => '0',
                                        'parent' => '0',
                                        'Data::Semantic::Test' => '0',
                                        'overload' => '0',
                                        'constant' => '0',
                                        'Carp' => '0',
                                        'Test::More' => '0.88',
                                        'File::Temp' => '0'
                                      },
                       'LICENSE' => 'perl'
                     );


delete $WriteMakefileArgs{LICENSE}
  unless eval { ExtUtils::MakeMaker->VERSION(6.31) };

WriteMakefile(%WriteMakefileArgs);



