#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Daedalus::Iris' ) || print "Bail out!\n";
}

diag( "Testing Daedalus::Iris $Daedalus::Iris::VERSION, Perl $], $^X" );
