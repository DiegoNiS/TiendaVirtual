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

if (defined($usuario) and defined($correo) and defined($contrasena)) {
    if (!checkUsuario($usuario)) {
        register($usuario, $correo, $contrasena);
        successRegister($usuario, $correo);
    }
    else {
        showRegister();
    }
}
else {
    showRegister();
}