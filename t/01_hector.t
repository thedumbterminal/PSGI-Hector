use strict;
use warnings;
use Test::More;
plan(tests => 10);
use lib qw(../lib lib);
use PSGI::Hector;

#setup our cgi environment
my %env;
$env{'SCRIPT_NAME'} = "test.cgi";
$env{'SERVER_NAME'} = "www.test.com";
$env{'HTTP_HOST'} = "www.test.com";
$env{'HTTP_REFERER'} = "http://" . $env{'HTTP_HOST'};
$env{'SERVER_PORT'} = 8080;
$env{'REQUEST_URI'} = "/test.cgi";
$env{'REQUEST_METHOD'} = 'GET';

my $options = {
	'responsePlugin' => 'PSGI::Hector::Response::Raw',
	'debug' => 1
};

my $m = PSGI::Hector->new($options, \%env);
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
is($m->getOption('debug'), 1, "PSGI::Hector::getOption()");

#7
{
	my $env = $m->getEnv();
	is($env{'REQUEST_METHOD'}, "GET", "PSGI::Hector::getEnv()");
}

#8
is($m->getUrlForAction("someAction", "a=b&c=d"), "/someAction?a=b&c=d", "PSGI::Hector::getUrlForAction()");

#9
is($m->getFullUrlForAction("someAction", "a=b&c=d"), "http://www.test.com:8080/someAction?a=b&c=d", "PSGI::Hector::getFullUrlForAction()");

#10
{
	$m = PSGI::Hector->new($options, \%env);
	my $response = $m->getResponse();
	is($response->header("Set-Cookie"), undef, "New session not created on new()")
}
