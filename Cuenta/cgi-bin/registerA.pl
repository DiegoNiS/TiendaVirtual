#!/usr/bin/perl -w

use strict;
use warnings;
use CGI qw/:standard/;
use DBI;
use utf8;

my $q = CGI->new;
print $q->header('text/html');

my $usuario = $q->param("usuario");
my $correo = $q->param("correo");
my $contrasena = $q->param("contrasena");