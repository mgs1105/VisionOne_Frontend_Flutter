import 'package:flutter/material.dart';
import 'package:vision_one/bloc/usuario_bloc.dart';
import 'package:vision_one/modelo/usuario_model.dart';
import 'package:vision_one/provider/usuario_provider.dart';

import 'package:vision_one/utils/utils.dart' as utils;

class CrearUsuarioPage extends StatefulWidget {
  @override
  _CrearUsuarioPageState createState() => _CrearUsuarioPageState();
}

class _CrearUsuarioPageState extends State<CrearUsuarioPage> {

  final keyformulario = GlobalKey<FormState>();

  UsuarioModel usuarioModel = new UsuarioModel();
  UsuarioProvider usuarioProvider = new UsuarioProvider();
  UsuarioBloc usuarioBloc = new UsuarioBloc();

  List<String> roles = ["VENDEDOR", "BODEGUERO", "ADMIN"];

  @override 
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Crear nuevo usuario'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: keyformulario,
            child: _formulario(),
          ),
        ),
      ),
    );
  }

  Widget _formulario() {

    final fuente = TextStyle(fontSize: 18.0);   
    final tamano = MediaQuery.of(context).size;

    return Column(
      children: [
        _rut(tamano),
        SizedBox(height: tamano.height * 0.05),
        _password(tamano),
        SizedBox(height: tamano.height * 0.05),
        Text('Rol', style: fuente),
        SizedBox(height: tamano.height * 0.03),
        _rol(tamano),
        SizedBox(height: tamano.height * 0.1),
        _crear(tamano)
      ],
    );
  }

  Widget _rut(Size tamano) {

    return Container(
      width: tamano.width * 0.7,
      child: TextFormField(
        validator: (value){
          if(value.length <= 6) {
            return 'Debe ingresar un Rut valido';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: 'Rut',
        ),
        onSaved: (value) => usuarioModel.rut = value
      ),
    );    

  }

  Widget _password(Size tamano) {

    return Container(
      width: tamano.width * 0.7,
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        validator: (value) {
          if(value.length <= 4) {
            return 'La contraseña debe tener minimo 5 digitos';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        onSaved: (value) => usuarioModel.password = value
      ),
    );

  }

  Widget _rol(Size tamano) {

    String _rol;

    return  Container(
      width: tamano.width * 0.7,
      child: DropdownButtonFormField(        
        value: '${roles[0]}',
        items: utils.opcionesRol(roles),
        onChanged: (opt) {
          setState(() {
            _rol = opt;
          });
        },
        onSaved: (opt) {
          usuarioModel.rol = opt;
        } 
      ),
    );    

  }

  Widget _crear(Size tamano) {

    final fuente = TextStyle(fontSize: 16.0);

    return TextButton(
      child: Text('Crear usuario',  style: fuente),
      onPressed: () async {
      
        if(!keyformulario.currentState.validate()) return;
        keyformulario.currentState.save();

        final listaUser = await usuarioProvider.cargarUsuario();

        List<String> rutIgual = [];

        for (var i = 0; i < listaUser.length; i++) {
          
          if(usuarioModel.rut == listaUser[i].rut) {
            rutIgual.add(usuarioModel.rut); 
          } 
        } 

        if(rutIgual.length == 1) {
          final snack = utils.snackBar('Este usuario ya existe');
          ScaffoldMessenger.of(context).showSnackBar(snack);
        } else {

          usuarioProvider.crearUsuario(usuarioModel);
          final snack = utils.snackBar('Usuario creado con exito'); 
          ScaffoldMessenger.of(context).showSnackBar(snack);
        }

      }
    );

  }

}
    



