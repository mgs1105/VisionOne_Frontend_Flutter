import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {

  String  rut;
  String  rol;
  //String  nombre;
  String  password;

  UsuarioModel ({
    this.rut      = '',
    this.rol      = '',
    //this.nombre   = '',
    this.password = '',
  });

    factory UsuarioModel.fromJson(Map<String, dynamic> json) => new UsuarioModel( 
      rut      : json["rut"],
      rol      : json["rol"],
      //nombre   : json["nombre"],
      password : json["password"],
    );

    Map<String, dynamic> toJson() => {
      "rut"      : rut,
      "rol"      : rol,
      //"nombre"   : nombre,
      "password" : password,
    };

}