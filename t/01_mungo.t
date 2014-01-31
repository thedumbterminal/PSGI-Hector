use strict;
use warnings;
use Test::More;
plan(tests => 7);
use lib qw(../lib lib);
use PSGI::Hector;

#setup our cgi environment
$ENV{'SCRIPT_NAME'} = "test.cgi";
$ENV{'SERVER_NAME'} = "www.test.com";
$ENV{'HTTP_HOST'} = "www.test.com";
$ENV{'HTTP_REFERER'} = "http://" . $ENV{'HTTP_HOST'};
$ENV{'SERVER_PORT'} = 8080;
$ENV{'REQUEST_URI'} = "/test.cgi";
$ENV{'REQUEST_METHOD'} = 'GET';

my $options = {
	'responsePlugin' => 'PSGI::Hector::Response::Raw',
	'debug' => 1
};

my $m = PSGI::Hector->new($options);
#1
isa_ok($m, "PSGI::Hector");

#2
my $response = $m->getResponse();
isa_ok($response, "PSGI::Hector::Response::Raw");

#3
my $session = $m->getSession();
isa_ok($session, "PSGI::Hector::Session");

#4
my $request = $m->getRequest();
isa_ok($request, "PSGI::Hector::Request");

#5 need to test getthisurl()
is($m->getThisUrl(), "http://www.test.com:8080/test.cgi", "PSGI::Hector::Utils::getThisUrl()");

#6
is($m->getFullUrl(), "http://www.test.com:8080/test.cgi", "PSGI::Hector::getFullUrl()");

#7
is($m->getOption('debug'), 1, "PSGI::Hector::getOption()");
