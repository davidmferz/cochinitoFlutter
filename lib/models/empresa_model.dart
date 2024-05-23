import 'dart:convert';

List<EmpresaModel> listEmpresaModelFromJson(String str) => List<EmpresaModel>.from(
    json.decode(str).map((x) => EmpresaModel.fromJson(x)));

EmpresaModel empresaModelFromJson(String str) => EmpresaModel.fromJson(json.decode(str));

String empresaModelToJson(EmpresaModel data) => json.encode(data.toJson());
  
class EmpresaModel {
    int id;
    String nombreEmpresa;
    int creditosCount;

    EmpresaModel({
        required this.id,
        required this.nombreEmpresa,
        required this.creditosCount,
        
    });

    factory EmpresaModel.fromJson(Map<String, dynamic> json) => EmpresaModel(
        id: json["id"],
        nombreEmpresa: json["nombre_empresa"],
        creditosCount: json["creditos_count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_empresa": nombreEmpresa,
        "creditos_count": creditosCount,
    };
}