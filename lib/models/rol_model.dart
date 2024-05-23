// To parse this JSON data, do
//
//     final rolesModel = rolesModelFromJson(jsonString);

import 'dart:convert';

List<RolModel> listRolModelFromJson(String str) => List<RolModel>.from(
    json.decode(str).map((x) => RolModel.fromJson(x)));

RolModel rolModelFromJson(String str) => RolModel.fromJson(json.decode(str));

String rolModelToJson(RolModel data) => json.encode(data.toJson());

class RolModel {
    int id;
    String tipoRol;

    RolModel({
        required this.id,
        required this.tipoRol,
    });

    factory RolModel.fromJson(Map<String, dynamic> json) => RolModel(
        id: json["id"],
        tipoRol: json["tipo_rol"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_rol": tipoRol,
    };
}