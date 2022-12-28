#!/usr/bin/perl

use DBI;

# Conectarse a la base de datos
my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.1.23";
my $dbh = DBI->connect($dsn, $user, $password);

# Ejecutar una consulta SQL para obtener los elementos de la base de datos
my $sth = $dbh->prepare("select distinct Categoria from Productos");
$sth->execute();

# Mostrar el resultado de la consulta en una tabla HTML
print "Content-type: text/html\n\n";
print <<HTML;
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/vendedor.css">
    <title>Interface Administradores</title>
</head>
<body>
    <div class="cont">
        <div class="contenedor_lista" id="lista">
            <ul>
                
HTML

while (my @row = $sth->fetchrow_array()) {
  print "<li><a href='#'>$row[0]</a></li>\n";
}

print <<HTML;           
            </ul>
        </div>
        <div class="contenedor_texto" id="Menu">
            Esta es una sección donde se mostrarán los elementos de la clasificación de productos, para que los administradores tengan 
        </div>

    </div>
</body>
</html>
HTML

# Desconectarse de la base de datos
$dbh->disconnect();