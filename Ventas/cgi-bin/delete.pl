#!/usr/bin/perl -w

use DBI;
use CGI;
use strict;
use warnings;

## borramos elemento seleccionado

my $q = CGI->new;
my $producto = $q->param('producto');

my $user= 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.1.23";
my $dbh = DBI->connect($dsn, $user, $password) or die ("No se puede conectar");

# consultamos producto
my $sth = $dbh->prepare("SELECT Nombre FROM Productos WHERE Nombre=?");
$sth->execute($producto);
my @row = $sth->fetchrow_array;

print $q->header('text/XML');
print "<?xml version='1.0' encoding='utf-8'?>\n";

if (!(@row == 0)){
	# si existe una producto con dicho nombre...

	my $sth = $dbh->prepare("DELETE FROM Productos WHERE Nombre=?");
	$sth->execute($producto);
	$sth->finish;

	# muestra nombre del producto en caso haya sido eliminado
	print "<producto>";
	print "<Nombre>$producto</Nombre>";
	print "</producto>";
}
else { # si no existe tal producto, bota un xml producto vacio
	print "<producto>";
	print "</producto>";
	
}
$dbh->disconnect;