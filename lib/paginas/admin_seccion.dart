import 'package:flutter/material.dart';
import 'package:vision_one/bloc/seccion_bloc.dart';
import 'package:vision_one/modelo/seccion_model.dart';
import 'package:vision_one/provider/seccion_provider.dart';

class AdminSeccionPage extends StatefulWidget {
  @override
  _AdminSeccionPageState createState() => _AdminSeccionPageState();
}

class _AdminSeccionPageState extends State<AdminSeccionPage> {

  final keyformulario = GlobalKey<FormState>();
  final keyScaffold = GlobalKey<ScaffoldState>();

  SeccionModel seccionModel = new SeccionModel();
  SeccionProvider seccionProvider = new SeccionProvider();
  SeccionBloc seccionBloc = new SeccionBloc();

  @override
  Widget build(BuildContext context) {

    final tamano = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Gestionar secciones'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: keyformulario,
            child: _body(tamano)
          ),
        ),
      )
    );
  }

  Widget _body(Size tamano) {

    return Column(
      children: [
        Container(
          width: tamano.width * 0.7,
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: 'Nombre de la seccion'
            ),
            onSaved: (value) => seccionModel.nombre = value,
          ),
        ),
        SizedBox(height: tamano.height * 0.09),
        TextButton(
          child: Text('Crear', style: TextStyle(fontSize: 15.0),),
          style: TextButton.styleFrom(
            backgroundColor: Colors.black12,
            primary: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 50.0)
          ),
          onPressed: () {
            if(!keyformulario.currentState.validate()) return;

            keyformulario.currentState.save();

            seccionProvider.crearSeccion(seccionModel);

            final snack = SnackBar(
            content: Text('Seccion creada con exito'),
            duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);
            
            seccionBloc.cargarSeccion();
          }, 
        ),
      ]
    );
    

  }



}