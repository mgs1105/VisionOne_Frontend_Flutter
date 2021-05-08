import 'package:flutter/material.dart';

import 'package:vision_one/utils/utils.dart' as utils;

class AdminUsuarioPage extends StatefulWidget {

  @override
  _AdminUsuarioPageState createState() => _AdminUsuarioPageState();
}

class _AdminUsuarioPageState extends State<AdminUsuarioPage> {
  List<String> roles = ["USER", "ADMIN", "VENDEDOR"];

  @override
  Widget build(BuildContext context) {

    final tamano = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Administrar usuario'),
      ),
      body: SingleChildScrollView(
        child: _formulario(tamano, context),
      ),
    );
  }

  Widget _formulario(Size tamano, BuildContext context) {

    final fuente = TextStyle(fontSize: 18.0);   
    String _rol = 'USER';

    return Center(
      child: Column(
        children: [
        SizedBox(height: tamano.height * 0.07),
        Text('Ingrese los datos del usuario', style: fuente),
        SizedBox(height: tamano.height * 0.1),
        Container(
          width: tamano.width * 0.7,
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: 'Rut'
            ),
            //validator: (){},
          ),
        ),
        SizedBox(height: tamano.height * 0.1),
        Text('Rol', style: fuente),
        Container(
          width: tamano.width * 0.7,
          child: DropdownButtonFormField(
          value: _rol,
          items: utils.opcionesRol(roles),
          onChanged: (opt) {
          setState(() {
            _rol = opt;
          });
          },
          //onSaved: (value) => publicacionModel.horarioi = value,
          ),
        ),
        SizedBox(height: tamano.height * 0.1),
        _botones(tamano),
        ],
      ),
    );
    
  }

  Widget _botones(Size tamano) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: (){}, 
          child: Text('Crear')
        ),
        TextButton(
          onPressed: (){}, 
          child: Text('Eliminar')
        ),
        TextButton(
          onPressed: (){}, 
          child: Text('Actualizar')
        ),        
      ]
    );

  }
}