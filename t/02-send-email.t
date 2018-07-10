#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More tests => 1;
use Test::Exception;
use String::Random;

BEGIN {
    use_ok('Daedalus::Iris') || print "Bail out!\n";
}

my $IRIS = Daedalus::Iris->new('email');

my $random_string = new String::Random;
my $random        = $random_string->randpattern( 's' x 32 );

our $smtpserver   = $ENV{'IRIS_SMTP_SERVER'};
our $smtpport     = $ENV{'IRIS_SMTP_PORT'};
our $smtpuser     = $ENV{'IRIS_SMTP_USER'};
our $smtppassword = $ENV{'IRIS_SMTP_PASSWORD'};
our $emailto      = $ENV{'IRIS_EMAIL_TO'};
our $emailfrom    = $ENV{'IRIS_EMAIL_FROM'};

my $iris = $IRIS->new(
    {
        id          => $random,
        smtpserver  => $smtpserver,
        smtpport    => $smtpport,
        smtpuser    => $smtpuser,
        smtpassword => $smtppassword,
        emailfrom   => $emailfrom,
        emailto     => $emailto,
        subject     => 'some imporant subject',
        body        => 'Hello',
    }
);

ok( $iris->send(), "Send E-mail" );

diag("Testing Daedalus::Iris $Daedalus::Iris::VERSION, Perl $], $^X");
