import 'dart:convert';
//importamos el paquete http. Este paquete primero debe ser importado en el archivo "pubspec.yaml"
//el "as http" que se define en la importacion es para trabajar de una manera mas clara cuando se usan las funciones del paquete http.
//EJ: http.get(Uri.parse(url)); => llamamos http.get para realizar la peticion a la url
import 'package:http/http.dart' as http;

//Modelo
import 'package:vision_one/modelo/producto_model.dart';


class ProductoProvider{
  
  //definimos parte de la url donde se haran las consultas
  final String _dominio = 'http://192.168.1.86:5000';
  //creamos una instancia del modelo del producto
  final producto = new ProductoModel();

  //Creamos un metodo de tipo Future que debe regresar una lista de productos. el metodo se llama "cargarProducto".
  
  //******************************************  EXPLICACION DEL FUTURE   ************************************************* */ 
  //los metodos de tipo Future son de un tipo que entregaran su informacion en un futuro determinado.
  //Se usan mucho en peticiones http donde la consulta no es inmediata, sino que toma unos segundos.
  //Para que el programa no se detenga ni cause algun error esperando la respuesta que queremos. Por eso se usan los Future
  //que deben ir acompañados siempre de un "async". esto define al metodo como "asincrono".
  
  //el metodo a su vez debe recibir el ID de la seccion para poder cargar solo los productos asociados a esa seccion.
  //la variable "idseccion" se usa mas adelante.
  Future<List<ProductoModel>> cargarProducto(int idseccion) async {    
    //creamos una variable que tendra todo el url donde hacer la peticion
    final url = '$_dominio/producto';
    //creamos una variable que ESPERARA(await) la respuesta de la peticion. En la funcion get debemos mandar un Uri (Uniform Resource Locator)
    //(Localizador de recursos uniforme). la variable "url" al no ser un Uri debemos "parsearlo" usando el ".parse". 
    // parsear: Proceso de analizar una secuencia de símbolos a fin de determinar su estructura gramatical definida
    final resp = await http.get(Uri.parse(url));
    //creamos una variable que tendra la informacion de la peticion. esta informacion sera en un formato json
    final decodeData = json.decode(resp.body);
    //una variable de tipo lista de productos.
    final List<ProductoModel> lista = [];
    //condicion si la informacion en json es nula o no. si no tiene inforamcion, devuelve nulo.
    if(decodeData == null) return null;
    //recorremos toda la informacion del "decodeData" y la cada producto es almacenado en la variable "value".
    decodeData.forEach((value) {
      //creamos una variable que tendra toda la informacion de cada producto encontrado.
      final producto = ProductoModel.fromJson(value);
      //condicion si el idseccion que se recibio en el metodo es igual al idseccion que tiene el producto
      if(idseccion == producto.idseccion) 
      //si son el mismo id, añade el producto a la lista creada.
      lista.add(producto);

    });
    //regresa la lista con toda la informacion.
    return lista;

  }

  //Creamos un metodo Future de tipo bool el metodo recibe un producto para su creacion.
  void crearProducto(ProductoModel producto) async {
    //creamos una variable que tendra todo el url donde hacer la peticion
    final url = '$_dominio/producto';
    //para crear el producto debemos mandar mas contenido en la peticion.
    //en este caso creamos un Map que contiene dos datos utilles para leer la informacion y pasarla a un formato json.
    Map<String, String> header = {"content-type": "application/json"};
    //creamos una variable que esperara la repuesta del POST, en este caso aparte del parsear la url, mandamos el header, y el body. de aqui se obtiene la informacion
    //para crear el producto y guardarlo en la base de datos.
    await http.post(Uri.parse(url), headers: header, body: productoModelToJson(producto));
  }

  //creamos un metodo de tipo Future para modificar el producto
  void modificarProducto(ProductoModel producto) async {
    //recibimos el Id del producto para poder espeficiar que producto queremos modificar
    final id = producto.id;
    //creamos una variable que tendra todo el url donde realizar la peticion
    final url ='$_dominio/producto/$id';
    Map<String, String> header = {"content-type": "application/json"};
    //creamos una variable que esperara la repuesta del PUT, en este caso aparte del parsear la url, mandamos el header, y el body. de aqui se obtiene la informacion
    //para modificar el producto y guardarlo en la base de datos.
    await http.put(Uri.parse(url), headers: header, body: productoModelToJson(producto));

  }

  void eliminarProducto(ProductoModel producto) async {
    //recibimos el Id del producto para poder espeficiar que producto queremos eliminar
    final id = producto.id;
    //creamos una variable que tendra todo el url donde realizar la peticion    
    final url = '$_dominio/producto/$id';
    // esperamos a que se ejecute el delete. esta peticion debe recbir un Uri, entonces parseamos el url.
    await http.delete(Uri.parse(url));

  }
}

