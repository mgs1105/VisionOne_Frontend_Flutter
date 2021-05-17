import 'dart:convert';

SeccionModel seccionModelFromJson(String str) => SeccionModel.fromJson(json.decode(str));

String seccionModelToJson(SeccionModel data) => json.encode(data.toJson());

class SeccionModel {

  int     id;
  String  nombre;

  SeccionModel ({
    this.id,
    this.nombre  = '',
  });

    factory SeccionModel.fromJson(Map<String, dynamic> json) => new SeccionModel( 
      id       : json["Id"],
      nombre   : json["Nombre"],
    );

    Map<String, dynamic> toJson() => {
      "Id"       : id,
      "Nombre"   : nombre,
    };

}