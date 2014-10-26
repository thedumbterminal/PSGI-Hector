use strict;
use warnings;
use Test::More;
plan(tests => 11);
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

my $sub = PSGI::Hector->init($options);
#1
isa_ok($sub, "CODE");

my $h = PSGI::Hector->new($options, \%env);
#2
isa_ok($h, "PSGI::Hector");

#3
my $response = $h->getResponse();
isa_ok($response, "PSGI::Hector::Response::Raw");

#4
my $session = $h->getSession();
isa_ok($session, "PSGI::Hector::Session");

#5
my $request = $h->getRequest();
isa_ok($request, "PSGI::Hector::Request");

#6 need to test getthisurl()
is($h->getThisUrl(), "http://www.test.com:8080/test.cgi", "PSGI::Hector::Utils::getThisUrl()");

#7
is($h->getOption('debug'), 1, "PSGI::Hector::getOption()");

#8
{
	my $env = $h->getEnv();
	is($env{'REQUEST_METHOD'}, "GET", "PSGI::Hector::getEnv()");
}

#9
is($h->getUrlForAction("someAction", "a=b&c=d"), "/someAction?a=b&c=d", "PSGI::Hector::getUrlForAction()");

#10
is($h->getFullUrlForAction("someAction", "a=b&c=d"), "http://www.test.com:8080/someAction?a=b&c=d", "PSGI::Hector::getFullUrlForAction()");

#11
{
	$h = PSGI::Hector->new($options, \%env);
	my $response = $h->getResponse();
	is($response->header("Set-Cookie"), undef, "New session not created on new()")
}
