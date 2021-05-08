import 'dart:convert';

SeccionModel seccionModelFromJson(String str) => SeccionModel.fromJson(json.decode(str));

String seccionModelToJson(SeccionModel data) => json.encode(data.toJson());

class SeccionModel {

  String  id;
  String  nombre;
  int     cantidad;


  SeccionModel ({
    this.id      = '',
    this.nombre  = '',
    this.cantidad,
  });

    factory SeccionModel.fromJson(Map<String, dynamic> json) => new SeccionModel( 
      id       : json["id"],
      nombre   : json["nombre"],
      cantidad : json["cantidad"],
    );

    Map<String, dynamic> toJson() => {
      "id"       : id,
      "nombre"   : nombre,
      "cantidad" : cantidad,
    };

}