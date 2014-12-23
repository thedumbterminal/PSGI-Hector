package PSGI::Hector::Utils;
=pod

=head1 NAME

PSGI::Hector::Utils - Helper methods

=head1 SYNOPSIS

=head1 DESCRIPTION

Various methods used by several of the Hector classes.

=head1 METHODS

=cut
use strict;
use warnings;
use Carp;
#########################################################

=pod

=head2 getThisUrl()

	my $url = $m->getThisUrl();

Returns the full URL for the current script, ignoring the query string if any.

=cut

###########################################################
sub getThisUrl{
	my $self = shift;
	my $url = $self->getSiteUrl();
	my $env = $self->getEnv();
	$env->{'REQUEST_URI'} =~ m/^([^\?]+)/;	#match everything up to the query string if any
	$url .= $1;
	return $url;
}
#########################################################

=pod

=head2 getSiteUrl()

	my $url = $m->getSiteUrl();

Returns the full site URL for the current script.

=cut

###########################################################
sub getSiteUrl{
	my $self = shift;
	my $request = $self->getRequest();
	$request->base->as_string;
}
#############################################################################################################

=head1 Notes

=head1 Author

MacGyveR <dumb@cpan.org>

Development questions, bug reports, and patches are welcome to the above address.

=head1 See Also

=head1 Copyright

Copyright (c) 2014 MacGyveR. All rights reserved.

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut

###########################################################
return 1;
