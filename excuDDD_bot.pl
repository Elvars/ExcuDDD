 #!/usr/bin/perl

use DBI;
use strict;
use warnings;
use utf8;
use Data::Dumper;
use Encode;
use base qw(Bot::BasicBot);

package MyBot;

binmode (STDOUT, ":utf8");

my $driver   = "SQLite";
my $database = "excuDDD.db";
my $dsn = "DBI:$driver:dbname=$database";
my $userid = "";
my $password = "";
my $dbh = DBI->connect($dsn, $userid, $password,
	{
		RaiseError=>1,
		AutoCommit=>1,
		sqlite_unicode=>1
	}
	);

my @kiitos = ("viiten tähten postaus", "kiittikiitoos", "hoisss", "kiitos kontribuutiostasi");

sub said {
      
      our ($self, $message) = @_;
      
      	if($message->{body}=~/!excuDDD/){
      		if($message->{body}=~/youtu/ or $message->{body}=~/youtube/ ){
		
		my $split = $message->{body};
		my @values = split(' ', $split);

   
		my $url = $values[1];
		my $nick=$message->{who};
        
         
		my $stmt = qq(INSERT INTO LINKKI (WHO, URL)
			VALUES ("$nick", "$url"));
            
		my $rv = $dbh->do($stmt) or die $DBI::errstr;
        
		
		my $kiitos=$kiitos[rand @kiitos];		return "$kiitos $nick";
         
		}	
	}
	

	if($message->{body} eq "!select"){
		
		my $stmt = qq(SELECT DISTINCT URL FROM LINKKI;);
		my $sth = $dbh->prepare($stmt);
		my $rv = $sth->execute() or die $DBI::errstr;
			
		if($rv < 0)
		{
			print $DBI::errstr;
		}
						
		while(my @row = $sth->fetchrow_array()){
			$self->say(
				channel =>"#yourchannelhere",
				body=>"$row[0] \n",
			);
		}
		return undef;
	}

}
MyBot->new(
	server => 'yourserverhere',
	channels => [ '#yourchannelhere'],
	nick => 'yournickhere',
)->run();