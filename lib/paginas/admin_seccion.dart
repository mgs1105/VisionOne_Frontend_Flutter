import 'package:flutter/material.dart';

class AdminSeccionPage extends StatefulWidget {
  @override
  _AdminSeccionPageState createState() => _AdminSeccionPageState();
}

class _AdminSeccionPageState extends State<AdminSeccionPage> {
  @override
  Widget build(BuildContext context) {

    final tamano = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Gestionar secciones'),
      ),
      body: Center(
        child: _body(tamano)
      ),
    );
  }

  Widget _body(Size tamano) {

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: tamano.width * 0.7,
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
              labelText: 'Nombre de la seccion'
              ),
              //validator: (){},
            ),
          ),
          SizedBox(height: tamano.height * 0.09),
          TextButton(
            onPressed: (){}, 
            child: Text('Crear', style: TextStyle(fontSize: 15.0),),
            style: TextButton.styleFrom(
              backgroundColor: Colors.black12,
              primary: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 50.0)
            ),
          ),
        ]
      ),
    );

  }
}