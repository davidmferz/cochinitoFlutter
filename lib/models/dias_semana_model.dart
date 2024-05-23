// To parse this JSON data, do
//
//     final diasLaborales = diasLaboralesFromJson(jsonString);

import 'dart:convert';

List<DiasSemanaModel> listDiasSemanaModelFromJson(String str) => List<DiasSemanaModel>.from(
    json.decode(str).map((x) => DiasSemanaModel.fromJson(x)));

DiasSemanaModel diasSemanaModelFromJson(String str) => DiasSemanaModel.fromJson(json.decode(str));

String diasSemanaModelToJson(DiasSemanaModel data) => json.encode(data.toJson());

class DiasSemanaModel {
    int id;
    String diaSemana; 

    DiasSemanaModel({
        required this.id,
        required this.diaSemana, 
    });

    factory DiasSemanaModel.fromJson(Map<String, dynamic> json) => DiasSemanaModel(
        id: json["id"],
        diaSemana: json["dia_semana"], 
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dia_semana": diaSemana, 
    };
}
