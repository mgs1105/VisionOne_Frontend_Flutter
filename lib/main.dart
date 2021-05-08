import 'package:flutter/material.dart';

//Paginas
import 'package:vision_one/paginas/iniciar_sesion.dart';
import 'package:vision_one/paginas/home.dart';
import 'package:vision_one/paginas/admin_usuarios.dart';
import 'package:vision_one/paginas/admin_seccion.dart';
import 'package:vision_one/paginas/productos_de_seccion.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VisionOne',
      initialRoute: 'iniciarSesion',
      routes: {
        'iniciarSesion' : (BuildContext context) => IniciarSesion(),
        'home'          : (BuildContext context) => HomePage(),
        'admin_user'    : (BuildContext context) => AdminUsuarioPage(),
        'admin_seccion' : (BuildContext context) => AdminSeccionPage(),
        'productos'     : (BuildContext context) => ProductosPage()
      },
    );
  }
}
