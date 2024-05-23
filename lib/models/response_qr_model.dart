// To parse this JSON data, do
//
//     final responseQrModel = responseQrModelFromJson(jsonString);

import 'dart:convert';

ResponseQrModel responseQrModelFromJson(String str) => ResponseQrModel.fromJson(json.decode(str));

String responseQrModelToJson(ResponseQrModel data) => json.encode(data.toJson());

class ResponseQrModel {
    String rfc;
    String regimen;
    String estado;
    String municipio;
    String colonia;
    String direccion;
    String exterior;
    String interior;
    String codigoPostal;
    String email;
    String nombre;

    ResponseQrModel({
        required this.rfc,
        required this.regimen,
        required this.estado,
        required this.municipio,
        required this.colonia,
        required this.direccion,
        required this.exterior,
        required this.interior,
        required this.codigoPostal,
        required this.email,
        required this.nombre,
    });

    factory ResponseQrModel.fromJson(Map<String, dynamic> json) => ResponseQrModel(
        rfc: json["rfc"],
        regimen: json["regimen"],
        estado: json["estado"],
        municipio: json["municipio"],
        colonia: json["colonia"],
        direccion: json["direccion"],
        exterior: json["exterior"],
        interior: json["interior"],
        codigoPostal: json["codigo_postal"],
        email: json["email"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "rfc": rfc,
        "regimen": regimen,
        "estado": estado,
        "municipio": municipio,
        "colonia": colonia,
        "direccion": direccion,
        "exterior": exterior,
        "interior": interior,
        "codigo_postal": codigoPostal,
        "email": email,
        "nombre": nombre,
    };
}
