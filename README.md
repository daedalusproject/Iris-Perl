# Iris-Perl

[![pipeline status](https://git.daedalus-project.io/daedalusproject/Iris-Perl/badges/master/pipeline.svg)](https://git.daedalus-project.io/daedalusproject/Iris-Perl/commits/master)[![Build Status](https://travis-ci.org/daedalusproject/Iris-Perl.svg?branch=develop)](https://travis-ci.org/daedalusproject/Iris-Perl)[![codecov](https://codecov.io/gh/daedalusproject/Iris-Perl/branch/develop/graph/badge.svg)](https://codecov.io/gh/daedalusproject/Iris-Perl)

Daedalus Project Notification sender service. Send any type of notification thrught, emails, slack, etc

## e-mails

Iris::Emails is able to send e-mails using ssl 'starttls' smtp server (I am currently using AWS SES)

****example*

```perl
use Daedalus::Iris;

my $IRIS = Daedalus::Iris->new('email');

my $random_string = new String::Random;
my $random        = $random_string->randpattern( 's' x 32 );

my $mocked_email = mock();

my $smtpserver   = 'some.server.com';
my $smtpport     = '25';
my $smtpuser     = 'user';
my $smtppassword = 'password';
my $emailto      = 'me@example.com';
my $emailfrom    = 'no-reply@example.com';

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

$iris->send(); #It Works

```
