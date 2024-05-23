import 'dart:convert';

DireccionModel direccionModelFromJson(String str) => DireccionModel.fromJson(json.decode(str));

String direccionModelToJson(DireccionModel data) => json.encode(data.toJson());

class DireccionModel {
    int id;
    int userId;
    String estado;
    String municipio;
    String colonia;
    String direccion;
    String exterior;
    String? interior;
    String codigoPostal;

    DireccionModel({
        required this.id,
        required this.userId,
        required this.estado,
        required this.municipio,
        required this.colonia,
        required this.direccion,
        required this.exterior,
        this.interior,
        required this.codigoPostal,
    });

    factory DireccionModel.fromJson(Map<String, dynamic> json) => DireccionModel(
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
