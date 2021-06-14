import 'dart:io';

import 'package:flutter/material.dart';

import 'package:vision_one/bloc/producto_bloc.dart';
import 'package:vision_one/modelo/producto_model.dart';
import 'package:vision_one/provider/producto_provider.dart';

import 'package:vision_one/modelo/seccion_model.dart';

import 'package:image_picker/image_picker.dart';
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

  bool _guardando = false;
  File foto;

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
        SizedBox(height: tamano.height * 0.05),
        _subirFoto(tamano),
        SizedBox(height: tamano.height * 0.05),
        _nombreProd(tamano),
        SizedBox(height: tamano.height * 0.05),        
        _stockA(tamano),
        SizedBox(height: tamano.height * 0.05),        
        _stockB(tamano),
        SizedBox(height: tamano.height * 0.05),        
        _stockC(tamano),
        SizedBox(height: tamano.height * 0.05),
        _boton(),
        SizedBox(height: tamano.height * 0.05),
      ]
    );
  }

  Widget _subirFoto(Size tamano) {

    if(foto == null) {
      return GestureDetector(
        onTap: _selccionarFoto,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0),
          child: Image(image: AssetImage('imagenes/no-image.png')),
        ),
      );
    } else {
      return GestureDetector(
        onTap: _selccionarFoto,
        child: Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300,
        ),
      );
    }
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

  Widget _boton()  {

    return TextButton(
      child: Text('Añadir producto', style: TextStyle(fontSize: 15.0),),
      style: TextButton.styleFrom(
        backgroundColor: Colors.black12,
        primary: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 50.0)
      ),
      onPressed: () async {

        if(!keyformulario.currentState.validate()) return;
        keyformulario.currentState.save();

        if (foto != null) {
          productoModel.fotoURL = await productoBloc.subirFoto(foto);
        }

        productoProvider.crearProducto(productoModel);
        
        final snack = utils.snackBar('Producto creado con exito');
        ScaffoldMessenger.of(context).showSnackBar(snack);
      }, 
    );

  }

  _selccionarFoto() {
    procesarImagen(ImageSource.gallery);
  }

  void procesarImagen(ImageSource origen) async {

    final _picker = ImagePicker();
    final pickedFile = await _picker.getImage(source: origen);

    setState(() {
      if(pickedFile != null) {
        productoModel.fotoURL = null;
        foto = File(pickedFile.path);
      } else {
        print('No ha seleccionado imagen');
      }
    });

  }



}