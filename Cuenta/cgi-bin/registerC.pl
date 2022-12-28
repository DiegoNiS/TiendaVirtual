#!/usr/bin/perl -w

use strict;
use warnings;
use CGI;
use DBI;
use utf8;


my $q = CGI->new;
##print $q->header('text/html');
my $usuario = $q->param("usuario");
my $correo = $q->param("correo");
my $contrasena = $q->param("contrasena");

if ($usuario && $correo && $contrasena) {
    if (!scalar(checkUsuario($usuario))) {
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
    my $usuarioQuery = shift;

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

sub successRegister{
    my $usuario = shift;
    my $correo = shift;

    # Crea un objeto CGI
    # my $q = CGI->new;

    ##print "<script>\n";
    ##print "alert('El usuario $usuario ha sido registrado con éxito....');\n";
    ##print "</script>\n";

    # Redirige a la página iniciodesesionC.html
    print $q->redirect("../iniciodesesionC.html");
}

sub showRegister{
    my $usuario = shift;
    my $correo = shift;
    # my $q1 = CGI->new;
    #print $q1->header('text/html');

    if (scalar(checkUsuario($usuario))) {
        #print "<script>\n";
        #print "alert('Ese USUARIO ya esta registrado, cambie...');\n";
        #print "</script>\n";
    }
    if (scalar(checkUsuario($correo))) {
        #print "<script>\n";
        #print "alert('Ese CORREO ya esta registrado, cambie...');\n";
        #print "</script>\n";
    }
}

sub register {
    my $usuarioQuery=shift;
    my $correoQuery=shift;
    my $contrasenaQuery=shift;

    my $user = 'alumno';
    my $password = 'pweb1';
    my $dsn ='DBI:MariaDB:database=pweb1;host=192.168.1.23';
    my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar a la base de datos");

    my $sth = $dbh->prepare("INSERT INTO Clientes(usuario,correo,contrasena) VALUES(?,?,?)");

    $sth->execute($usuarioQuery,$correoQuery,$contrasenaQuery);
    $sth ->finish;
    $dbh->disconnect;
}