#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use DBI;

# Recibir párametros del formulario
  my $q = CGI->new;
  my $nombre = $q->param('nombre');
  my $categoria = $q->param('categoria');
  my $precio = $q->param('precio');

# Establece la conexión a la base de datos
  my $user = 'alumno';
  my $password = 'pweb1';
  my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.1.23";
  my $dbh = DBI->connect($dsn,$user,$password) or die("No se pudo conctar!");

  my $sth = $dbh->prepare("INSERT INTO Productos(Categoria,Nombre,Precio) VALUES(?,?,?)");
  $sth->execute($categoria,$nombre,$percio);

  $sth->finish;
  $dbh->disconnect;

  print $q->redirect("../vendedor.html");
