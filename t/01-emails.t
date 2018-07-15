#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More tests => 17;
use Test::Exception;
use String::Random;

BEGIN {
    use_ok('Daedalus::Iris') || print "Bail out!\n";
}

my $IRIS = Daedalus::Iris->new('email');

my $random_string = new String::Random;
my $random        = $random_string->randpattern( 's' x 32 );

throws_ok {
    $IRIS->new(
        {
            smtpserver  => 'valid.url.net',
            smtpport    => 25,
            smtpuser    => 'someuser',
            smtpassword => 'somepassword',
            emailfrom   => 'some@example.com',
            emailto     => 'other@example.com',
            subject     => 'some imporant subject',
            body        => 'Hello',
        }
    );
}
qr/\(id\) is required/,
  "Creating and Daedalus::Iris::Email instance without message id should fail.";

throws_ok {
    $IRIS->new(
        {
            id          => $random,
            smtpport    => 25,
            smtpuser    => 'someuser',
            smtpassword => 'somepassword',
            emailfrom   => 'some@example.com',
            emailto     => 'other@example.com',
            subject     => 'some imporant subject',
            body        => 'Hello',
        }
    );
}
qr/\(smtpserver\) is required/,
  "Creating and Daedalus::Iris::Email instance without smtpserver should fail.";

throws_ok {
    $IRIS->new(
        {
            id          => $random,
            smtpserver  => 'valid.url.net',
            smtpuser    => 'someuser',
            smtpassword => 'somepassword',
            emailfrom   => 'some@example.com',
            emailto     => 'other@example.com',
            subject     => 'some imporant subject',
            body        => 'Hello',
        }
    );
}
qr/\(smtpport\) is required/,
  "Creating and Daedalus::Iris::Email instance without smtpport should fail.";

throws_ok {
    $IRIS->new(
        {
            id          => $random,
            smtpserver  => 'valid.url.net',
            smtpport    => 25,
            smtpassword => 'somepassword',
            emailfrom   => 'some@example.com',
            emailto     => 'other@example.com',
            subject     => 'some imporant subject',
            body        => 'Hello',
        }
    );
}
qr/\(smtpuser\) is required/,
  "Creating and Daedalus::Iris::Email instance without smtpserver should fail.";

throws_ok {
    $IRIS->new(
        {
            id         => $random,
            smtpserver => 'valid.url.net',
            smtpport   => 25,
            smtpuser   => 'someuser',
            emailfrom  => 'some@example.com',
            emailto    => 'other@example.com',
            subject    => 'some imporant subject',
            body       => 'Hello',
        }
    );
}
qr/\(smtpassword\) is required/,
  "Creating and Daedalus::Iris::Email instance without smtpserver should fail.";

throws_ok {
    $IRIS->new(
        {
            id          => $random,
            smtpserver  => 'valid.url.net',
            smtpport    => 25,
            smtpuser    => 'someuser',
            smtpassword => 'somepassword',
            emailto     => 'other@example.com',
            subject     => 'some imporant subject',
            body        => 'Hello',
        }
    );
}
qr/\(emailfrom\) is required/,
  "Creating and Daedalus::Iris::Email instance without emailfrom should fail.";

throws_ok {
    $IRIS->new(
        {
            id          => $random,
            smtpserver  => 'valid.url.net',
            smtpport    => 25,
            smtpuser    => 'someuser',
            smtpassword => 'somepassword',
            emailfrom   => 'some@example.com',
            subject     => 'some imporant subject',
            body        => 'Hello',
        }
    );
}
qr/\(emailto\) is required/,
  "Creating and Daedalus::Iris::Email instance without emailto should fail.";

throws_ok {
    $IRIS->new(
        {
            id          => $random,
            smtpserver  => 'valid.url.net',
            smtpport    => 25,
            smtpuser    => 'someuser',
            smtpassword => 'somepassword',
            emailfrom   => 'some@example.com',
            emailto     => 'other@example.com',
            body        => 'Hello',
        }
    );
}
qr/\(subject\) is required/,
  "Creating and Daedalus::Iris::Email instance without subject should fail.";

throws_ok {
    $IRIS->new(
        {
            id          => $random,
            smtpserver  => 'valid.url.net',
            smtpport    => 25,
            smtpuser    => 'someuser',
            smtpassword => 'somepassword',
            emailfrom   => 'some@example.com',
            emailto     => 'other@example.com',
            subject     => 'some imporant subject',
        }
    );
}
qr/\(body\) is required/,
  "Creating and Daedalus::Iris::Email instance without body should fail.";

throws_ok {
    $IRIS->new(
        {
            id          => $random,
            smtpserver  => 'somenonsenseserver',
            smtpport    => 25,
            smtpuser    => 'someuser',
            smtpassword => 'somepassword',
            emailfrom   => 'some@example.com',
            emailto     => 'other@example.com',
            subject     => 'some imporant subject',
            body        => 'Hello',
        }
    );
}
qr/smtpserver value is not a valid URL/,
  "Creating and Daedalus::Iris::Email with invalid URL's should fail.";

throws_ok {
    $IRIS->new(
        {
            id          => $random,
            smtpserver  => 'email-smtp.us-west-2.amazonaws.com',
            smtpport    => -25,
            smtpuser    => 'someuser',
            smtpassword => 'somepassword',
            emailfrom   => 'some@example.com',
            emailto     => 'other@example.com',
            subject     => 'some imporant subject',
            body        => 'Hello',
        }
    );
}
qr/smtpport value must be greater than zero/,
  "Creating and Daedalus::Iris::Email with invalid port number should fail.";

throws_ok {
    $IRIS->new(
        {
            id          => $random,
            smtpserver  => 'valid.url.net',
            smtpport    => 0,
            smtpuser    => 'someuser',
            smtpassword => 'somepassword',
            emailfrom   => 'some@example.com',
            emailto     => 'other@example.com',
            subject     => 'some imporant subject',
            body        => 'Hello',
        }
    );
}
qr/smtpport value must be greater than zero/,
  "Creating and Daedalus::Iris::Email with invalid port number should fail.";

throws_ok {
    $IRIS->new(
        {
            id          => $random,
            smtpserver  => 'valid.url.net',
            smtpport    => 70000,
            smtpuser    => 'someuser',
            smtpassword => 'somepassword',
            emailfrom   => 'some@example.com',
            emailto     => 'other@example.com',
            subject     => 'some imporant subject',
            body        => 'Hello',
        }
    );
}
qr/smtpport value must be lower than 65535/,
  "Creating and Daedalus::Iris::Email with invalid port number should fail.";

throws_ok {
    $IRIS->new(
        {
            id          => $random,
            smtpserver  => 'valid.url.net',
            smtpport    => 25,
            smtpuser    => 'someuser',
            smtpassword => 'somepassword',
            emailfrom   => 'someexample.com',
            emailto     => 'other@example.com',
            subject     => 'some imporant subject',
            body        => 'Hello',
        }
    );
}
qr/emailfrom value must be a valid e-mail address/,
  "Creating and Daedalus::Iris::Email with invalid e-mail should fail.";

throws_ok {
    $IRIS->new(
        {
            id          => $random,
            smtpserver  => 'valid.url.net',
            smtpport    => 25,
            smtpuser    => 'someuser',
            smtpassword => 'somepassword',
            emailfrom   => 'some@example.com',
            emailto     => 'otherbrokenexample.com',
            subject     => 'some imporant subject',
            body        => 'Hello',
        }
    );
}
qr/emailto value must be a valid e-mail address/,
  "Creating and Daedalus::Iris::Email with invalid e-mail should fail.";

ok(
    $IRIS->new(
        {
            id          => $random,
            smtpserver  => 'valid.url.net',
            smtpport    => 25,
            smtpuser    => 'someuser',
            smtpassword => 'somepassword',
            emailfrom   => 'some@example.com',
            emailto     => 'other@example.com',
            subject     => 'some imporant subject',
            body        => 'Hello',
        }
    ),
    "Creating and Daedalus::Iris::Email."
);

diag("Testing Daedalus::Iris $Daedalus::Iris::VERSION, Perl $], $^X");
