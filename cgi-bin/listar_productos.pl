#!/usr/bin/perl

use DBI;

# Conectarse a la base de datos
my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.1.23";
my $dbh = DBI->connect($dsn, $user, $password);

# Ejecutar una consulta SQL para obtener los elementos de la base de datos
my $sth = $dbh->prepare("SELECT * FROM administradores");
$sth->execute();

# Mostrar el resultado de la consulta en una tabla HTML
print "Content-type: text/html\n\n";
print "<table>\n";
print "<tr><th>Columna 1</th><th>Columna 2</th></tr>\n";
while (my @row = $sth->fetchrow_array()) {
  print "<tr><td>$row[0]</td><td>$row[1]</td></tr>\n";
}
print "</table>\n";

# Desconectarse de la base de datos
$dbh->disconnect();