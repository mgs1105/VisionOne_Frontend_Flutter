import 'package:flutter/material.dart';
import 'package:vision_one/provider/seccion_provider.dart';

class IniciarSesion extends StatelessWidget {

  final seccionProvider = new SeccionProvider();

  @override
  Widget build(BuildContext context) {

    final tamano = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Bienvenido')
      ),
      body: SingleChildScrollView(
        child: _formulario(tamano, context),
        
      ),
      
    );
  }

  Widget _formulario(tamano, context) {

    final fuente = TextStyle(fontSize: 18.0);   

    return Center(
      child: Column(
        children: [
        SizedBox(height: tamano.height * 0.07),
        Text('Iniciar sesion', style: fuente),
        SizedBox(height: tamano.height * 0.1),
        Text('Ingrese sus datos para iniciar sesion', style: fuente),
        SizedBox(height: tamano.height * 0.09),
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
        SizedBox(height: tamano.height * 0.01),
        Container(
          width: tamano.width * 0.7,
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: 'contraseña'
            ),
            //validator: (){},
          ),
        ),
        SizedBox(height: tamano.height * 0.1),
        TextButton( 
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            primary: Colors.black87,
            backgroundColor: Colors.black12
          ),
          child: Text('Ingresar', style: TextStyle(fontSize: 15.0)),
          onPressed: () => Navigator.pushReplacementNamed(context, 'home'),
        )
        ],
      ),
    );
    

  }
}
        