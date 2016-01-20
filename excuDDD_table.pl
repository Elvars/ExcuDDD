#!/usr/bin/perl

use DBI;
use strict;
use utf8;

my $driver   = "SQLite";
my $database = "excuDDD.db";
my $dsn = "DBI:$driver:dbname=$database";
my $userid = "";
my $password = "";
my $dbh = DBI->connect($dsn, $userid, $password, { RaiseError => 1 })
                      or die $DBI::errstr;
                      
print "Opened database successfully\n";

my $stmt = qq(CREATE TABLE LINKKI
      (
       ID INTEGER PRIMARY KEY AUTOINCREMENT,
       WHO TEXT		NOT NULL,
       URL TEXT		NOT NULL
       
       ););
       
my $rv = $dbh->do($stmt);
if($rv < 0)
{
   print $DBI::errstr;
} 
else 
{
   print "Table created successfully\n";
}

$dbh->disconnect();