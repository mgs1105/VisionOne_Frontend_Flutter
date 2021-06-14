import 'package:flutter/material.dart';

import 'package:vision_one/bloc/producto_bloc.dart';
import 'package:vision_one/modelo/producto_model.dart';
import 'package:vision_one/provider/producto_provider.dart';

import 'package:vision_one/modelo/seccion_model.dart';

import 'package:vision_one/utils/utils.dart' as utils;

class CrearProdPage extends StatefulWidget {
  @override
  _CrearProdPageState createState() => _CrearProdPageState();
}

class _CrearProdPageState extends State<CrearProdPage> {

  final keyformulario = GlobalKey<FormState>();
  
  ProductoModel productoModel = new ProductoModel();
  ProductoProvider productoProvider = new ProductoProvider();
  ProductoBloc productoBloc = new ProductoBloc();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Añadir producto'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: keyformulario,
            child: _body(),
          ),
        )
      ),
    );
  }

  Widget _body() {

    final tamano = MediaQuery.of(context).size;

    return Column(
      children: [
        _nombreProd(tamano),
        SizedBox(height: tamano.height * 0.05),
        _descripcion(tamano),
        SizedBox(height: tamano.height * 0.05),        
        _stockA(tamano),
        SizedBox(height: tamano.height * 0.05),        
        _stockB(tamano),
        SizedBox(height: tamano.height * 0.05),        
        _stockC(tamano),
        SizedBox(height: tamano.height * 0.05),
        _boton(),
      ]
    );
  }

  Widget _nombreProd(Size tamano) {

    final SeccionModel seccion = ModalRoute.of(context).settings.arguments;

    return  Container(
      width: tamano.width * 0.7,
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: 'Nombre del Producto'
        ),
        validator: (value) {

          if(value.length <= 0) {
            return 'Debe especificar el nombre del producto';
          } else {
            return null;
          }

        },
        onSaved: (value) {
          productoModel.nombre = value;
          productoModel.idseccion = seccion.id;
        }
      ),
    );

  }

  Widget _descripcion(Size tamano) {

    return  Container(
      width: tamano.width * 0.7,
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: 'Descripcion'
        ),
        onSaved: (value) {

          if(value == null) {
            productoModel.descripcion = "";
          }  else {
          productoModel.descripcion = value;
          } 

        }
      ),
    );
  }

  Widget _stockA(Size tamano) {

    return Container(
      width: tamano.width * 0.7,
      child: TextFormField(
        keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: 'Stock en sucursal A'
        ),
        validator: (value) {

          if(value.length == null) {
            return 'Debe especificar la cantidad en bodega';
          } else {
            return null;
          }
        },
        onSaved: (value) => productoModel.stockA = int.parse(value)
      ),
    );

  }

  Widget _stockB(Size tamano) {

    return Container(
      width: tamano.width * 0.7,
      child: TextFormField(
        keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: 'Stock en sucursal B'
        ),
        validator: (value) {
          if(value.length <= 0) {
            return 'Debe especificar la cantidad en bodega';
          } else {
            return null;
          }
        },
        onSaved: (value) => productoModel.stockB = int.parse(value)
      ),
    );

  }

  Widget _stockC(Size tamano) {

    return Container(
      width: tamano.width * 0.7,
      child: TextFormField(
        keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: 'Stock en sucursal C'
        ),
        validator: (value) {
          if(value.length <= 0) {
            return 'Debe especificar la cantidad en bodega';
          } else {
            return null;
          }
        },
        onSaved: (value) => productoModel.stockC = int.parse(value)
      ),
    );
  }

  Widget _boton() {

    return TextButton(
      child: Text('Añadir producto', style: TextStyle(fontSize: 15.0),),
      style: TextButton.styleFrom(
        backgroundColor: Colors.black12,
        primary: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 50.0)
      ),
      onPressed: () {

        if(!keyformulario.currentState.validate()) return;

        keyformulario.currentState.save();

        productoProvider.crearProducto(productoModel);
        
            final snack = utils.snackBar('Producto creado con exito');
            ScaffoldMessenger.of(context).showSnackBar(snack);
      }, 
    );

  }



}