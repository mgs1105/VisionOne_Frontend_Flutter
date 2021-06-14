import 'package:flutter/material.dart';

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

