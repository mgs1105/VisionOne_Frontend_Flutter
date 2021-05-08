import 'package:flutter/material.dart';

class ProductosPage extends StatefulWidget {
  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  @override
  Widget build(BuildContext context) {

    final tamano = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appbar(tamano),
          SliverList(delegate: SliverChildListDelegate(
            [_body(tamano)]
          ))
        ],
      ),
    );
  }

  Widget _appbar(Size tamano) {

    return SliverAppBar(
      title: Row(
        children: [
          Expanded(child: SizedBox()),
          Text('Baterias'),
          Expanded(child: SizedBox()),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.black12,
              elevation: 0.9
            ),
            onPressed:() => Navigator.pushNamed(context, 'crear_prod'),
            child: Text('Añadir Producto', style: TextStyle(color: Colors.white, fontSize: 13.0))
          )
        ],
      ),
    );


  }

  Widget _body(Size tamano) {

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: tamano.height * 0.01),
          Container(
            width: tamano.width * 1.0,
            height: tamano.height * 0.38,
            child: _producto(tamano),
          )
        ],
      ),
    );

  }

  Widget _producto(Size tamano) {

    final card = Container(
      child: Column(
        children: [
          SizedBox(height: 8.0),
          Container(
            width: tamano.width * 0.5,
            height: 100.0,
            //margin: EdgeInsets.only(top: 20.0, left: 15.0),
            child: Image(
              image: AssetImage('imagenes/producto.jpg'),
            ),
          ),
          SizedBox(height: tamano.height * 0.02),
          Center(child: Text('Nombre del producto')),
          SizedBox(height: tamano.height * 0.02),
          Center(child: _stock()),
        ],
      ),
    );

    return Container(
      margin: EdgeInsets.only(bottom: 15.0, left: 10.0, right: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 2.0,
          )
        ]
      ),
      child: ClipRRect(
        child: card,
        borderRadius: BorderRadius.circular(30.0),
      )
    );

  }

  Widget _stock() {

    return Container(
      margin: EdgeInsets.only(left: 100.0),
      child: Table(
        children: [
          TableRow(
            children: [
              Text('Sucursal Norte'),
              Text('5 prod'),
            ]
          ),
          TableRow(
            children: [
              Text('Sucursal Centro'),
              Text('3 prod'),
            ]
          ),
          TableRow(
            children: [
              Text('Sucursal Sur'),
              Text('7 prod'),
            ]
          )
        ],
      ),
    );

  }
}