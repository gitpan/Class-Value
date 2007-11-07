use inc::Module::Install;
name 'Class-Value';
all_from 'lib/Class/Value.pm';
perl_version '5.006';

requires 'Error::Hierarchy';

build_requires 'Test::More' => '0.70';

use_standard_tests(without => 'pod_coverage');
auto_include;
WriteAll;
