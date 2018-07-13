package TestsFor::Daedalus::Iris::Email;

use Test::Most;
use base 'TestsFor';

use Test::MockModule;
use String::Random;
use Carp qw /croak/;

use Daedalus::Iris::Email;

sub class_to_test { 'Daedalus::Iris::Email' }

sub startup : Tests(startup) {
    my $test  = shift;
    my $class = $test->class_to_test;
}

sub send_email : Tests(2) {
    my $IRIS = Daedalus::Iris->new('email');

    my $random_string = new String::Random;
    my $random        = $random_string->randpattern( 's' x 32 );

    my $mocked_email = mock();

    our $smtpserver   = 'some.server.com';
    our $smtpport     = '25';
    our $smtpuser     = 'user';
    our $smtppassword = 'password';
    our $emailto      = 'me@example.com';
    our $emailfrom    = 'no-reply@example.com';

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

    is_deeply( $iris->send(), { success => 1, message => "Success" } );

    $mocked_email->mock( 'send',
        sub { croak "failed AUTH: Authentication Credentials Invalid"; } );
    is_deeply(
        $iris->send(),
        {
            success => 0,
            message => "failed AUTH: Authentication Credentials Invalid"
        }
    );

}

sub mock {

    my $mocked_email = Test::MockModule->new('Email::Sender::Simple');
    $mocked_email->mock( 'send',
        sub { return { status => 0, message => "Success" }; } );

    return $mocked_email;

}

1;
