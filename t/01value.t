use strict;
use warnings;
use Class::Value;
use Error::Hierarchy::Test 'throws2_ok';
use Test::More tests => 59;
my $n = 42;
my $v = Class::Value->new(value => $n);
test_invalid_op('$v + 1',        add             => '+');
test_invalid_op('$v++',          add             => '++');
test_invalid_op('$v += 3',       add             => '+=');
test_invalid_op('$v - 1',        subtract        => '-');
test_invalid_op('$v--',          subtract        => '--');
test_invalid_op('$v -= 3',       subtract        => '-=');
test_invalid_op('-$v',           subtract        => 'neg');     # unary minus
test_invalid_op('$v * 2',        multiply        => '*');
test_invalid_op('$v *= 2',       multiply        => '*=');
test_invalid_op('$v / 2',        divide          => '/');
test_invalid_op('$v /= 2',       divide          => '/=');
test_invalid_op('$v % 2',        modulo          => '%');
test_invalid_op('$v %= 2',       modulo          => '%=');
test_invalid_op('$v ** 2',       power           => '**');
test_invalid_op('$v **= 2',      power           => '**=');
test_invalid_op('$v << 2',       bit_shift_left  => '<<');
test_invalid_op('$v <<= 2',      bit_shift_left  => '<<=');
test_invalid_op('$v >> 2',       bit_shift_right => '>>');
test_invalid_op('$v >>= 2',      bit_shift_right => '>>=');
test_invalid_op('$v < 2',        num_cmp         => '<');
test_invalid_op('$v <= 2',       num_cmp         => '<=');
test_invalid_op('$v > 2',        num_cmp         => '>');
test_invalid_op('$v >= 2',       num_cmp         => '>=');
test_invalid_op('$v == 2',       num_cmp         => '==');
test_invalid_op('$v != 2',       num_cmp         => '!=');
test_invalid_op('$v <=> 2',      num_cmp         => '<=>');
test_invalid_op('$v & 1',        bit_and         => '&');
test_invalid_op('$v | 1',        bit_or          => '|');
test_invalid_op('$v ^ 1',        bit_xor         => '^');
test_invalid_op('~$v',           bit_not         => '~');
test_invalid_op('atan2($v, $v)', atan2           => 'atan2');
test_invalid_op('cos($v)',       cos             => 'cos');
test_invalid_op('sin($v)',       sin             => 'sin');
test_invalid_op('exp($v)',       exp             => 'exp');
test_invalid_op('log($v)',       log             => 'log');
test_invalid_op('sqrt($v)',      sqrt            => 'sqrt');
test_invalid_op('int($v)',       int             => 'int');
test_invalid_op('<$v>',          iterate         => '<>');

# Do the positive tests after the negative tests as they might alter the value
# and we want to keep comparing to $n.
ok($v->is_well_formed, "$n is a well-formed value");
ok($v->is_valid,       "$n is a valid value");
is("$v", $n, 'valid operation [""]');
is_deeply("$v", $n, 'is_deeply: valid operation [""]');
is($v x 3,     "$n$n$n", 'valid operation [x]');
is('foo' . $v, "foo$n",  'valid operation [.]');
is(($v  ? 'Y' : 'N'), 'Y', "valid operation [bool] is true for value [$n]");
is((!$v ? 'Y' : 'N'), 'N', "valid operation [!] is false for value [$n]");
my $v2 = Class::Value->new(value => 0);
is(($v2  ? 'Y' : 'N'), 'N', 'valid operation [bool] is false for value [0]');
is((!$v2 ? 'Y' : 'N'), 'Y', 'valid operation [!] is true for value [0]');
$v .= 'bar';
$n .= 'bar';
is($v,     $n, 'valid operation [.=]');
is(ref $v, '', 'operation [.=] produces a normal string');
my $v3 = Class::Value->new(value => 'abc');
ok($v3 lt 'bbb', 'valid operation [lt]');
ok($v3 le 'abc', 'valid operation [le]');
ok($v3 gt 'aaa', 'valid operation [lt]');
ok($v3 ge 'abc', 'valid operation [ge]');
ok($v3 eq 'abc', 'valid operation [eq]');
ok($v3 ne 'def', 'valid operation [ne]');
is($v3 cmp 'bbb', -1, 'valid operation [cmp] returning -1');
is($v3 cmp 'abc', 0,  'valid operation [cmp] returning  0');
is($v3 cmp 'aaa', 1,  'valid operation [cmp] returning  1');

sub test_invalid_op {
    my ($code, $method, $op) = @_;
    throws2_ok { eval $code; throw $@ if $@ }
    'Class::Value::Exception::UnsupportedOperation',
"Value object of type [Class::Value], value [$n], does not support operation [$method]",
      "invalid operation [$op]";
}
