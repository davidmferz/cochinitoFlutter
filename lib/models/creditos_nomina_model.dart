// To parse this JSON data, do
//
//     final creditosNominaModel = creditosNominaModelFromJson(jsonString);

import 'dart:convert';

import 'package:cochinito_flutter/models/models.dart';
import 'package:cochinito_flutter/models/users_model.dart';
import 'package:intl/intl.dart';

List<CreditosNominaModel> listCreditosNominaModelFromJson(String str) => List<CreditosNominaModel>.from(
    json.decode(str).map((x) => CreditosNominaModel.fromJson(x)));

CreditosNominaModel creditosNominaModelFromJson(String str) => CreditosNominaModel.fromJson(json.decode(str));

String creditosNominaModelToJson(CreditosNominaModel data) => json.encode(data.toJson());

class CreditosNominaModel {
    int id;
    int usuarioId;
    int nominaId;
    int empresaId;
    String fechaSolicitud;
    String fechaRealPagoNomina;
    String deduccionNomina;
    String porcentaje;
    int statusId;
    String createdAt;
    String updatedAt;
    StatusModel status;
    Users usuario;
    String condicionPorcentaje;
    

    CreditosNominaModel({
        required this.id,
        required this.usuarioId,
        required this.nominaId,
        required this.empresaId,
        required this.fechaSolicitud,
        required this.fechaRealPagoNomina,
        required this.deduccionNomina,
        required this.porcentaje,
        required this.statusId,
        required this.createdAt,
        required this.updatedAt,
        required this.status,
        required this.usuario,
        required this.condicionPorcentaje,
    });

    factory CreditosNominaModel.fromJson(Map<String, dynamic> json) => CreditosNominaModel(
        id: json["id"],
        usuarioId: json["usuario_id"],
        nominaId: json["nomina_id"],
        empresaId: json["empresa_id"],
        fechaSolicitud: DateFormat('dd-MM-yyyy').format(DateTime.parse(json["fecha_solicitud"])),
        fechaRealPagoNomina: DateFormat('dd-MM-yyyy').format(DateTime.parse(json["fecha_real_pago_nomina"])),
        deduccionNomina: json["deduccion_nomina"],
        porcentaje: json["porcentaje"],
        statusId: json["status_id"],
        createdAt: DateFormat('dd-MM-yyyy').format(DateTime.parse(json["created_at"])),
        updatedAt: DateFormat('dd-MM-yyyy').format(DateTime.parse(json["updated_at"])),
        status: StatusModel.fromJson(json["status"]),
        usuario: Users.fromJson(json["usuario"]),
        condicionPorcentaje: json["condicion_porcentaje"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "usuario_id": usuarioId,
        "nomina_id": nominaId,
        "empresa_id": empresaId,
        "fecha_solicitud": fechaSolicitud,
        "fecha_real_pago_nomina": fechaRealPagoNomina,
        "deduccion_nomina": deduccionNomina,
        "porcentaje": porcentaje,
        "status_id": statusId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "status": status.toJson(),
        "usuario": usuario.toJson(),
        "condicion_porcentaje": condicionPorcentaje,
    };
}
