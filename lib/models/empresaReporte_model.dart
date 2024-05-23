import 'dart:convert';

List<EmpresaReporteModel> listEmpresaReporteModelFromJson(String str) =>
    List<EmpresaReporteModel>.from(
        json.decode(str).map((x) => EmpresaReporteModel.fromJson(x)));

EmpresaReporteModel empresaReporteModelFromJson(String str) =>
    EmpresaReporteModel.fromJson(json.decode(str));

String empresaReporteModelToJson(EmpresaReporteModel data) => json.encode(data.toJson());

class EmpresaReporteModel {
  int id;
  String nombreEmpresa;
  String deduccionTotal;

  EmpresaReporteModel({
    required this.id,
    required this.nombreEmpresa,
    required this.deduccionTotal
  });

  factory EmpresaReporteModel.fromJson(Map<String, dynamic> json) => EmpresaReporteModel(
        id: json["id"],
        nombreEmpresa: json["nombre_empresa"],
        deduccionTotal: json["deduccion_total"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_empresa": nombreEmpresa,
        "deduccionTotal": deduccionTotal
      };
}
