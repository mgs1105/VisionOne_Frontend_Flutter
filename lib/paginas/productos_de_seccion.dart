import 'dart:async';

import 'package:flutter/material.dart';

import 'package:vision_one/bloc/producto_bloc.dart';
import 'package:vision_one/modelo/producto_model.dart';
import 'package:vision_one/modelo/seccion_model.dart';

class ProductosPage extends StatefulWidget {
  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {

  ProductoBloc productoBloc = new ProductoBloc();
  ProductoModel productoModel = new ProductoModel();
  SeccionModel seccionModel = new SeccionModel();


  @override
  Widget build(BuildContext context) {

    final tamano = MediaQuery.of(context).size;
    final SeccionModel seccion = ModalRoute.of(context).settings.arguments;
    productoBloc.cargarProducto(seccion.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('${seccion.nombre}'),
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

          return RefreshIndicator(
            onRefresh: _refrescar,
            child: ListView.builder(
              itemCount: producto.length,
              itemBuilder: (BuildContext context, int i) 
              => _producto(context ,producto[i], seccion),
            )
          );
          

        } else {
          return Center(child: CircularProgressIndicator());
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

}