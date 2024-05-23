// To parse this JSON data, do
//
//     final diasLaborales = diasLaboralesFromJson(jsonString);

import 'dart:convert';

List<DiasLaboralesModel> listDiasLaboralesModelFromJson(String str) => List<DiasLaboralesModel>.from(
    json.decode(str).map((x) => DiasLaboralesModel.fromJson(x)));

DiasLaboralesModel diasLaboralesModelFromJson(String str) => DiasLaboralesModel.fromJson(json.decode(str));

String diasLaboralesModelToJson(DiasLaboralesModel data) => json.encode(data.toJson());

class DiasLaboralesModel {
    int id;
    String diaSemana;
    String status;

    DiasLaboralesModel({
        required this.id,
        required this.diaSemana,
        required this.status,
    });

    factory DiasLaboralesModel.fromJson(Map<String, dynamic> json) => DiasLaboralesModel(
        id: json["id"],
        diaSemana: json["dia_semana"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dia_semana": diaSemana,
        "status": status,
    };
}
