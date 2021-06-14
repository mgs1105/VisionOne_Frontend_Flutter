import 'package:flutter/material.dart';
import 'package:vision_one/modelo/producto_model.dart';
import 'package:vision_one/provider/producto_provider.dart';

class DataProd extends SearchDelegate {

  ProductoModel producto = new ProductoModel();
  ProductoProvider productoProvider = new ProductoProvider();

  @override
    // Acciones de nuestro appBar. EJ: un icono que elimine el texto
  List<Widget> buildActions(BuildContext context) {
      return [
        IconButton(
          icon: Icon(Icons.clear), 
          onPressed: () {
            query = '';
          },
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Icono a la izquierda del AppBar
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);
        },
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // Crea los resultados que se mostraran
      return Center(
        child: Container(
          height: 100.0,
          width: 100.0,
          color: Colors.blueAccent,
          child: Text('Resultado'),
        ),
      );
    }
  
    @override
    // Son las sugerencias que aparecen cuando la persona escribe
    Widget buildSuggestions(BuildContext context) {
      
      if(query.isEmpty) {
        return Container();
      } 

      return FutureBuilder(
        future: productoProvider.buscarProducto(query),
        builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {

          if(snapshot.hasData) {
            final productos = snapshot.data;
          
          return ListView(
            children: productos.map((producto) {
              return ListTile(
                title: Text(producto.nombre),
                subtitle: Column(
                  children: [
                    Text('2AN1: Arrendadora  ${producto.stockA}'),
                    Text('2AN2: Servicio Liviano  ${producto.stockB}'),
                    Text('2AN3 Servicio Pesado  ${producto.stockC}'),
                  ],
                ),
              );
            }).toList()
          );
          } else {
            return Center(child: CircularProgressIndicator());

          }



        }
      );

  }

  

}