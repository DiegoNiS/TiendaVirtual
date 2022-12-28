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

sub checkUsuario {
    my $usuarioQuery = $_[0];

    my $user = 'alumno';
    my $password = 'pweb1';
    my $dsn ='DBI:MariaDB:database=pweb1;host=192.168.1.23';
    my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar a la base de datos");

    my $sql = "SELECT usuario FROM Clientes WHERE usuario=?";
    my $sth = $dbh->prepare($sql);
    $sth->execute($usuarioQuery);
    my @row = $sth->fetchrow_array;
    $sth->finish;
    $dbh->disconnect;

    return @row;
}