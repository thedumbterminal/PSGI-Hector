package PSGI::Hector::Log;
use strict;
use warnings;
###########################################################
sub log{	#a simple way to log a message to the apache error log
	my($self, $message) = @_;
	print STDERR $message . "\n";
	return 1;
}
#################################################
return 1;
