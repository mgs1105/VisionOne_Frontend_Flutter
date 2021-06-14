import 'package:flutter/material.dart';

import 'package:vision_one/paginas/productos_de_seccion.dart' as producto;
import 'package:vision_one/search/search_delegate.dart';

List<DropdownMenuItem<String>> opcionesRol(List roles) {

    List<DropdownMenuItem<String>> listarol = [];

    for (String rol in roles) {
      listarol.add(DropdownMenuItem(
        child: Text(rol),
        value: rol,
      ));
    }
    return listarol;  

}

SnackBar snackBar (String mensaje) {

  return SnackBar(
  content: Text(mensaje),
  duration: Duration(seconds: 2),
);

}

Widget boton(String rol, BuildContext context) {

  if(rol == 'ADMIN') {
  return IconButton(
    enableFeedback: false,
    icon: Icon(Icons.group_add_outlined), 
    color: Colors.white,
    iconSize: 35.0,
    onPressed: () {
      Navigator.pushNamed(context, 'lista_users');
    }
  );
  } else {
    return Container();
  }


}
