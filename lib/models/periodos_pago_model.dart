// To parse this JSON data, do
//
//     final periodosPagoModel = periodosPagoModelFromJson(jsonString);

import 'dart:convert';

List<PeriodosPagoModel> listPeriodosPagoModelFromJson(String str) => List<PeriodosPagoModel>.from(
    json.decode(str).map((x) => PeriodosPagoModel.fromJson(x)));

PeriodosPagoModel periodosPagoModelFromJson(String str) => PeriodosPagoModel.fromJson(json.decode(str));

String periodosPagoModelToJson(PeriodosPagoModel data) => json.encode(data.toJson());

class PeriodosPagoModel {
    int id;
    int nominaId;
    int empresaId;
    int? diaMensual;
    int? primerDiaQuincena;
    int? segundoDiaQuincena;
    int? diaCatorcena;
    String? tipoCatorcena;
    int? diaSemanal;

    PeriodosPagoModel({
        required this.id,
        required this.nominaId,
        required this.empresaId,
        this.diaMensual,
        this.primerDiaQuincena,
        this.segundoDiaQuincena,
        this.diaCatorcena,
        this.tipoCatorcena,
        this.diaSemanal,
    });

    factory PeriodosPagoModel.fromJson(Map<String, dynamic> json) => PeriodosPagoModel(
        id: json["id"],
        nominaId: json["nomina_id"],
        empresaId: json["empresa_id"],
        diaMensual: json["dia_mensual"],
        primerDiaQuincena: json["primer_dia_quincena"],
        segundoDiaQuincena: json["segundo_dia_quincena"],
        diaCatorcena: json["dia_catorcena"],
        tipoCatorcena: json["tipo_catorcena"],
        diaSemanal: json["dia_semanal"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nomina_id": nominaId,
        "empresa_id": empresaId,
        "dia_mensual": diaMensual,
        "primer_dia_quincena": primerDiaQuincena,
        "segundo_dia_quincena": segundoDiaQuincena,
        "dia_catorcena": diaCatorcena,
        "tipo_catorcena": tipoCatorcena,
        "dia_semanal": diaSemanal,
    };
}
