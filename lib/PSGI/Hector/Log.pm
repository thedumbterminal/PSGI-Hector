package PSGI::Hector::Log;

=pod

=head1 NAME

PSGI::Hector::Log - Logging class

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=cut

use strict;
use warnings;
#########################################################

=pod

=head2 log($message)

	$h->log($message);

Logs the provided string to STDERR.

=cut

###########################################################
sub log{	#a simple way to log a message to the apache error log
	my($self, $message) = @_;
	print STDERR $message . "\n";
	return 1;
}
#################################################

=head1 Notes

=head1 Author

MacGyveR <dumb@cpan.org>

Development questions, bug reports, and patches are welcome to the above address

=head1 Copyright

Copyright (c) 2014 MacGyveR. All rights reserved.

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut

###############################################
return 1;
