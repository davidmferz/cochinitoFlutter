import 'dart:convert';

List<TipoNominaModel> listTipoNominaModelFromJson(String str) => List<TipoNominaModel>.from(
    json.decode(str).map((x) => TipoNominaModel.fromJson(x)));
    
TipoNominaModel tipoNominaModelModelFromJson(String str) => TipoNominaModel.fromJson(json.decode(str));

String tipoNominaModelModelToJson(TipoNominaModel data) => json.encode(data.toJson());

class TipoNominaModel {
    int id;
    String tipoNomina;

    TipoNominaModel({
        required this.id,
        required this.tipoNomina,
    });

    factory TipoNominaModel.fromJson(Map<String, dynamic> json) => TipoNominaModel(
        id: json["id"],
        tipoNomina: json["tipo_nomina"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo_nomina": tipoNomina,
    };
}
