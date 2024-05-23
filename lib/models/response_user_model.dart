import 'dart:convert';

import 'package:cochinito_flutter/models/direccion_model.dart';
import 'package:cochinito_flutter/models/empresa_model.dart';
import 'package:cochinito_flutter/models/rol_model.dart';
import 'package:cochinito_flutter/models/tipo_nomina_model.dart';

ResponseUserModel responseUserModelFromJson(String str) =>
    ResponseUserModel.fromJson(json.decode(str));

String responseUserModelToJson(ResponseUserModel data) =>
    json.encode(data.toJson());

class ResponseUserModel {
  int id;
  int rolId;
  String isActive;
  String nombre;
  String apellidoPaterno;
  String apellidoMaterno;
  String rfc;
  String telefonoPrincipal;
  String telefonoSecundario;
  int? nominaId;
  String nomina;
  String email;
  dynamic emailVerifiedAt;
  int? empresaId;
  dynamic tokenApp;
  String createdAt;
  String updatedAt;
  RolModel rol;
  TipoNominaModel? tipoNomina;
  EmpresaModel? empresa;
  List<DireccionModel>? direcciones;

  ResponseUserModel({
    required this.id,
    required this.rolId,
    required this.isActive,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.rfc,
    required this.telefonoPrincipal,
    required this.telefonoSecundario,
    this.nominaId,
    required this.nomina,
    required this.email,
    this.emailVerifiedAt,
    this.empresaId,
    this.tokenApp,
    required this.createdAt,
    required this.updatedAt,
    required this.rol,
    this.tipoNomina,
    this.empresa,
    this.direcciones,
  });

  factory ResponseUserModel.fromJson(Map<String, dynamic> json) {
    return ResponseUserModel(
      id: json["id"] ?? 0,
      rolId: json["rol_id"] ?? 0,
      isActive: json["is_active"] ?? '',
      nombre: json["nombre"] ?? '',
      apellidoPaterno: json["apellido_paterno"] ?? '',
      apellidoMaterno: json["apellido_materno"] ?? '',
      rfc: json["rfc"] ?? '',
      telefonoPrincipal: json["telefono_principal"] ?? '',
      telefonoSecundario: json["telefono_secundario"] ?? '',
      nominaId: json["nomina_id"] ?? 0,
      nomina: json["nomina"] ?? '' ,
      email: json["email"] ?? '',
      emailVerifiedAt: json["email_verified_at"] ?? '',
      empresaId: json["empresa_id"] ?? 0,
      tokenApp: json["token_app"] ?? '',
      createdAt: json["created_at"] ?? '',
      updatedAt: json["updated_at"] ?? '',
      rol: RolModel.fromJson(json["rol"] ?? {}),
      tipoNomina: json["tipo_nomina"] != null
          ? TipoNominaModel.fromJson(json["tipo_nomina"])
          : null,
      empresa: json["empresa"] != null
          ? EmpresaModel.fromJson(json['empresa'])
          : null,
      direcciones: json["direcciones"] != null
          ? List<DireccionModel>.from(
              json["direcciones"].map((x) => DireccionModel.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      "token_app": tokenApp,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "rol": rol.toJson(),
      "tipo_nomina": tipoNomina?.toJson(),
      "empresa": empresa?.toJson(),
      "direcciones":
          direcciones != null ? List<dynamic>.from(direcciones!.map((x) => x.toJson())) : null,
    };
  }
}
