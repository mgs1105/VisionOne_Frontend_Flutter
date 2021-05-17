import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import 'package:vision_one/modelo/producto_model.dart';
import 'package:vision_one/provider/producto_provider.dart';


class ProductoBloc {

  final _productoController = new BehaviorSubject<List<ProductoModel>>();
  final _productoProvider = new ProductoProvider();

  Stream<List<ProductoModel>> get productoStream => _productoController.stream;

  Future cargarProducto(int idseccion) async {

    final productos = await _productoProvider.cargarProducto(idseccion);
    _productoController.sink.add(productos);

  }


  void dispose(){
    _productoController?.close();
  }

}