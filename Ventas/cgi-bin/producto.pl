#!/usr/bin/perl -w

use DBI;
use CGI;
use strict;
use warnings;

# recibimos categoria del producto
my $q = CGI->new;
my $categoria = $q->param("Categoria");

print "Content-type: text/html\n\n";
print <<HTML;
<html>
	<head>
		<link rel="icon" href="../icon/UNSA.ico">
		<link rel = "stylesheet" href = "../css/estilos.css" >
		<title> $categoria </title>
		<header>
			<nav>
				<select class ="elegir"id="selectbox" name="" onchange="javascript:location.href = this.value;">
					<option value="">Categorias</option>
					<option value="./producto.pl?Categoria=teclados">Teclados</option>
					<option value="./producto.pl?Categoria=mouses">Mouses</option>
					<option value="./producto.pl?Categoria=monitores">Monitores</option>
				</select>
				<a href="../paginaPrincipal.html">Pagina principal</a>
				<a href="../../Cuenta/iniciodesesionC.html">Mi cuenta</a>
			</nav>
		</header>
		<div style="text-align: center;">
			<img src = "../img/logoUNSA.png" width = "500" height = "227" alt = "Logo UNSA">
			<p>Seccion $categoria</p>
		</div>
	</head>
	<body>
		<div class="productos">
						
HTML

# conectamos a la base de datos

my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.1.23";
my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar!");;

my $sth = $dbh->prepare("SELECT Nombre FROM Productos WHERE Categoria =?");
$sth->execute($categoria);

# mostramos los productos con la categoria
while(my @row = $sth->fetchrow_array){
	# por cada producto encontrado, mostrara foto,nombre,precio y un boton de compra

	my $sth = $dbh->prepare("SELECT Precio FROM Productos WHERE Categoria =? AND Nombre=?");
	$sth->execute($categoria,@row);
	my @row2 = $sth->fetchrow_array;

	print"<div class='periferico'>";
		print"<img src = '../img/logoUNSA.png' width = '350' height = '300' >";#foto del producto
		print"<div class='informacion'>";
			print"<h3>@row</h3> ";#Nombre producto
			print "<p> S/@row2</p>"; # precio producto
		print"</div>";
		print"<div style='text-align: center;'>";
			print "<button id = 'comprar' class = 'botonCompra' onclick='doDelete(`@row`)'>Comprar</button>"; #funcion compra 
		print"</div>";

	print"</div>";
	
}
$sth->finish;
$dbh->disconnect;

print <<HTML;

		</div>
	</body>
	<script>
		function doDelete(producto){

			// al hacer click a comprar, se compra elimindose de la base de datos llamando a delete.pl

			let url = "./delete.pl?producto="+producto;
			let xhr = new XMLHttpRequest();
			console.log(url);
			alert("Producto comprado!");

			xhr.open("GET", url, true);
			xhr.send();
			var categoria = "$categoria";

			xhr.onload = function () {
				location.href ="./producto.pl?Categoria="+categoria;
			};

		}
	</script>
</html>
HTML
