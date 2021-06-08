import 'package:flutter/material.dart';
import 'package:vision_one/paginas/crear_usuario.dart';

//Paginas
import 'package:vision_one/paginas/iniciar_sesion.dart';
import 'package:vision_one/paginas/home.dart';
import 'package:vision_one/paginas/admin_usuarios.dart';
import 'package:vision_one/paginas/admin_seccion.dart';
import 'package:vision_one/paginas/lista_usuarios.dart';
import 'package:vision_one/paginas/producto_detalle.dart';
import 'package:vision_one/paginas/productos_de_seccion.dart';
import 'package:vision_one/paginas/crear_producto.dart';

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
        'lista_users'   : (BuildContext context) => ListaUserPage(),
        'admin_users'   : (BuildContext context) => AdminUsuarioPage(),
        'crear_users'   : (BuildContext context) => CrearUsuarioPage(),
        'admin_seccion' : (BuildContext context) => AdminSeccionPage(),
        'productos'     : (BuildContext context) => ProductosPage(),
        'crearProd'     : (BuildContext context) => CrearProdPage(),
        'prodDetalle'   : (BuildContext context) => ProdDetallePage()
      },
    );
  }
}
