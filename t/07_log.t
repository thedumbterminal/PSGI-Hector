use strict;
use warnings;
use Test::More;
use Test::Output;
plan(tests => 2);
use lib qw(../lib lib);
use PSGI::Hector::Log;

stderr_is {
	PSGI::Hector::Log->log('message', 'info');
} "INFO - message\n", "With severity";

stderr_is {
	PSGI::Hector::Log->log('message');
} " - message\n", "Without severity";