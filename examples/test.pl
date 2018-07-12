#!/usr/bin/env perl

use warnings;
use strict;
use lib '../lib';

use Daedalus::Iris;
use String::Random;

my $random_string = new String::Random;
my $random        = $random_string->randpattern( 's' x 32 );

our $smtpserver   = $ENV{'IRIS_SMTP_SERVER'};
our $smtpport     = $ENV{'IRIS_SMTP_PORT'};
our $smtpuser     = $ENV{'IRIS_SMTP_USER'};
our $smtppassword = $ENV{'IRIS_SMTP_PASSWORD'};
our $emailto      = $ENV{'IRIS_EMAIL_TO'};
our $emailfrom    = $ENV{'IRIS_EMAIL_FROM'};

my $IRIS = Daedalus::Iris->new('email');

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

$iris->send();

