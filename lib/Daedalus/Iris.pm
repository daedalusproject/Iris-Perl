package Daedalus::Iris;

use 5.006;
use strict;
use warnings;

use base qw( Class::Factory   );
use Moose;
use Moose::Util::TypeConstraints;
use namespace::autoclean;

=head1 NAME

Daedalus::Iris - Daedalus Project Notification sender service.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

Service which send notifications (e-mails so far)

=cut

has 'id' => ( is => 'ro', isa => 'Str', required => 1 );

=head1 SUBROUTINES/METHODS

=head2 _send

Send notification. This function has to be implemented in Iris implementations

=cut

sub _send { die "Define _send() in implementation" }

=head1 FACTORY

Iris is a factory.

=cut

=head2 Daedalus::Iris::Email

Daedalus::Iris::Email - e-mail driver

=cut

__PACKAGE__->add_factory_type( email => 'Daedalus::Iris::Email' );
__PACKAGE__->add_factory_type( iris  => 'Daedalus::Iris' );

=head1 AUTHOR

Álvaro Castellano Vela, C<< <alvaro.castellano.vela at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-daedalus-iris at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Daedalus-Iris>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Daedalus::Iris


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

1;    # End of Daedalus::Iris
