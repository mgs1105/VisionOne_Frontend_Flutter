import 'package:flutter/material.dart';

import 'package:vision_one/bloc/usuario_bloc.dart';
import 'package:vision_one/modelo/usuario_model.dart';
import 'package:vision_one/provider/usuario_provider.dart';

import 'package:vision_one/utils/utils.dart' as utils;

class IniciarSesion extends StatefulWidget {

  @override
  _IniciarSesionState createState() => _IniciarSesionState();
}

class _IniciarSesionState extends State<IniciarSesion> {

  final keyformulario = GlobalKey<FormState>();

  UsuarioModel usuarioModel = new UsuarioModel();
  UsuarioProvider usuarioProvider = new UsuarioProvider();
  UsuarioBloc usuarioBloc = new UsuarioBloc();

  @override
  Widget build(BuildContext context) {

    final tamano = MediaQuery.of(context).size;
    usuarioBloc.cargarUsuario();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bienvenido')
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: keyformulario,
            child: _formulario(tamano, context)
          ),
        ),
      ),
          
    );
      
  }

  Widget _formulario(tamano, context) {

    final fuente = TextStyle(fontSize: 18.0);   

    return Column(
      children: [
        SizedBox(height: tamano.height * 0.07),
        Text('Iniciar sesion', style: fuente),
        SizedBox(height: tamano.height * 0.1),
        Text('Ingrese sus datos para iniciar sesion', style: fuente),
        SizedBox(height: tamano.height * 0.09),
        _rut(tamano),
        SizedBox(height: tamano.height * 0.01),
        _pass(tamano),
        SizedBox(height: tamano.height * 0.1),
        _botonIniciar(tamano),
      ],
    );
    
  }

  Widget _rut(Size tamano) {

    return Container(
      width: tamano.width * 0.7,
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: '1111111-1',
          labelText: 'Rut',
        ),
        validator: (value) {
          if(value.length < 6) {
            return 'Ingrese un rut valido';
          } else {
            return null;
          }
        },
        onSaved: (value) => usuarioModel.rut = value
      ),
    );

  }

  Widget _pass(Size tamano) {

    return Container(
      width: tamano.width * 0.7,
      child: TextFormField(
        obscureText: true,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: 'contraseña',
        ),
        validator: (value) {
          if(value.length <= 4) {
            return 'El password debe tener minimo 5 caracteres';
          } else {
            return null;
          }
        },
        onSaved: (value) => usuarioModel.password = value,
      ),
    );

  }

  Widget _botonIniciar(Size tamano) {

    return StreamBuilder(
      stream: usuarioBloc.usuarioStream,
      builder: (BuildContext context, AsyncSnapshot<List<UsuarioModel>> snapshot) {

        final usuarios = snapshot.data;

        return TextButton( 
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            primary: Colors.white,
            backgroundColor: Colors.blue
          ),
          child: Text('Ingresar', style: TextStyle(fontSize: 15.0, color: Colors.white)),
          onPressed: () => _login(usuarios)
        );

      }
    );

  }

  void _login(List<UsuarioModel> usuarios) async {

    if(!keyformulario.currentState.validate()) return;
    keyformulario.currentState.save();

    final resp = await usuarioProvider.validaUsuario(usuarioModel);

    if(resp == true) {
    List<UsuarioModel> login = [];

      for (var i = 0; i < usuarios.length; i++) {
        if(usuarioModel.rut == usuarios[i].rut) {
          login.add(usuarios[i]);
        }
      }
      Navigator.pushReplacementNamed(context, 'home', arguments: login[0]);
    } else {
      final snack = utils.snackBar('Los datos ingresados no son validos');
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }

  }


}
        