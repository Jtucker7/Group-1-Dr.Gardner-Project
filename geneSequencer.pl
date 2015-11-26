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
use Data::UUID; #keeps track of user actions
use Jedi::Apps; #Jedi is an authenticator 
use Jedi::Plugin::Template;
use Jedi::Plugin::Session; #mandatory for authentification
use Jedi::Plugin::Auth;

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
			print FILE "<td>CSV ARRAY HERE</td>\n";
			print FILE "<td>CSV ARRAY HERE</td>\n";		
			print FILE "<td>CSV ARRAY HERE</td>\n";
		print FILE "</tr>\n";
		print FILE "<tr>\n";
			print FILE "<td>CSV ARRAY HERE</td>\n";
			print FILE "<td>CSV ARRAY HERE</td>\n";		
			print FILE "<td>CSV ARRAY HERE</td>\n";
		print FILE "</tr>\n";
		print FILE "<tr>\n";
			print FILE "<td>CSV ARRAY HERE</td>\n";
			print FILE "<td>CSV ARRAY HERE</td>\n";		
			print FILE "<td>CSV ARRAY HERE</td>\n";
		print FILE "</tr>\n";
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

   
#The following subroutines set up the authentification for the program
#Jedi authenticator app setup
sub jedi_apps{
	my ($app)=@_;
	
	$app->get('/login', $app->can('handle_login'));
	$app->get('/signin',$app->can('handle_signin'));
	$app->get('/activate', $app->can('handle_activate'));
	}
	
sub handle_login {
	my($app, $request, $response)=@_;
	my ($login, $password)=map {$request->params->{$_}} qw(user password);
	my $user = $app->jedi_auth_login($request, user => $user, password=>$password);
	if ($user->{status} eq 'ok'){
		$response->status('302');
		$response-set_header('Location'=>'/');
	}else {
	$response->status('200');
	$response->body($app->template('index'). {error_msg=> 'bad login'});
	}
}	

sub handle_signin {
	my ($app, $request, $response) = @_;
    my ($login, $password, $email, $roles) = map { $request->params->{$_} } qw/user password email roles/;

    my $user = $app->jedi_auth_signin(
      user => $login,
      password => $password, #auto sha1
      roles => [split /,/, $roles // ''],
      info => {
        email => $email,
        activated => 0,
        activate_token => Data::UUID->new->create_str;
      }
    );

    if ($user->{status} eq 'ok') {
      print "Signin successful\n";
    } else {
      $user->{error_msg}; 
    }
}

sub handle_activate {
    my ($app, $request, $response) = @_;
    my ($user, $activate_token) = map { $request->params->{$_} } qw/user token/;

    my $users = $app->jedi_auth_users($user);
    my $user = shift @$users;
    if (!defined $user) {
      print "user not found\n";
    } else {
      if ($user->{info}{activate_token} eq $activate_token) {
        activate
        $app->jedi_auth_update($request, user => $user, info => {activate_token => undef, activated => 0});
        display ok
      } else {
        display error
      }
    }
}

#The following creates a new user. User and password will be different for each user.
$app->jedi_auth_signin(
    user     => 'admin',
    password => 'admin',
    uuid     => 'XXXXXXXXXXXXXXX' #SHA1 Hex Base64
    roles    => ['admin'],
    info     => {
      activated => 0,
      label     => 'Administrator',
    }
 );
 
 #The following logs in the user. 
 $app->jedi_auth_login(
    $request,
    user     => 'admin',
    password => 'admin',
  ); 
 
#The following prompts the user to give the option
#to export the data to an html table

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





#logout user  (uncomment for use)
  #$app->jedi_auth_logout($request)





