import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

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

  void crearProducto(ProductoModel producto) async {

    final url = '$_dominio/producto';
    Map<String, String> header = {"content-type": "application/json"};
    await http.post(Uri.parse(url), headers: header, body: productoModelToJson(producto));
  }

  void modificarProducto(ProductoModel producto) async {
    
    final id = producto.id;
    
    final url ='$_dominio/producto/$id';
    Map<String, String> header = {"content-type": "application/json"};
    await http.put(Uri.parse(url), headers: header, body: productoModelToJson(producto));

  }

  void eliminarProducto(ProductoModel producto) async {

    final id = producto.id;

    final url = '$_dominio/producto/$id';
    final resp = await http.delete(Uri.parse(url));


  }

  Future<String> subirImgen(File imagen) async {
    
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dposvsgu8/image/upload?upload_preset=sywzbrqu');
    final mimeType = mime(imagen.path).split('/');

    final cargarImagen = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType(mimeType[0], mimeType[1])
    );

    cargarImagen.files.add(file);

    final streamResponse = await cargarImagen.send();
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];


  }

  Future<List<ProductoModel>> buscarProducto(String query) async {    

    final url = '$_dominio/producto/$query';
    final resp = await http.get(Uri.parse(url));
    final decodeData = json.decode(resp.body);

    final List<ProductoModel> lista = [];

    if(decodeData == null) return null;

    decodeData.forEach((value) {
      
      final producto = ProductoModel.fromJson(value);

      lista.add(producto);

    });

    return lista;

  }

}

