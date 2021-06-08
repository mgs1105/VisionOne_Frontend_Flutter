import 'package:flutter/material.dart';

import 'package:vision_one/modelo/usuario_model.dart';
import 'package:vision_one/provider/usuario_provider.dart';

import 'package:vision_one/utils/utils.dart' as utils;

class AdminUsuarioPage extends StatefulWidget {

  @override
  _AdminUsuarioPageState createState() => _AdminUsuarioPageState();
}

class _AdminUsuarioPageState extends State<AdminUsuarioPage> {

  final keyformulario = GlobalKey<FormState>();

  UsuarioProvider usuarioProvider = new UsuarioProvider();
  
  List<String> roles = ["VENDEDOR", "BODEGUERO", "ADMIN"];

  @override
  Widget build(BuildContext context) {

    final UsuarioModel usuario = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Administrar usuario'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: keyformulario,
            child: _body(usuario),
          ) 
        ),
      ) 
    );
  }

  Widget _body(UsuarioModel usuario) {

    final fuente = TextStyle(fontSize: 18.0);   
    final tamano = MediaQuery.of(context).size;

    return Column(
      children: [
        _rut(tamano, usuario),
        SizedBox(height: tamano.height * 0.05),
        Text('Rol', style: fuente),
        SizedBox(height: tamano.height * 0.03),
        _rol(tamano, usuario),
        SizedBox(height: tamano.height * 0.1),
        _botones(tamano, usuario),
      ],
    );

  }
    

  Widget _rut(Size tamano, UsuarioModel usuario) {

    return Container(
      width: tamano.width * 0.7,
      child: TextFormField(
        enabled: false,
        initialValue: '${usuario.rut}',
        decoration: InputDecoration(
          labelText: 'Rut',
        ),
        onSaved: (value) => usuario.rut = value
      ),
    );

  }

  Widget _rol(Size tamano, UsuarioModel usuario) {

    String _rol;

    return  Container(
      width: tamano.width * 0.7,
      child: DropdownButtonFormField(        
        value: '${usuario.rol}',
        items: utils.opcionesRol(roles),
        onChanged: (opt) {
          setState(() {
            _rol = opt;
          });
        },
        onSaved: (opt) {
          usuario.rol = opt;
        } 
      ),
    );
  }

  Widget _botones(Size tamano, UsuarioModel usuario) {

    final fuente = TextStyle(fontSize: 16.0, color: Colors.white);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 20.0)
          ),
          child: Text('Eliminar',  style: fuente),
          onPressed: () => _eliminarUsuario(usuario)
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 20.0)
          ),
          child: Text('Actualizar',  style: fuente),
          onPressed: () => _actualizarUsuario(usuario)
        ),
      ]
    );

  }

  void _eliminarUsuario(UsuarioModel usuario) {
    
    final color = TextStyle(color: Colors.white); 
    
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text('¿Esta seguro que desea eliminar este usuario?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
              backgroundColor: Colors.blueAccent
              ),
              child: Text('No', style: color),
              onPressed: () => Navigator.of(context).pop()
            ),
            Expanded(child: SizedBox(width: 10.0)),
            TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red
            ), 
            child: Text('Eliminar', style: color),
            onPressed: () async {
              Navigator.of(context).pop();
              Navigator.of(context).pop();

              usuarioProvider.eliminarUsuario(usuario);
              final snack = SnackBar(
              content: Text('Usuario eliminado con exito'),
              duration: Duration(seconds: 2),
              );
              ScaffoldMessenger.of(context).showSnackBar(snack);                     
            }, 
            )
          ],
        );
      }
    );    
  }

  void _actualizarUsuario(UsuarioModel usuario) {

    keyformulario.currentState.save();
    usuarioProvider.modificarUsuario(usuario);

    final snack = SnackBar(
      content: Text('Usuario modificado con exito'),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);  

  }

}

  //Widget _password(Size tamano, UsuarioModel usuario) {

  //  return Container(
  //    width: tamano.width * 0.7,
  //    child: TextFormField(
  //      textCapitalization: TextCapitalization.sentences,
  //      decoration: InputDecoration(
  //        labelText: 'Password',
  //      ),
  //      validator: (value) {
  //        if(value.length > 0 && value.length <= 5) {
  //          return 'El Password debe contener minimo 6 caracteres';
  //        } else {
  //        return null;
  //        }
  //      },
  //      onSaved: (value) {
  //        if(value.length >= 1) { 
  //        usuario.password = value;
  //        } else {
  //          usuario.password = usuario.password;
  //        }
  //      }
  //    ),
  //  );

  //}
