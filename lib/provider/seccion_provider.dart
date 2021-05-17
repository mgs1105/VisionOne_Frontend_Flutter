import 'dart:convert';
import 'package:http/http.dart' as http;

//Model
import 'package:vision_one/modelo/seccion_model.dart';

class SeccionProvider {

  final String _dominio = 'http://192.168.1.86:5000';
  final seccionModel = new SeccionModel();

  Future<List<SeccionModel>> cargarSeccion() async {    

    final url = '$_dominio/seccion';
    final resp = await http.get(Uri.parse(url));
    final decodeData = json.decode(resp.body);

    final List<SeccionModel> lista = [];

    if(decodeData == null) return [];

    decodeData.forEach((value) {
      
      final seccion = SeccionModel.fromJson(value);

      lista.add(seccion);

    });

    return lista;

  }

  Future<bool> crearSeccion(SeccionModel seccion) async {

    final url = '$_dominio/seccion';
    Map<String, String> header = {"Content-type": "application/json"};
    final resp = await http.post(Uri.parse(url), headers:header,body: seccionModelToJson(seccion));

    return true;
  }

}

