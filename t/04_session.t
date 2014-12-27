use strict;
use warnings;
use Test::More;
plan(tests => 4);
use lib qw(../lib lib);
use PSGI::Hector;

#setup our cgi environment
my %env;
$env{'SCRIPT_NAME'} = "test.cgi";
$env{'SERVER_NAME'} = "www.test.com";
$env{'HTTP_HOST'} = "www.test.com:8080";
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
my $session = PSGI::Hector::Session->new($m);
isa_ok($session, "PSGI::Hector::Session");

#2
{
	my $response = $m->getResponse();
	is($response->header("Set-Cookie"), undef, "New session not created on new()")
}

#3
{
	$session = PSGI::Hector::Session->new($m);
	$session->setVar("a", "b");
	my $response = $m->getResponse();
	like($response->header("Set-Cookie"), qr/^SESSION=[A-Z]{2}[a-f0-9]+/, "New session created on setVar()")
}

#4
{
	$session = PSGI::Hector::Session->new($m);
	$session->getVar("a");
	my $response = $m->getResponse();
	like($response->header("Set-Cookie"), qr/^SESSION=[A-Z]{2}[a-f0-9]+/, "New session created on getVar()")
}
