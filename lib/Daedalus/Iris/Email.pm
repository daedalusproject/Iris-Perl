package Daedalus::Iris::Email;

use 5.006;
use strict;
use warnings;

use Moose;
use Carp qw /croak/;
use Data::Validate::Domain qw(is_domain);
use Email::Valid;
use Email::Sender::Simple;
use Email::Stuffer;
use Email::Sender::Transport::SMTPS ();
use base qw( Daedalus::Iris );

use namespace::autoclean;

=head1 NAME

Daedalus::Iris::Email - Daedalus Project e-mail Notification sender service.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

Service which send e-mails

Any Iris object must be instanced with:
  id -> Iris alphanumeric string
  smtpserver-> Valid URL containing smpt server
  smtpport -> Valid server port
  smtpuser -> SMTP user
  smtpassword -> SMTP passowrd
  emailfrom -> SMPT valid e-mail from
  emailto -> Receiver valid e-mail address
  subject -> Subject
  body -> Text of your message
=cut

has 'smtpserver'  => ( is => 'ro', isa => 'Str', required => 1 );
has 'smtpport'    => ( is => 'ro', isa => 'Int', required => 1 );
has 'smtpuser'    => ( is => 'ro', isa => 'Str', required => 1 );
has 'smtpassword' => ( is => 'ro', isa => 'Str', required => 1 );
has 'emailfrom'   => ( is => 'ro', isa => 'Str', required => 1 );
has 'emailto'     => ( is => 'ro', isa => 'Str', required => 1 );
has 'subject'     => ( is => 'ro', isa => 'Str', required => 1 );
has 'body'        => ( is => 'ro', isa => 'Str', required => 1 );

=head1 SUBROUTINES/METHODS

=head2 BUILD

Validates attributes.

=cut

sub BUILD {
    my $self = shift;

    croak "smtpserver value is not a valid URL"
      unless ( is_domain( $self->smtpserver ) );
    croak "smtpport value must be greater than zero" if ( $self->smtpport < 1 );
    croak "smtpport value must be lower than 65535"
      if ( $self->smtpport > 65535 );
    croak "emailfrom value must be a valid e-mail address."
      unless ( Email::Valid->address( $self->emailfrom ) );
    croak "emailto value must be a valid e-mail address"
      unless ( Email::Valid->address( $self->emailto ) );

    return $self;
}

=head2 _send

Send e-mail notification.

=cut

sub _send {
    my $self = shift;

    my $email = Email::Stuffer->from( $self->emailfrom )->to( $self->emailto )
      ->subject( $self->subject )->html_body( $self->body )->email;
    my $transport = Email::Sender::Transport::SMTPS->new(
        {
            host          => $self->smtpserver,
            port          => $self->smtpport,
            ssl           => "starttls",
            sasl_username => $self->smtpuser,
            sasl_password => $self->smtpassword,

        }
    );
    Email::Sender::Simple::sendmail( $email, { transport => $transport } );

}

=head1 AUTHOR

Álvaro Castellano Vela, C<< <alvaro.castellano.vela at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-daedalus-iris at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Daedalus-Iris>.  I will be notified, and then you'll
use Email::Valid;
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Daedalus::Iris::Email


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Daedalus-Iris>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Daedalus-Iris>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Daedalus-Iris>

=item * Search CPAN

L<http://search.cpan.org/dist/Daedalus-Iris/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2018 Álvaro Castellano Vela.

This program is free software; you can redistribute it and/or modify it
under the terms of the GNU GENERAL PUBLIC LICENSE Version 3.

=cut

1;    # End of Daedalus::Iris::Email
