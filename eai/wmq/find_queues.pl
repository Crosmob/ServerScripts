#!/usr/bin/perl
use strict;
use warnings;
use Socket;
use Sys::Hostname;
my $host = hostname();
my $display = "";
my $dspmq = "";
# check if there is mq server installation
my $dspmqpath = "/opt/mqm/bin/dspmq";
my $dspmqverpath= "/opt/mqm/bin/dspmqver";

if(-e $dspmqpath && -e $dspmqverpath){
        # mq server installation was found - now we will find the running qmgrs
	$dspmq = `dspmq`;
	my @qmgrs = split /\n/, $dspmq;
	foreach my $dspmqline (@qmgrs) {
		if($dspmqline =~ m/\s*QMNAME\(([\w\.]+)\)\s+STATUS\((\w+)\)/) {
			print "$1,$2\n";
			if( $2 eq "Running"){
				$display = `echo 'DIS Q(*) TYPE' | runmqsc $1`;
				my @resultLines = split /\n/, $display;
				foreach my $resultLine (@resultLines) {
					if($resultLine =~ m/\s*QUEUE\(([\w\.]+)\)\s+TYPE\((\w+)\)/) {
						print "$1,$2\n";
					}
					elsif($resultLine =~ m/\s*QUEUE\(([\w\.]+)\)/) {
						print "$1,";
					}
					elsif($resultLine =~ m/\s*TYPE\((\w+)\)/) {
						print "$1\n";
					}
				}
			}
		}
	}
}
else {
}




