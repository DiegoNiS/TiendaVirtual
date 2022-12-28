#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

my $cgi = CGI->new;
my $categoria=$cgi->param("categoria");
my $nombre=$cgi->param("nombre");


#Database part
my $user= 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.1.24";
my $dbh = DBI->connect($dsn, $user, $password) or die ("No se puede conectar");

#Eliminar datos
my $sth = $dbh->prepare("DELETE from Productos WHERE Nombre = ? and Categoria = ?");
$sth->execute($nombre,$categoria);

$dbh->disconnect;

print $cgi->redirect("mostrar_productos_admin.pl?tipo_producto=$categoria");
