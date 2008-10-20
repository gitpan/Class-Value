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

recommends 'Test::Pod';
recommends 'Test::Pod::Coverage';

test_requires 'Test::More' => '0.70';
test_requires 'Test::Compile';

auto_install;
auto_include;
WriteAll;
