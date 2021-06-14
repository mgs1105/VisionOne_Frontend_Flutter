import 'dart:async';

import 'package:flutter/material.dart';

import 'package:vision_one/bloc/producto_bloc.dart';
import 'package:vision_one/bloc/seccion_bloc.dart';
import 'package:vision_one/modelo/producto_model.dart';
import 'package:vision_one/modelo/seccion_model.dart';
import 'package:vision_one/provider/producto_provider.dart';
import 'package:vision_one/provider/seccion_provider.dart';

import 'package:vision_one/utils/utils.dart' as utils;

class ProductosPage extends StatefulWidget {
  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {

  ProductoBloc productoBloc = new ProductoBloc();
  ProductoModel productoModel = new ProductoModel();
  ProductoProvider productoProvider = new ProductoProvider();

  SeccionBloc seccionBloc = new SeccionBloc();
  SeccionModel seccionModel = new SeccionModel();
  SeccionProvider seccionProvider = new SeccionProvider();

  @override
  Widget build(BuildContext context) {

    final tamano = MediaQuery.of(context).size;
    final SeccionModel seccion = ModalRoute.of(context).settings.arguments;

    productoBloc.cargarProducto(seccion.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('${seccion.nombre}'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever), 
            color: Colors.black87,
            iconSize: 30.0,
            onPressed: () => _eliminar(seccion)
          )
        ],
      ),
      body: _body(tamano, seccion),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'crearProd',  arguments: seccion),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _body(Size tamano, SeccionModel seccion) {

    return StreamBuilder(
      stream: productoBloc.productoStream,
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {

        if(snapshot.hasData) {

          final producto = snapshot.data;

          if(producto.length == 0) {
            return Center(child: Text('No se encontro informacion'));
          }

          return RefreshIndicator(
            onRefresh: _refrescar,
            child: ListView.builder(
              itemCount: producto.length,
              itemBuilder: (BuildContext context, int i) 
              => _producto(context ,producto[i], seccion),
            )
          );
          
        }  {
          return Center(child: Text('No se encontro informacion'));
        } 

      }
    );

  }

  Widget _producto(BuildContext context, ProductoModel producto, SeccionModel seccion) {

    return Card(
      child: Column(
        children: [
          ListTile(
            onTap: () => Navigator.pushNamed(context, 'prodDetalle', arguments: [producto, seccion]),
            title: Center(child: Text('${producto.nombre}')),
            subtitle: Column(
              children: [
              SizedBox(height: 15.0),
              Container(
                width: 200.0,
                height: 200.0,
                color: Colors.black26,
                child: Center(child: Icon(Icons.image)),
              ),
              SizedBox(height: 15.0),
              Text('2AN1.Arrendadora: ${producto.stockA}'),
              SizedBox(height: 5.0),
              Text('2AN2.Servicio Liviano: ${producto.stockB}'),
              SizedBox(height: 5.0),
              Text('2AN3.Servicio Pesado: ${producto.stockC}'),
              ]
            )
          ),
        ],
      ),
    );

  }

  Future _refrescar() async {
  
    Duration carga = new Duration(seconds: 2);
    new Timer(carga, () {
      build(context);
    });
    return Future.delayed(carga);
  }

  void _eliminar(SeccionModel seccion) {

    final color = TextStyle(color: Colors.white); 

    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) {

        return StreamBuilder(
          stream: productoBloc.productoStream,
          builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {

            if (snapshot.hasData) {
              final producto = snapshot.data;

              if(producto.length == 0) {
                return _sielimina(color, seccion);
              } else {
                return _noelimina(color);
              }

            } else {
              return Container();
            }

          }
        );

      }
    );    

  }

  Widget _sielimina(TextStyle color, SeccionModel seccion) {

    return AlertDialog(
      title: Text('¿Esta seguro que desea eliminar esta seccion?'),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blueAccent
          ),
          child: Text('No', style: color),
          onPressed: (){
            Navigator.of(context).pop();
          }, 
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
                
            seccionProvider.eliminarSeccion(seccion);
            seccionBloc.cargarSeccion();

            final snack = utils.snackBar('Seccion eliminada con exito');
            ScaffoldMessenger.of(context).showSnackBar(snack);                 
              
          }, 
        )
      ],
    );
    

  }

  Widget _noelimina(TextStyle color) {

    return AlertDialog(
      title: Text('No puede eliminar esta seccion porque hay productos asociados a ella'),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blueAccent
          ),
          child: Text('volver', style: color),
          onPressed: (){
            Navigator.of(context).pop();
          }, 
        ),
      ],
    );
  }
  
}