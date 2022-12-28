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

    my $sql = "SELECT usuario FROM administradores WHERE usuario=?";
    my $sth = $dbh->prepare($sql);
    $sth->execute($usuarioQuery);
    my @row = $sth->fetchrow_array;
    $sth->finish;
    $dbh->disconnect;

    return @row;
}

sub successRegister{
    print "<script>\n";
    print "alert('El usuario $usuario ha sido registrado con éxito....');\n";
    print "</script>\n";
    print $q->redirect("../iniciodesesionA.html");
}

sub showRegister{
    
    if ($usuario ne checkUsuario($usuario)){
        print "<script>\n";
        print "alert('Ese USUARIO ya esta registrado, cambie...');\n";
        print "</script>\n";
    }
    if ($correo ne checkUsuario($correo)){
        print "<script>\n";
        print "alert('Ese CORREO ya esta registrado, cambie...');\n";
        print "</script>\n";
    }
}

sub register {
    my $usuarioQuery=$_[0];
    my $correoQuery=$_[1];
    my $contrasenaQuery=$_[2];

    my $user = 'alumno';
    my $password = 'pweb1';
    my $dsn ='DBI:MariaDB:database=pweb1;host=192.168.1.23';
    my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar a la base de datos");

    my $sth = $dbh->prepare("INSERT INTO administradores(usuario,correo,contrasena) VALUES(?,?,?)");

    $sth->execute($usuarioQuery,$correoQuery,$contrasenaQuery);
    $sth ->finish;
    $dbh->disconnect;
}
exit;