use strict;
use warnings;
use Test::More;
use Test::Output;
plan(tests => 4);
use lib qw(../lib lib);
use PSGI::Hector::Log;
use Mock::Sub no_warnings => 1;

my $mock = Mock::Sub->new;
my $getOption = $mock->mock('PSGI::Hector::Log::getOption');

stderr_is {
	PSGI::Hector::Log->log('message');
} " - message\n", "Without severity";

stderr_is {
	PSGI::Hector::Log->log('message', 'info');
} "INFO - message\n", "With info severity";

stderr_is {
	PSGI::Hector::Log->log('message', 'debug');
} "", "With debug severity without debug mode";

$getOption->return_value(1);

stderr_is {
	PSGI::Hector::Log->log('message', 'debug');
} "DEBUG - message\n", "With debug severity with debug mode";
