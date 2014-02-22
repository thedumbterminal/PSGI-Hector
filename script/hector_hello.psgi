#run using the following command:
#plack script/hector_hello.psgi
use strict;
use warnings;
use lib qw(lib);
my $app = sub {
	my $env = shift;
	my $options = {
		'responsePlugin' => 'PSGI::Hector::Response::Raw',
		'checkReferer' => 0
	};
	my $h = App->new($options, $env);
	return $h->run();	#do this thing!
};
###########################################
###########################################
package App;
use strict;
use warnings;
use base qw(PSGI::Hector);
###########################################
sub handleDefault{
	my $h = shift;
	my $response = $h->getResponse();
	$response->setContent("Hello World");
}