import 'dart:convert';

import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:cochinito_flutter/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
class RolService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  Future<List<RolModel>> getRoles() async {
    try {
      final url = Uri.parse(Urls.roles);
      //final token = await storage.read(key: 'token');
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        /* 'Authorization': 'Bearer $token' */
      });
 
      if (response.body.isNotEmpty) {
        final data = json.decode(response.body)['response'];
        //final List<TipoNominaModel>body = List<TipoNominaModel>.from(data.map((model)=>  TipoNominaModel.fromJson(model)));
        final List<RolModel>body = listRolModelFromJson(json.encode(data));
        return body;
      }else{
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}