import 'dart:convert';

import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:cochinito_flutter/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class EmpresaService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  Future<List<EmpresaModel>> getEmpresas() async {
    try {
      final url = Uri.parse(Urls.empresa);
      //final token = await storage.read(key: 'token');
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        /* 'Authorization': 'Bearer $token' */
      });

      if (response.body.isNotEmpty) {
        final data = json.decode(response.body)['response'];
        final List<EmpresaModel> body =
            listEmpresaModelFromJson(json.encode(data));
        debugPrint(body.toString());
        return body;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<EmpresaModel?> getEmpresa({int? idEmpresa}) async {
    try {
       final url = Uri.parse("${Urls.empresa}/${idEmpresa ?? ''}");
      //final token = await storage.read(key: 'token');
      debugPrint(url.toString());
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        /* 'Authorization': 'Bearer $token' */
      });

      if (response.body.isNotEmpty) {
        final data = json.decode(response.body);
        return EmpresaModel.fromJson(data['response']);

      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
