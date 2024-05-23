// To parse this JSON data, do
//
//     final diasFestivosModel = diasFestivosModelFromJson(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';

List<DiasFestivosModel> listDiasFestivosModelFromJson(String str) => List<DiasFestivosModel>.from(
    json.decode(str).map((x) => DiasFestivosModel.fromJson(x)));

DiasFestivosModel diasFestivosModelFromJson(String str) => DiasFestivosModel.fromJson(json.decode(str));

String diasFestivosModelToJson(DiasFestivosModel data) => json.encode(data.toJson());

class DiasFestivosModel {
    int id;
    String fecha;

    DiasFestivosModel({
        required this.id,
        required this.fecha,
    });

    factory DiasFestivosModel.fromJson(Map<String, dynamic> json) => DiasFestivosModel(
        id: json["id"],
        fecha: DateFormat('dd-MM-yyyy').format(DateTime.parse(json["fecha"])),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": fecha,
    };
}
