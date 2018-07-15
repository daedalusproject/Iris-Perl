requires 'Devel::Cover::Report::Codecov', 0.22;
requires 'Moose';
requires 'MooseX::NonMoose';
requires 'MooseX::StrictConstructor';
requires 'Module::PluginFinder';
requires 'Class::Factory';
requires 'XML::Parser';
requires 'String::Random';
requires 'Data::Validate::Domain';
requires 'Email::Valid';
requires 'Email::Stuffer';
requires 'Email::Sender::Transport::SMTPS';
requires 'Test::Most';
requires 'Test::MockModule';

recommends 'Pod::Usage';

on test => sub {
    requires 'Test::More',       1.302120;
    requires 'Test::Class',      0.50;
    requires 'Test::MockModule', 0.13;
    requires 'Devel::Mutator',   0.03;
};
