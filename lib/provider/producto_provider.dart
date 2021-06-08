import 'dart:convert';
import 'package:http/http.dart' as http;

//Model
import 'package:vision_one/modelo/producto_model.dart';


class ProductoProvider{

  final String _dominio = 'http://192.168.1.86:5000';
  final producto = new ProductoModel();

  Future<List<ProductoModel>> cargarProducto(int idseccion) async {    

    final url = '$_dominio/producto';
    final resp = await http.get(Uri.parse(url));
    final decodeData = json.decode(resp.body);

    final List<ProductoModel> lista = [];

    if(decodeData == null) return null;

    decodeData.forEach((value) {
      
      final producto = ProductoModel.fromJson(value);

      if(idseccion == producto.idseccion) 

      lista.add(producto);

    });

    return lista;

  }

  Future<bool> crearProducto(ProductoModel producto) async {

    final url = '$_dominio/producto';
    Map<String, String> header = {"content-type": "application/json"};
    final resp = await http.post(Uri.parse(url), headers: header, body: productoModelToJson(producto));

    return true;
  }

  Future<bool> modificarProducto(ProductoModel producto) async {
    
    final id = producto.id;
    
    final url ='$_dominio/producto/$id';
    Map<String, String> header = {"content-type": "application/json"};
    final resp = await http.put(Uri.parse(url), headers: header, body: productoModelToJson(producto));
  

    return true;

  }

  void eliminarProducto(ProductoModel producto) async {

    final id = producto.id;

    final url = '$_dominio/producto/$id';
    final resp = await http.delete(Uri.parse(url));


  }
}

