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

# this script will continue the work if the OS is SunOS or Linux
if ( lc $os eq lc "sunos" || lc $os eq lc "solaris" || lc $os eq lc "linux" ){
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
				print "$host,$os,server,$dspmqver,$1,$2\n";
			}
		}
	}elsif ( -e $dspmqverpath ){
	# there is mq client
		# we get the mq version
                $dspmqver = `dspmqver`;
                $dspmqver =~ /([0-9].[0-9].[0-25].[0-25])/;
                $dspmqver = $1;
		print "$host,$os,client,$dspmqver,,";
	}else{
	# there is no MQ instalaltion
		print "$host,$os,nomq,,,,";
	}
}
