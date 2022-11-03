#!/usr/bin/perl

# USAGE:
# cat example.times | ./interpret_times.pl
# OR
# ./interpret_times.pl example.times

use strict;
use warnings;

#*|| Get lines
my @lines;
if ( $#ARGV == 0 ) { # one argument so use as filename
    my $file_name=$ARGV[0];
    # Read from file
    open(times_file, '<', $file_name) or die $!;
    @lines=<times_file>;
    close(times_file);
} else { # no arguments read lines from STDIN
    @lines=<STDIN>;
}

for my $line_num (0..$#lines) { # $line_num - zero-based line number
    #*|| Line Processing
    my $line=$lines[$line_num];
    chomp $line; #remove newline
    if ($line_num==0) { #first line must be the declaration
        if ($line ne "Daily On Times:") {
            die "First line must be 'Daily On Times:' to indicate that the string is in .times format";
        } else {
            next;
        }
    }
    
    #*|| Tokenizing
    my (
        $operation, #: 'ON' | 'OFF'
        $time #: 'HH:MM' | 'HH' | 'HH pm'
    )=$line =~ m/Turn (on|off) at (\d{1,2}(?:\:\d{1,2})? ?p?m?)/i;
    $operation=uc $operation;

    #*|| Executing
    if ($operation eq 'ON') {
        system("echo 'Turning on at $time'");
        system("at -f 'BASE_INSERTED_HERE_BY_INSTALL_SH/exec/monitor/turn_on.py' $time");
    } elsif ($operation eq 'OFF') {
        system("echo 'Turning off at $time'");
        system("at -f 'BASE_INSERTED_HERE_BY_INSTALL_SH/exec/monitor/turn_off.py' $time");
    } else { #should never happen
        die "Unknown operation '$operation'";
    }
}
