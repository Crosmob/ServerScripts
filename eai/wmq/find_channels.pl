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
			# go through the running queue managers and get the channels info
			if( $2 eq "Running"){
				$display = `echo 'DIS CHL(*) CHLTYPE' | runmqsc $1`;
				my @resultLines = split /\n/, $display;
				foreach my $resultLine (@resultLines) {
				# there should be check in case there are results in two lines
					if($resultLine =~ m/\s*CHANNEL\(([\w\.]+)\)\s+CHLTYPE\((\w+)\)/) {
						print "$1,$2\n";
					}
					elsif($resultLine =~ m/\s*CHANNEL\(([\w\.]+)\)/) {
						print "$host,$1,";
					}
					elsif($resultLine =~ m/\s*CHLTYPE\((\w+)\)/) {
						print "$1\n";
					}
				}
			}
		}
	}
}
else {
# there was no mq server installed there
	print "$host,,,,";
}
