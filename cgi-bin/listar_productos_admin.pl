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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../CSS/perl.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <title>Interface Administradores</title>
</head>
<body>
    <div class="modal-header">
        <button class="btn btn-lg btn-default pull-right" onclick="window.location.href='../anadir_productos.html'">Añadir mas elementos</button>
    </div>

    <table border="2px" class="form-group" class="" id="lista">
        <tr>
            <td scope="col">CATEGORIAS</td>
            <td scope="col">PRODUCTOS</td>
        </tr>
        <br>
        <tr>
            <td>
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
            </td>
            
            <td>             
HTML

my $sth2 = $dbh->prepare("select * from Productos where Categoria=?");
$sth2->execute($tipo_producto);

while (my @row = $sth2->fetchrow_array()) {
    print "<li>@row[1]: s/. @row[2]</li>\n";
    print "<div class='divfrm'>";
    print "<form class='frm'".$tipo_producto."'&nombre='".@row[1]."'\">\n";
    print "<input type='submit' class='btn' value='Delete this'>";
    print "</form>";
    print "<form class='frm'".$tipo_producto."'&nombre='".@row[1]."'\">\n";
    print "<input type='submit' class='btn' value='Edit this'></form>";
    print "</div>";
}

print <<HTML;           
            </ul> </td> 
        </tr>
    </table> 
            
        </div>        
    </div>
</body>
</html>
HTML

# Desconectarse de la base de datos
$dbh->disconnect();