// To parse this JSON data, do
//
//     final statusModel = statusModelFromJson(jsonString);

import 'dart:convert';
List<StatusModel> listStatusModelFromJson(String str) => List<StatusModel>.from(
    json.decode(str).map((x) => StatusModel.fromJson(x)));

StatusModel statusModelFromJson(String str) => StatusModel.fromJson(json.decode(str));

String statusModelToJson(StatusModel data) => json.encode(data.toJson());

class StatusModel {
    int id;
    String nombreStatus;

    StatusModel({
        required this.id,
        required this.nombreStatus,
    });

    factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        id: json["id"],
        nombreStatus: json["nombre_status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_status": nombreStatus,
    };
}
