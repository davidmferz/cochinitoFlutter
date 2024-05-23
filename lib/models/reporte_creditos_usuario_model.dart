// To parse this JSON data, do
//
//     final reporteCreditosUsuariosModel = reporteCreditosUsuariosModelFromJson(jsonString);

import 'dart:convert';

import 'package:cochinito_flutter/models/users_model.dart';

List<ReporteCreditosUsuariosModel> listReporteCreditosUsuariosModelFromJson(String str) => List<ReporteCreditosUsuariosModel>.from(
    json.decode(str).map((x) => ReporteCreditosUsuariosModel.fromJson(x)));

ReporteCreditosUsuariosModel reporteCreditosUsuariosModelFromJson(String str) => ReporteCreditosUsuariosModel.fromJson(json.decode(str));

String reporteCreditosUsuariosModelToJson(ReporteCreditosUsuariosModel data) => json.encode(data.toJson());

class ReporteCreditosUsuariosModel {
    String deduccionTotal;
    int usuarioId;
    Users usuario;

    ReporteCreditosUsuariosModel({
        required this.deduccionTotal,
        required this.usuarioId,
        required this.usuario,
    });

    factory ReporteCreditosUsuariosModel.fromJson(Map<String, dynamic> json) => ReporteCreditosUsuariosModel(
        deduccionTotal: json["deduccion_total"],
        usuarioId: json["usuario_id"],
        usuario: Users.fromJson(json["usuario"]),
    );

    Map<String, dynamic> toJson() => {
        "deduccion_total": deduccionTotal,
        "usuario_id": usuarioId,
        "usuario": usuario.toJson(),
    };
}
