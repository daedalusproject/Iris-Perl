package TestsFor::Daedalus::Iris::Email;

use Test::Most;
use base 'TestsFor';

use Test::MockModule;
use String::Random;

use Daedalus::Iris::Email;

sub class_to_test { 'Daedalus::Iris::Email' }

sub startup : Tests(startup) {
    my $test  = shift;
    my $class = $test->class_to_test;
}

sub send_email : Tests(1) {
    my $IRIS = Daedalus::Iris->new('email');

    my $random_string = new String::Random;
    my $random        = $random_string->randpattern( 's' x 32 );

    my $mocked_email = mock();

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

    ok $iris->send(), "Send E-mail";

}

sub mock {

    my $mocked_email = Test::MockModule->new('Email::Sender::Simple');
    $mocked_email->mock( 'send', sub { return 1; } );

    return $mocked_email;

}

1;
