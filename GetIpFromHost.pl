#!/usr/bin/env perl
use strict;
use warnings;
use Socket;

my $filename = "IPs.txt";
my @hosts;
my @ipaddrs;
my $content = "";
my $test = "";
my $ip1 = "";
open(my $toread, "<", "hostnames.txt")
    or die "Failed to open file: $!\n";
while(<$toread>) { 
    chomp; 
    push @hosts, $_;
} 
close $toread;
open(my $towrite, '>', $filename) or die "Could not open file '$filename' $!";
print $towrite "";
close $towrite;

open( $towrite, '>>', $filename) or die "Could not open file '$filename' $!";

foreach (@hosts) {
	@ipaddrs = map { inet_ntoa($_) } (gethostbyname($_))[4,];
	print @ipaddrs;
	print  "\n";
	print $towrite "$_";
	print $towrite ", @ipaddrs\n";
}



close $towrite;
print 'done';
