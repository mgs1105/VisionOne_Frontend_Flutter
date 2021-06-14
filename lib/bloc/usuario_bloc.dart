import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import 'package:vision_one/modelo/usuario_model.dart';
import 'package:vision_one/provider/usuario_provider.dart';

class UsuarioBloc { 

  final _usuarioController = new BehaviorSubject<List<UsuarioModel>>();
  final _usuarioProvider = new UsuarioProvider();

  Stream<List<UsuarioModel>> get usuarioStream => _usuarioController.stream;

  Future cargarUsuario() async {

    final usuarios = await _usuarioProvider.cargarUsuario();
    _usuarioController.sink.add(usuarios);

  }

  void dispose() {
    _usuarioController?.close();
  }

}