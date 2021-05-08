import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {

  String  id;
  String  nombre;
  String  descripcion;
  int     stockA;
  int     stockB;
  int     stockC;


  ProductoModel ({
    this.id      = '',
    this.nombre  = '',
    this.descripcion,
    this.stockA,
    this.stockB,
    this.stockC
  });

    factory ProductoModel.fromJson(Map<String, dynamic> json) => new ProductoModel( 
      id          : json["id"],
      nombre      : json["nombre"],
      descripcion : json["descripcion"],
      stockA      : json["stockA"],
      stockB      : json["stockB"],
      stockC      : json["stockC"]
    );

    Map<String, dynamic> toJson() => {
      "id"          : id,
      "nombre"      : nombre,
      "descripcion" : descripcion,
      "stockA"      : stockA,
      "stockB"      : stockB,
      "stockC"      : stockC
    };

}