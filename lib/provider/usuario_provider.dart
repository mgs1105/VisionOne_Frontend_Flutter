import 'dart:convert';
import 'package:http/http.dart' as http;

//Model
import 'package:vision_one/modelo/usuario_model.dart';

class UsuarioProvider{

  final String _dominio = 'http://192.168.1.86:5000';
  final usuario = new UsuarioModel();

  Future<List<UsuarioModel>> cargarUsuario() async {

    final url = '$_dominio/usuario';
    final resp = await http.get(Uri.parse(url));
    final decodeData = json.decode(resp.body);

    final List<UsuarioModel> lista = [];

    if(decodeData == null) return [];

    decodeData.forEach((value) {

      final usuario = UsuarioModel.fromJson(value);

      lista.add(usuario);

    });

    return lista;
  }

  Future<bool> crearUsuario(UsuarioModel usuario) async {

    final url = '$_dominio/usuario';
    Map<String, String> header = {"content-type": "application/json"};
    final resp = await http.post(Uri.parse(url), headers: header, body: usuarioModelToJson(usuario));    

    return true;
  }

  Future<bool> modificarUsuario(UsuarioModel usuario) async {

    final rut = usuario.rut;

    final url = '$_dominio/usuario/$rut';
    Map<String, String> header = {"content-type": "application/json"};
    final resp = await http.put(Uri.parse(url),headers: header, body: usuarioModelToJson(usuario));

    return true;
  }

  void eliminarUsuario(UsuarioModel usuario) async {

    final rut = usuario.rut;

    final url = '$_dominio/usuario/$rut';
    final resp = await http.delete(Uri.parse(url));


  }

  Future<bool> validaUsuario(UsuarioModel usuario) async {

    final url = '$_dominio/login';
    Map<String, String> header = {"content-type": "application/json"};
    final resp = await http.post(Uri.parse(url), headers: header, body: usuarioModelToJson(usuario));
    final decodeData = json.decode(resp.body);    

    
    return decodeData;
  }
}

