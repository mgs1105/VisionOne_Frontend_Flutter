import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';


import 'package:vision_one/modelo/seccion_model.dart';
import 'package:vision_one/provider/seccion_provider.dart';

class SeccionBloc {

  final _seccionController = new BehaviorSubject<List<SeccionModel>>();
  final _seccionProvider = new SeccionProvider();

  Stream<List<SeccionModel>> get seccionStream => _seccionController.stream;

  Future cargarSeccion() async {

    final secciones = await _seccionProvider.cargarSeccion();
    _seccionController.sink.add(secciones);

  }


  void dispose(){
    _seccionController?.close();
  }

}