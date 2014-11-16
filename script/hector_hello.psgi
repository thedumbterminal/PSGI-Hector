#run using the following command:
#plackup script/hector_hello.psgi
use strict;
use warnings;
use lib qw(lib);

my $app = App->init({
	'responsePlugin' => 'PSGI::Hector::Response::Raw',
	'checkReferer' => 0
});

###########################################
###########################################
package App;
use strict;
use warnings;
use parent qw(PSGI::Hector);
###########################################
sub handleDefault{
	my $h = shift;
	my $response = $h->getResponse();
	$response->setContent("Hello World");
}