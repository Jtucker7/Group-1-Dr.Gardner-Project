#!/usr/bin/perl

#Final Project
#11/20/2015
#Author:Justin
#	Chandler
#	Amanda
#	Daylee

#The following program is a utility that allows a user to read in gene sequencing 
#data from a CSV or Database and parses the data in various ways.  The data is 
#then exported to an html table.

use strict;
use warnings;
use Text::CSV;

#Subroutine that opens a CSV file and reads in
#the contents to an array
sub csvFile {
	my $line;
	my $csvFile;
	my @parse;
	print "\n*****************************************\n";
	print "*********  CSV File Input Menu  *********\n";
	print "*****************************************\n\n";
	print "Input File Name (use example.csv): ";
	chomp($csvFile = <>);
	open FILE, '<', $csvFile || die "File did not open";

	while($line = <FILE>) {
		chomp($line);
		@parse = split(',', $line);
	}
	#close FILE;
	print "@parse\n";

}

#The following Prompts the User to see if they want 
#to import from a CSV or Database and calls the 
#corresponding subroutine
system $^O eq 'MSWin32' ? 'cls' : 'clear';
print "\n*************************************\n";
print "*********  Gene Sequencer  **********\n";
print "*************************************\n\n";
do {
	print "How would you like to import the file.\n";
	print "1) CSV\n";
	print "2) Database\n";
	print "Enter: ";
	$_ = <>;
	
	if ($_ == 1) {
		system $^O eq 'MSWin32' ? 'cls' : 'clear';
		&csvFile;
	}
	elsif ($_==2) {
		system $^O eq 'MSWin32' ? 'cls' : 'clear';
		print "Database\n";
	}
	else {
		system $^O eq 'MSWin32' ? 'cls' : 'clear';
		print "\n\nInvalid Input\n\n";
	}
   } while (($_!=1) && ($_!=2));