import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {

  String  rut;
  String  rol;
  String  password;

  UsuarioModel ({
    this.rut,
    this.rol,
    this.password,
  });

    factory UsuarioModel.fromJson(Map<String, dynamic> json) => new UsuarioModel( 
      rut      : json["Rut"],
      rol      : json["Rol"],
      password : json["Password"],
    );

    Map<String, dynamic> toJson() => {
      "Rut"      : rut,
      "Rol"      : rol,
      "Password" : password,
    };

}