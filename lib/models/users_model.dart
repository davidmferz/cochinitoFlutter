// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromJson(jsonString);

import 'dart:convert';

UsersResponse usersResponseFromJson(String str) =>
    UsersResponse.fromJson(json.decode(str));

String usersResponseToJson(UsersResponse data) => json.encode(data.toJson());

class UsersResponse {
  List<Users>? response;
  String? status;

  UsersResponse({
    this.response,
    this.status,
  });

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        response: json["response"] == null
            ? []
            : List<Users>.from(json["response"]!.map((x) => Users.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "response": response == null
            ? []
            : List<dynamic>.from(response!.map((x) => x.toJson())),
        "status": status,
      };
}

class Users {
  int? id;
  int? rolId;
  String? isActive;
  String? nombre;
  String? apellidoPaterno;
  String? apellidoMaterno;
  String? rfc;
  String? telefonoPrincipal;
  String? telefonoSecundario;
  int? nominaId;
  String? nomina;
  String? email;
  dynamic emailVerifiedAt;
  int? empresaId;
  TokenApp? tokenApp;
  DateTime? createdAt;
  DateTime? updatedAt;
  Rol? rol;
  TipoNomina? tipoNomina;
  Empresa? empresa;
  List<Direccione>? direcciones;
 String? contratoFirmado;

  Users({
    this.id,
    this.rolId,
    this.isActive,
    this.nombre,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.rfc,
    this.telefonoPrincipal,
    this.telefonoSecundario,
    this.nominaId,
    this.nomina,
    this.email,
    this.emailVerifiedAt,
    this.empresaId,
    this.tokenApp,
    this.createdAt,
    this.updatedAt,
    this.rol,
    this.tipoNomina,
    this.empresa,
    this.direcciones,
    this.contratoFirmado
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        rolId: json["rol_id"],
        isActive: json["is_active"],
        nombre: json["nombre"],
        apellidoPaterno: json["apellido_paterno"],
        apellidoMaterno: json["apellido_materno"],
        rfc: json["rfc"],
        telefonoPrincipal: json["telefono_principal"],
        telefonoSecundario: json["telefono_secundario"],
        nominaId: json["nomina_id"],
        nomina: json["nomina"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        empresaId: json["empresa_id"],
        tokenApp: json["token_app"] == null
            ? null
            : TokenApp.fromJson(json["token_app"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        rol: json["rol"] == null ? null : Rol.fromJson(json["rol"]),
        tipoNomina: json["tipo_nomina"] == null
            ? null
            : TipoNomina.fromJson(json["tipo_nomina"]),
        empresa:
            json["empresa"] == null ? null : Empresa.fromJson(json["empresa"]),
        contratoFirmado: json["contratoFirmado"],
        direcciones: json["direcciones"] == null
            ? []
            : List<Direccione>.from(
                json["direcciones"]!.map((x) => Direccione.fromJson(x))),
        
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rol_id": rolId,
        "is_active": isActive,
        "nombre": nombre,
        "apellido_paterno": apellidoPaterno,
        "apellido_materno": apellidoMaterno,
        "rfc": rfc,
        "telefono_principal": telefonoPrincipal,
        "telefono_secundario": telefonoSecundario,
        "nomina_id": nominaId,
        "nomina": nomina,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "empresa_id": empresaId,
        "token_app": tokenApp?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "rol": rol?.toJson(),
        "tipo_nomina": tipoNomina?.toJson(),
        "empresa": empresa?.toJson(),
        "direcciones": direcciones == null
            ? []
            : List<dynamic>.from(direcciones!.map((x) => x.toJson())),
        "contratoFirmado": contratoFirmado,
      };
}

class Direccione {
  int? id;
  int? userId;
  String? estado;
  String? municipio;
  String? colonia;
  String? direccion;
  String? exterior;
  String? interior;
  String? codigoPostal;

  Direccione({
    this.id,
    this.userId,
    this.estado,
    this.municipio,
    this.colonia,
    this.direccion,
    this.exterior,
    this.interior,
    this.codigoPostal,
  });

  factory Direccione.fromJson(Map<String, dynamic> json) => Direccione(
        id: json["id"],
        userId: json["user_id"],
        estado: json["estado"],
        municipio: json["municipio"],
        colonia: json["colonia"],
        direccion: json["direccion"],
        exterior: json["exterior"],
        interior: json["interior"],
        codigoPostal: json["codigo_postal"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "estado": estado,
        "municipio": municipio,
        "colonia": colonia,
        "direccion": direccion,
        "exterior": exterior,
        "interior": interior,
        "codigo_postal": codigoPostal,
      };
}

class Empresa {
  int? id;
  String? nombreEmpresa;

  Empresa({
    this.id,
    this.nombreEmpresa,
  });

  factory Empresa.fromJson(Map<String, dynamic> json) => Empresa(
        id: json["id"],
        nombreEmpresa: json["nombre_empresa"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_empresa": nombreEmpresa,
      };
}

class Rol {
  int? id;
  String? tipoRol;

  Rol({
    this.id,
    this.tipoRol,
  });

  factory Rol.fromJson(Map<String, dynamic> json) => Rol(
        id: json["id"],
        tipoRol: json["tipo_rol"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_rol": tipoRol,
      };
}

class TipoNomina {
  int? id;
  String? tipoNomina;

  TipoNomina({
    this.id,
    this.tipoNomina,
  });

  factory TipoNomina.fromJson(Map<String, dynamic> json) => TipoNomina(
        id: json["id"],
        tipoNomina: json["tipo_nomina"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_nomina": tipoNomina,
      };
}

class TokenApp {
  String?
      f4L9F13Y5U3RnUaKgK61IjApa91BGpbRqhm7JEf5VUi8R9Ccx7ReJ209CRy08THlL3DnTzNx4PdXqcbUwdtEdrhBaBoAcL6KR314EshwTu2EVe6BL3Mu1BhdCuMht269Dxj9C6YsXgnGpYcI1VNj6HrYUzBCby;

  TokenApp({
    this.f4L9F13Y5U3RnUaKgK61IjApa91BGpbRqhm7JEf5VUi8R9Ccx7ReJ209CRy08THlL3DnTzNx4PdXqcbUwdtEdrhBaBoAcL6KR314EshwTu2EVe6BL3Mu1BhdCuMht269Dxj9C6YsXgnGpYcI1VNj6HrYUzBCby,
  });

  factory TokenApp.fromJson(Map<String, dynamic> json) => TokenApp(
        f4L9F13Y5U3RnUaKgK61IjApa91BGpbRqhm7JEf5VUi8R9Ccx7ReJ209CRy08THlL3DnTzNx4PdXqcbUwdtEdrhBaBoAcL6KR314EshwTu2EVe6BL3Mu1BhdCuMht269Dxj9C6YsXgnGpYcI1VNj6HrYUzBCby:
            json[
                "f4l9F13y5U3rnUaKgK61IJ:APA91bGpbRqhm7jEf_5VUi8-r9CCX7re-J209c-ry08tHlL3DnTzNX4PdXQCBUwdtEdrhBABoAcL6kR314ESHWTu2EVe6bL3mu1bhdCuMHT269Dxj9c6ysXgnGpYcI1vNJ6HrYUzBCby"],
      );

  Map<String, dynamic> toJson() => {
        "f4l9F13y5U3rnUaKgK61IJ:APA91bGpbRqhm7jEf_5VUi8-r9CCX7re-J209c-ry08tHlL3DnTzNX4PdXQCBUwdtEdrhBABoAcL6kR314ESHWTu2EVe6bL3mu1bhdCuMHT269Dxj9c6ysXgnGpYcI1vNJ6HrYUzBCby":
            f4L9F13Y5U3RnUaKgK61IjApa91BGpbRqhm7JEf5VUi8R9Ccx7ReJ209CRy08THlL3DnTzNx4PdXqcbUwdtEdrhBaBoAcL6KR314EshwTu2EVe6BL3Mu1BhdCuMht269Dxj9C6YsXgnGpYcI1VNj6HrYUzBCby,
      };
}
