import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {

  int     id;
  String  nombre;
  String  descripcion;
  int     stockA;
  int     stockB;
  int     stockC;
  int     idseccion;


  ProductoModel ({
    this.id,
    this.nombre  = '',
    this.descripcion,
    this.stockA,
    this.stockB,
    this.stockC,
    this.idseccion
  });

    factory ProductoModel.fromJson(Map<String, dynamic> json) => new ProductoModel( 
      id          : json["Id"],
      nombre      : json["Nombre"],
      descripcion : json["Descripcion"],
      stockA      : json["StockA"],
      stockB      : json["StockB"],
      stockC      : json["StockC"],
      idseccion   : json["Idseccion"]
    );

    Map<String, dynamic> toJson() => {
      "Id"          : id,
      "Nombre"      : nombre,
      "Descripcion" : descripcion,
      "StockA"      : stockA,
      "StockB"      : stockB,
      "StockC"      : stockC,
      "Idseccion"   : idseccion,
    };

}