#!/usr/bin/perl
use strict;
use warnings;
use Socket;
use Sys::Hostname;
my $host = hostname();
my $display = "";
my $displayc = "";
my $dspmq = "";
my $qm = "";
my $qmstatus = "";
my $dspmqver = "";
# check if there is mq server installation
my $dspmqpath = "/opt/mqm/bin/dspmq";
my $dspmqverpath= "/opt/mqm/bin/dspmqver";

if(-e $dspmqpath && -e $dspmqverpath){
        # mq server installation was found - now we will find the running qmgrs
        # first we get the mq version
        $dspmqver = `dspmqver`;
        $dspmqver =~ /([0-9].[0-9].[0-25].[0-25])/;
        $dspmqver = $1;
        $dspmq = `dspmq`;
        my @qmgrs = split /\n/, $dspmq;
        foreach my $dspmqline (@qmgrs) {
                if($dspmqline =~ m/\s*QMNAME\(([\w\.]+)\)\s+STATUS\((\w+.*)\)/) {
                        $qm = "$1";
                        $qmstatus = "$2";
                        # print "$1,$2\n";
                        # go through the running queue managers and get the queues info
                        if( $2 eq "Running"){
                                $display = `echo 'DIS Q(*) TYPE' | runmqsc $1`;
                                my @resultLines = split /\n/, $display;
                                foreach my $resultLine (@resultLines) {
                                        if($resultLine =~ m/\s*QUEUE\(([\w\.]+)\)\s+TYPE\((\w+)\)/) {
                                                print "$host,$dspmqver,$qm,$qmstatus,$1,$2\n";
                                        }
                                        elsif($resultLine =~ m/\s*QUEUE\(([\w\.]+)\)/) {
                                                print "$host,$dspmqver,$qm,$qmstatus,$1,";
                                        }
                                        elsif($resultLine =~ m/\s*TYPE\((\w+)\)/) {
                                                print "$1\n";
                                        }
                                }
                                $displayc = `echo 'DIS QC(*) TYPE' | runmqsc $1`;
                                my @resultLinesc = split /\n/, $displayc;
                                foreach my $resultLinec (@resultLinesc) {
                                        if($resultLinec =~ m/\s*QUEUE\(([\w\.]+)\)\s+TYPE\((\w+)\)/) {
                                                print "$host,$dspmqver,$qm,$qmstatus,$1,$2\n";
                                        }
                                        elsif($resultLinec =~ m/\s*QUEUE\(([\w\.]+)\)/) {
                                                print "$host,$dspmqver,$qm,$qmstatus,$1,";
                                        }
                                        elsif($resultLinec =~ m/\s*TYPE\((\w+)\)/) {
                                                print "$1\n";
                                        }
                                }
                        }
                        else{
                                print "$host,$dspmqver,$qm,$qmstatus,,\n";
                        }
                }
        }
}
elsif(-e $dspmqverpath){
        # there is only mq client installed
        $dspmqver = `dspmqver`;
        $dspmqver =~ /([0-9].[0-9].[0-25].[0-25])/;
        print "$host,$1,,,,\n";
}
else {
# there was no mq server installed there
        print "$host,,,,,\n";
}
