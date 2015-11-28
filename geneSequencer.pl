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

my $line;
my $csvFile;
my @parse;

#Subroutine that opens a CSV file and reads in
#the contents to an array
sub csvFile {
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
	return @parse;
}


#This subroutine exports parsed data to a html table
sub htmlExport {
	system $^O eq 'MSWin32' ? 'cls' : 'clear';
	print "\n**************************************\n";
	print "********** Export File Menu **********\n";
	print "**************************************\n\n";

	print "Create File Name(for example use gene.html): ";
	chomp(my $htmlFile = <>);
	#Pseudo Code touch $htmlFile in existence
	open FILE, '>', $htmlFile || die "File does not exist\n"; 
	print FILE "<html>\n";
	print FILE "<body>\n";
	print FILE "<table>\n";
		print FILE "<tr>\n";
			print FILE "<td>Gene Sequencer</td>\n";
		print FILE "</tr>\n";
			my $i=0;
			while ($i<=$#parse) {
				print FILE "<tr>\n";
				print FILE "<td>" . "$parse[$i]" . "</td>\n";
				print FILE "</tr>\n";
				$i++;
			}
	print FILE "</table>\n";
	print FILE "</body>\n";
	print FILE "</html>\n";
	close FILE;
}

#The following prompts the user to see if they want 
#to import from a CSV or Database and calls the 
#corresponding subroutine
system $^O eq 'MSWin32' ? 'cls' : 'clear';
print "\n*************************************\n";
print "*********  Gene Sequencer  **********\n";
print "*************************************\n\n";
do {
	print "From where do you wish to import your data\n\n";
	print "1) CSV\n";
	print "2) Database\n\n";
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
		print "\n\nInvalid Input\n";
	}
   } while (($_!=1) && ($_!=2));

do {
	print "\nFile Read\n\n";
	print "Would you like to export file to a HTML table?\n";
	print "1) Yes\n";
	print "2) No\n";
	print "Enter: ";
	$_ = <>;
	if ($_ == 1) {
		&htmlExport;	
	}
	elsif ($_ == 2) {
		print "Press any key to quit.\n";
		$_ = <>;
		exit;
	}
	else {
		print "Invalid Input\n\n";
	}
} while (($_!=1) && ($_!=2));






