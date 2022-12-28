#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use DBI;

my $q=CGI->new;
print $q -> header('text/html');
my $usuario = $q->param("usuario");
my $correo=$q->param("correo");
my $contrasena=$q->param("contrasena");

if(defined($correo) and defined($contrasena) ){
    if(checkLogin($correo,$contrasena)){
        my @arr=checkLogin($correo,$contrasena);
        successLogin($arr[0],$arr[3],$arr[2]);
    }
    else{
        showLogin();
    }
}
else{
    showLogin();
}

sub successLogin{
    print "<script>\n";
    print "alert('Iniciando cuenta del usuario $usuario ....');\n";
    print "</script>\n";
    print $q->redirect("../ventas/paginaPrincipal.html");
}

sub showLogin{
    if ($correo ne checkLogin($correo)){
        print "<script>\n";
        print "alert('Ese CORREO no existe...');\n";
        print "</script>\n";
    }
}

sub checkLogin{
    my $correoQuery=$_[0];
    my $contrasenaQuery=$_[1];

    my $user = 'alumno';
    my $password= 'pweb1';
    my $dsn ='DBI:MariaDB:database=pweb1;host=192.168.1.23';
    my $dbh = DBI ->connect($dsn,$user,$password) or die ("No se pudo conectar");

    my $sql="SELECT * FROM Clientes WHERE correo=? AND contrasena=?";
    my $sth=$dbh->prepare($sql);
    $sth->execute($correoQuery,$contrasenaQuery);
    my @row=$sth->fetchrow_array;
    $sth->finish;
    $dbh->disconnect;
    return @row;
}

print $q->redirect("../iniciodesesionC.html");
exit;