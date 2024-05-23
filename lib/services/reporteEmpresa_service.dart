import 'dart:convert';

import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:cochinito_flutter/models/empresaReporte_model.dart';
import 'package:cochinito_flutter/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class EmpresaReporteService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  Future<List<EmpresaReporteModel>> getReporteEmpresas() async {
    try {
      final url = Uri.parse(Urls.reporteEmpresa);
      //final token = await storage.read(key: 'token');
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        /* 'Authorization': 'Bearer $token' */
      });

      if (response.body.isNotEmpty) {
        final data = json.decode(response.body)['response'];
        
        final totalGeneral = json.decode(response.body)['total_general'];
        Preferences.totalGeneral = totalGeneral.toString();
        final List<EmpresaReporteModel> body = listEmpresaReporteModelFromJson(json.encode(data));
        print(totalGeneral);
        return body;
      } else {
        return [];
      }
    } catch (e) {
      print("error reporteEmpresas: $e");
      return [];
    }
  }
}
