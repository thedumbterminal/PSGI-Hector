package PSGI::Hector::Utils;
=pod

=head1 NAME

PSGI::Hector::Utils - Helper methods

=head1 SYNOPSIS

=head1 DESCRIPTION

Various methods used by several of the Mungo classes.

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

Returns the site URL for the current script, This includes the protocol and host name only.

=cut

###########################################################
sub getSiteUrl{
	my $self = shift;
	my $env = $self->getEnv();
	my $proto = "http";
	if(exists($env->{'HTTP_X_FORWARDED_PROTO'})){
		$proto = $env->{'HTTP_X_FORWARDED_PROTO'};
	}
	elsif(exists($env->{'HTTPS'})){
		$proto = "https";
	}
	my $url = $proto . "://";
	if($env->{'HTTP_HOST'} =~ /^([^\:]+)(\:\d+|)$/){
		$url .= $1;   #only want the hostname part
		my $port = $env->{'HTTP_X_FORWARDED_PORT'} || $env->{'SERVER_PORT'};
		if($port){	#will have to assume port 80 if we don't have this
			if($proto eq "https" && $port != 443){        #add non default ssl port
				$url .= ":" . $port;
			}       
			elsif($proto eq "http" && $port != 80){     #add non default plain port     
				$url .= ":" . $port;
			}
		}
	}
	else{
	   Confess("Invalid HTTP host header");
	}
	return $url;
}
#############################################################################################################

=head1 Notes

=head1 Author

MacGyveR <dumb@cpan.org>

Development questions, bug reports, and patches are welcome to the above address

=head1 Copyright

Copyright (c) 2014 MacGyveR. All rights reserved.

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut

###########################################################
return 1;
