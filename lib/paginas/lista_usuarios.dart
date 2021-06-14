import 'dart:async';

import 'package:flutter/material.dart';

import 'package:vision_one/bloc/usuario_bloc.dart';
import 'package:vision_one/modelo/usuario_model.dart';

class ListaUserPage extends StatefulWidget {
  @override
  _ListaUserPageState createState() => _ListaUserPageState();
}

class _ListaUserPageState extends State<ListaUserPage> {

  UsuarioBloc usuarioBloc = new UsuarioBloc();
  UsuarioModel usuarioModel = new UsuarioModel();

  @override
  Widget build(BuildContext context) {
    
    setState(() {
    usuarioBloc.cargarUsuario();
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Lista de usuarios'),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, 'crear_users'),
      ),
    );
  }

  Widget _body() {
    return StreamBuilder(
      stream: usuarioBloc.usuarioStream,
      builder: (BuildContext context, AsyncSnapshot<List<UsuarioModel>> snapshot) {

        if(snapshot.hasData) {
          final usuario = snapshot.data;

          return RefreshIndicator(
            onRefresh: _refrescar,
            child: ListView.builder(
              itemCount: usuario.length,
              itemBuilder: (BuildContext context, int i)
              => _usuarios(context, usuario[i])
            )
          );
        } else {
          return Center(child: Text('No se encontro informacion'));
        }

      }
    );

  }

  Widget _usuarios(BuildContext context, UsuarioModel usuario) {

    return Card(
      elevation: 10.0,
      child: Column(
        children: [
          ListTile(
            title: Text('${usuario.rut}'),
            subtitle: Text('${usuario.rol}'),
            trailing: _boton(usuario)
          )
        ],
      ),
    );

  }

  Widget _boton(UsuarioModel usuario) {

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 13.0),
            backgroundColor: Colors.blue
          ),
          child: Text('Administrar', style: TextStyle(color: Colors.white)),
          onPressed: () => Navigator.pushNamed(context, 'admin_users', arguments: usuario) 
        ),
      ],
    );
            
  }

  Future _refrescar() {
  
    Duration carga = new Duration(seconds: 2);
    new Timer(carga,() {
      build(context);
    });
    return Future.delayed(carga);
  }



}