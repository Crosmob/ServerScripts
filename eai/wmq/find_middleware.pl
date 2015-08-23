#!/usr/bin/perl
use strict;
use warnings;
use Socket;
use Sys::Hostname;
my $host = hostname();
my $os =  $^O;
my $dspmqpath = "/opt/mqm/bin/dspmq";
my $dspmqverpath = "/opt/mqm/bin/dspmqver";
my $dspmq = "";
my $dspmqver = "";
my $dspmqline = "";
my @qmgrs;
print "$os";

# this script will continue the work if the OS is SunOS or Linux
if ( $os eq "sunos" || $os eq "solaris" || $os eq "linux" ){
# now we will check if there is MQ Client or MQ Server
	if (-e $dspmqpath && -e $dspmqverpath){
		# there is mq server
		# first we get the mq version
		$dspmqver = `dspmqver`;
		$dspmqver =~ /([0-9].[0-9].[0-25].[0-25])/;
		$dspmqver = $1;
		$dspmq = `dspmq`;
		@qmgrs = split /\n/, $dspmq;
		foreach my $dspmqline (@qmgrs) {
			if($dspmqline =~ m/\s*QMNAME\(([\w\.]+)\)\s+STATUS\((\w+)\)/) {
				print "$host,$os,$dspmqver,$1,$2\n";
			}
		}
	}elsif ( -e $dspmqverpath ){
	# there is mq client
	print "";
	}else{
	# there is no MQ instalaltion
	print "";
	}
}
