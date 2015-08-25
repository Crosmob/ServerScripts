#!/usr/bin/perl
use strict;
use warnings;
use Socket;
use Sys::Hostname;
my $host = hostname();
my $display = "";
my $dspmq = "";

$dspmq = `dspmq`;
my @qmgrs = split /\n/, $dspmq;
foreach my $dspmqline (@qmgrs) {
	if($dspmqline =~ m/\s*QMNAME\(([\w\.]+)\)\s+STATUS\((\w+)\)/) {
		print "$1,$2\n";
		if( $2 eq "Running"){
			$display = `echo 'DIS CHL(*) CHLTYPE' | runmqsc $1`;
			my @resultLines = split /\n/, $display;
			foreach my $resultLine (@resultLines) {
				if($resultLine =~ m/\s*CHANNEL\(([\w\.]+)\)\s+CHLTYPE\((\w+)\)/) {
					print "$1,$2\n";
				}
				elsif($resultLine =~ m/\s*CHANNEL\(([\w\.]+)\)/) {
					print "$1,";
				}
				elsif($resultLine =~ m/\s*CHLTYPE\((\w+)\)/) {
					print "$1\n";
				}
			}
		}
	}
}




