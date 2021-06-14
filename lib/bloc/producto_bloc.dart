import 'dart:async';
import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import 'package:vision_one/modelo/producto_model.dart';
import 'package:vision_one/provider/producto_provider.dart';


class ProductoBloc {

  final _productoController = new BehaviorSubject<List<ProductoModel>>();
  final _productoProvider = new ProductoProvider();

  final _cargandoController = new BehaviorSubject<bool>();

  Stream<List<ProductoModel>> get productoStream => _productoController.stream;
   Stream<List<ProductoModel>> get cargandoStream  => _productoController.stream;

  Future cargarProducto(int idseccion) async {

    final productos = await _productoProvider.cargarProducto(idseccion);
    _productoController.sink.add(productos);

  }

  Future<String> subirFoto(File foto) async {
    
    _cargandoController.sink.add(true);
    final fotoURL = await _productoProvider.subirImgen(foto);
    _cargandoController.sink.add(false);

    return fotoURL;

  }

  void dispose(){
    _productoController?.close();
    _cargandoController?.close();
  }

}