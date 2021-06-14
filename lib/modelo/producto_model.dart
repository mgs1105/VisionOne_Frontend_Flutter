import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {

  int     id;
  String  nombre;
  int     stockA;
  int     stockB;
  int     stockC;
  int     idseccion;
  String  fotoURL;


  ProductoModel ({
    this.id,
    this.nombre  = '',
    this.stockA,
    this.stockB,
    this.stockC,
    this.idseccion,
    this.fotoURL
  });

    factory ProductoModel.fromJson(Map<String, dynamic> json) => new ProductoModel( 
      id          : json["Id"],
      nombre      : json["Nombre"],
      stockA      : json["StockA"],
      stockB      : json["StockB"],
      stockC      : json["StockC"],
      idseccion   : json["Idseccion"],
      fotoURL     : json["fotoURL"],
    );

    Map<String, dynamic> toJson() => {
      "Id"          : id,
      "Nombre"      : nombre,
      "StockA"      : stockA,
      "StockB"      : stockB,
      "StockC"      : stockC,
      "Idseccion"   : idseccion,
      "fotoURL"     : fotoURL,
    };

}