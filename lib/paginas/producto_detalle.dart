import 'package:flutter/material.dart';
import 'package:vision_one/bloc/producto_bloc.dart';
import 'package:vision_one/modelo/producto_model.dart';
import 'package:vision_one/modelo/seccion_model.dart';
import 'package:vision_one/provider/producto_provider.dart';

import 'package:vision_one/utils/utils.dart' as utils;

class ProdDetallePage extends StatefulWidget {
  @override
  _ProdDetallePageState createState() => _ProdDetallePageState();
}

class _ProdDetallePageState extends State<ProdDetallePage> {

  final keyformulario = GlobalKey<FormState>();

  ProductoProvider productoProvider = new ProductoProvider();
  ProductoBloc productoBloc = new ProductoBloc();

  @override
  Widget build(BuildContext context) {

    final List<Object> opcion = ModalRoute.of(context).settings.arguments;
    final ProductoModel producto = opcion[0];
    final SeccionModel seccion = opcion[1];

    final tamano = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Detalle del producto'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever), 
            color: Colors.white,
            iconSize: 30.0,
            onPressed: () => _eliminar(producto, seccion)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: _body(producto, tamano),
        ) 
      ),
    );
            
  } 

  void _eliminar(ProductoModel producto, SeccionModel seccion) {

    final color = TextStyle(color: Colors.white); 
    SeccionModel seccion = new SeccionModel();

    seccion.id = producto.idseccion;

    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (context) => _alertas(producto, seccion, color)
    );

  }

  Widget _alertas(ProductoModel producto, SeccionModel seccion, TextStyle color) {

    if(producto.stockA == 0 && producto.stockB == 0 && producto.stockC == 0) {

    final color = TextStyle(color: Colors.white); 

      return AlertDialog(
        title: Text('Esta seguro que desea eliminar el producto?'),
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

              productoProvider.eliminarProducto(producto);
              productoBloc.cargarProducto(seccion.id);
              final snack = utils.snackBar('Producto eliminado con exito');
              ScaffoldMessenger.of(context).showSnackBar(snack);                    
            }, 
          )
        ],
      );
              
    } else {
        
      return AlertDialog(
        title: Text('No puede eliminar este producto porque aun cuenta con stock disponible en sucursales'),
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

  Widget _body(ProductoModel producto, Size tamano) {

    return  Column(
      children: [
        SizedBox(height: tamano.height * 0.03),
        Text('${producto.nombre}', style: TextStyle(fontSize: 18.0)),
        SizedBox(height: tamano.height * 0.03),
        Container(
          width: 200.0,
          height: 200.0,
          color: Colors.black26,
          child: Center(child: Icon(Icons.image)),
        ),
        SizedBox(height: tamano.height * 0.03),
        Text('Stock en Sucursales', style: TextStyle(fontSize: 18.0)),
        SizedBox(height: tamano.height * 0.03),
        _tabla(producto, tamano),
        SizedBox(height: tamano.height * 0.05),
        _boton(producto),
      ],
    );

  }

  Widget _tabla(ProductoModel producto, Size tamano) {

    final decoracion = InputDecoration(
      border: const OutlineInputBorder()
    );

    return Form(
      key: keyformulario,
      child: Table(
        children: [
          TableRow(
            children: [
              _sucursal('2AN1: Arrendadora'),
              Container(
                margin: EdgeInsets.only(right: 12.0, bottom: 10.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: producto.stockA.toString(),
                  decoration: decoracion,
                  validator: (value) {
                    if(value.length <= 0) {
                      return 'Debe especificar la cantidad';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) => producto.stockA = int.parse(value),
                ),
              ),
            ]
          ),
          TableRow(
            children: [
              _sucursal('2AN2: Servicio Liviano'),
              Container(
                margin: EdgeInsets.only(right: 12.0, bottom: 10.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: producto.stockB.toString(),
                  decoration: decoracion,
                  validator: (value) {
                    if(value.length <= 0) {
                      return 'Debe especificar la cantidad';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) => producto.stockB = int.parse(value),
                ),
              ),
            ]
          ),
          TableRow(
            children: [
              _sucursal('2AN3 Servicio Pesado'),
              Container(
                margin: EdgeInsets.only(right: 12.0, bottom: 10.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: producto.stockC.toString(),
                  decoration: decoracion,
                  validator: (value) {
                    if(value.length <= 0) {
                      return 'Debe especificar la cantidad';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) => producto.stockC = int.parse(value),
                ),
              ),
            ]
          )
        ],
      ),
    );

  }

  Widget _sucursal(String sucursal) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(20.0)
      ),
      margin: EdgeInsets.all(20.0),
      child: Text(sucursal, style: TextStyle(fontSize: 16.0)),
    );

  }

  Widget _boton(ProductoModel producto) {

    return TextButton(    
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 20.0)
      ),
      child: Text('Guardar cambios', style: TextStyle(color: Colors.white)),
      onPressed: () {

        if(!keyformulario.currentState.validate()) return;

        keyformulario.currentState.save();
        productoProvider.modificarProducto(producto);

            final snack = utils.snackBar('Producto modificado con exito');
            ScaffoldMessenger.of(context).showSnackBar(snack);       
      }, 
    );
  }

}
