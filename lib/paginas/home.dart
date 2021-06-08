import 'dart:async';

import 'package:flutter/material.dart';

import 'package:vision_one/bloc/seccion_bloc.dart';
import 'package:vision_one/modelo/seccion_model.dart';
import 'package:vision_one/modelo/usuario_model.dart';

import 'package:vision_one/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  SeccionBloc seccionBloc = new SeccionBloc();
  SeccionModel seccionModel = new SeccionModel();
  
  @override
  Widget build(BuildContext context) {

    final tamano = MediaQuery.of(context).size;  
    final UsuarioModel usuario = ModalRoute.of(context).settings.arguments;

    seccionBloc.cargarSeccion();
    setState(() {
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Catalogo de secciones'),
        actions: utils.boton(usuario.rol, context), 
      ),
      body: _body(tamano, usuario.rol),
      floatingActionButton: _agregarSecc(usuario.rol)
    );
  }
  
  Widget _agregarSecc(String rol) {

    if(rol == 'ADMIN' || rol == 'BODEGUERO') {
      return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'admin_seccion'),
      );
    } else {
      return null;
    }

  }

  Widget _body(Size tamano, String rol) {

    return StreamBuilder(
      stream: seccionBloc.seccionStream,
      builder: (BuildContext context, AsyncSnapshot<List<SeccionModel>> snapshot) {
        if(snapshot.hasData) {

          final seccion = snapshot.data;

          return RefreshIndicator(
            onRefresh: _refrescar,
            child: ListView.builder(
              itemCount: seccion.length,
              itemBuilder: (BuildContext context, int i) 
              => _seccion(context ,seccion[i], rol),
            )
          );
          
        } else {
          return Center(child: CircularProgressIndicator());
        } 

      }
    );


  }

  Widget _seccion(BuildContext context, SeccionModel seccion, String rol) {

    return Card(
      child: Column(
        children: [
          ListTile(
              onTap: () =>Navigator.pushNamed(context, 'productos', arguments: [seccion, rol]),
            title: Text('${seccion.nombre}'),
          ),
        ],
      ),
    );
          
  }

  Future _refrescar() async {
  
    Duration carga = new Duration(seconds: 2);
    new Timer(carga, () {
      build(context);
    });
    return Future.delayed(carga);
  }
           

}