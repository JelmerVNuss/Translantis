# -*- Mode: CPerl -*-
use Test::More;
use DDC::Any qw(:none);
#use lib qw(../lib);
no warnings 'once';

if (!DDC::Any->have_xs()) {
  plan skip_all => 'DDC::XS '.($DDC::XS::VERSION ? "v$DDC::XS::VERSION is too old" : 'not available');
} else {
  plan tests => 5;
}

##-- +5: traverse
DDC::Any->import(':xs');
sub xtest {
  my ($class,@args) = @_;
  my $prefix = "DDC::Any";
  my $q = "${prefix}::${class}"->new(@args);
  $q = $q->mapTraverse(sub {
			 my $nod = shift;
			 $nod->setExpanders(['x'])
			   if (UNIVERSAL::isa($nod,"${prefix}::CQTokInfl") && !@{$nod->getExpanders});
			 return $nod;
		       });
  return $q->toString;
}
like(xtest('CQTokExact','','foo'), qr/^\@'?foo'?$/, 'traverse : @foo');
like(xtest('CQTokInfl', '','foo'), qr/^'?foo'?\s*\|'?x'?$/,'traverse : foo');
like(xtest('CQTokInfl', '','foo',['-']), qr/^'?foo'?\s*\|'?-'?$/, 'traverse : foo|-');
like(xtest('CQTokSetInfl','',['bar','foo']), qr/^\{'?bar'?,'?foo'?\}\s*\|'?x'?$/,'traverse : {bar,foo}');
like(xtest('CQTokSetInfl','',['bar','foo'],['-']), qr/^\{'?bar'?,'?foo'?\}\s*\|'?-'?$/,'traverse : {bar,foo}|-');

print "\n";
