#!/usr/bin/perl

use CGI;
use DBI;

my $cgi = CGI->new;
my $tipo_producto=$cgi->param("tipo_producto");

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

my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.1.23";
my $dbh = DBI->connect($dsn, $user, $password);

# Ejecutar una consulta SQL para obtener los elementos de la base de datos
my $sth1 = $dbh->prepare("select distinct Categoria from Productos");
$sth1->execute();

while (my @row = $sth1->fetchrow_array()) {
  print "<li><a href='mostrar_productos_admin.pl?tipo_producto=$row[0]'>$row[0]</a></li>\n";
}

print <<HTML;           
            </ul>
        </div>
        <div class="contenedor_texto" id="Menu">
            <ul>             
HTML

my $sth2 = $dbh->prepare("select * from Productos where Categoria=?");
$sth2->execute($tipo_producto);

while (my @row = $sth2->fetchrow_array()) {
    print "<li>@row[1]: s/. @row[2]</li>\n";
    print "<div class='divfrm'>"
    print "<form class='frm' action='./delete.pl?categoria='$tipo_producto'&nombre='@row[1]'>"
    print "<input type='submit' class='btn' value='delete this'>"
    print "</form>"
    print "<form class='frm' action='./edit.pl?categoria='$tipo_producto'&nombre='@row[1]'>"
    print "<input type='submit' class='btn' value='edit this'></form>"
    print "/form></div>"
}

print <<HTML;           
            </ul>            
        </div>

    </div>
</body>
</html>
HTML

# Desconectarse de la base de datos
$dbh->disconnect();