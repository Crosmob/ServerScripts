#!/usr/bin/perl
use strict;
use warnings;
use Socket;
use Sys::Hostname;

# This perl script is able to parse the gskit output and retrieve 
# the expiry date and the fingerprint of a certificate by using the gskit 

my $host = hostname();
my $display = "";
my $dspmq = "";

# first we check if there is MQ server installation

## if there is server installation we search for running queue managers

### for each running qmgr we check if there is ssl folder and kdb

#### if they exist we retrive the data and print the details

# if there is no server installation we exit by printing also some output.


