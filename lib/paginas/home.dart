import 'dart:async';

import 'package:flutter/material.dart';

import 'package:vision_one/bloc/seccion_bloc.dart';
import 'package:vision_one/modelo/seccion_model.dart';

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
    seccionBloc.cargarSeccion();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Catalogo de secciones'),
        actions: [
          IconButton(
            icon: Icon(Icons.group_add_outlined), 
            color: Colors.black87,
            iconSize: 35.0,
            onPressed: () {
              Navigator.pushNamed(context, 'lista_users');
            }
          )
        ],        
      ),
      body: _body(tamano),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'admin_seccion'),
      ),
    );
  }

  Widget _body(Size tamano) {

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
              => _seccion(context ,seccion[i]),
            )
          );
          
        } else {
          return Center(child: CircularProgressIndicator());
        } 

      }
    );


  }

  Widget _seccion(BuildContext context, SeccionModel seccion) {

    return Card(
      child: Column(
        children: [
          ListTile(
              onTap: () =>Navigator.pushNamed(context, 'productos', arguments: seccion),
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