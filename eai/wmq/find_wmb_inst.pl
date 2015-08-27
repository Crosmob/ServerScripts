#!/usr/bin/perl
use strict;
use warnings;
use Socket;
use Sys::Hostname;
my $host = hostname();
my $os =  $^O;
my $mqsilist = "/opt/mqsi8/bin/";
my $dspmq = "";
my $dspmqver = "";
my $dspmqline = "";
my @qmgrs;

# this script will continue the work if the OS is SunOS or Linux
if ( lc $os eq lc "sunos" || lc $os eq lc "solaris" || lc $os eq lc "linux" ){
# now we will check if there is WMB
	if (-e $mqsilist){
		# first we get the wmb version because it exists
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
	}
	else{
	# there is no WMB instalaltion
		print "$host,$os,nomq,,,,";
	}
}
