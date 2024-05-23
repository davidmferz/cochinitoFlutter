import 'dart:convert';

import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CondicionesCreditoService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  Future<Object> getCondicionesCredito({required int idEmpresa}) async {
    try {
      final url = Uri.parse("${Urls.condicionesCredito}/$idEmpresa");
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
      });

      if (response.body.isNotEmpty) {
        final data = json.decode(response.body)['response'];
        
        return data;
      } else {
        
        return [];
      }
    } catch (e) {

      return [];
    }
  }
}
