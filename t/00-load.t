#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More tests => 4;
use Test::Exception;

BEGIN {
    use_ok('Daedalus::Iris') || print "Bail out!\n";
}

throws_ok { Daedalus::Iris->new(); }
qr/is not defined in 'Daedalus::Iris'/,
  "Creating an Iris instance without valid factory data.";

throws_ok { Daedalus::Iris->_send(); }
qr/Define _send/,
  "_send function is no defined at implementation";

throws_ok { Daedalus::Iris->_send(); }
qr/Define _send/,
  "send function calls _send function which is no defined at implementation";

diag("Testing Daedalus::Iris $Daedalus::Iris::VERSION, Perl $], $^X");
