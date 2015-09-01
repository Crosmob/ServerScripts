#!/usr/bin/perl
use strict;
use warnings;
use Socket;
use Sys::Hostname;
my $host = hostname();
my $ftelistagents = "";
# check if there is mq server installation
my $ftebin = "/opt/IBM/WMQFTE/bin";

if(-e $ftebin){
        $ftelistagents = `fteListAgents`;
        my @agents = split /\n/, $ftelistagents;
        foreach my $agentsline (@agents) {
			if (index($agentsline, "Copyright") != -1) {
				print "";
			}
			elsif(index($agentsline, "Status") != -1){
				print "";
			}
			else{
				my $num_words = () = split /\s+/, $agentsline, 30;
				# print "$num_words\n";
				$agentsline =~ s/ {1,}/ /g;
				my @array1 = split /\s+/, $agentsline;
				print "$array1[0], $array1[$num_words - 3], $array1[$num_words - 2] \n";
			}
		}
}
