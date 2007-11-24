use inc::Module::Install;
include 'Module::AutoInstall';

name 'Class-Value';
all_from 'lib/Class/Value.pm';
perl_version '5.006';

requires 'Class::Accessor::Complex';
requires 'Class::Accessor::Constructor';
requires 'Data::Semantic';
requires 'Error::Hierarchy';
requires 'Test::CompanionClasses' => '0.03';

build_requires 'Test::More' => '0.70';

process_templates(
    first_year => 2004,
    rest_from  => "$ENV{HOME}/.mitlib/standard_pod",
    start_tag  => '{%',
    end_tag    => '%}',
);

use_standard_tests(without => 'pod_coverage');
auto_install;
auto_include;
WriteAll;
