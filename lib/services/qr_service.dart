import 'dart:convert';

import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:cochinito_flutter/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class QrService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  Future<dynamic> obtenerDatosRFC(String rfc) async {
    final Map<String, dynamic> rfcData = {
      'rfc': rfc,
    };
    //final token = await storage.read(key: 'token');
    final url = Uri.parse(Urls.getRFC);
    final res = await http.post(url, body: rfcData, headers: {
      'Accept': 'application/json',
      /* 'Authorization': 'Bearer $token' */
    }).timeout(const Duration(seconds: 15));

    if (res.statusCode == 200) {
      final decodeResp = await json.decode(res.body);
      final ResponseQrModel data = ResponseQrModel.fromJson(decodeResp['response']);
      //debugPrint(response.body);
      return data;
    } else {
      return null;
    }
  }

  Future<dynamic> obtenerDatosRFC2(String rfc) async {
    final Map<String, dynamic> rfcData = {
      'rfc': rfc,
    };
    http.read(Uri.parse('https://siat.sat.gob.mx/app/qr/faces/pages/mobile/validadorqr.jsf?D1=10&D2=1&D3=$rfc')).then((contents) {
      print(contents);
    }); 
    //final token = await storage.read(key: 'token');
    final url = Uri.parse(Urls.getRFC);
    final res = await http.post(url, body: rfcData, headers: {
      'Accept': 'application/json',
      /* 'Authorization': 'Bearer $token' */
    }).timeout(const Duration(seconds: 15));

    if (res.statusCode == 200) {
      final decodeResp = await json.decode(res.body);
      final ResponseQrModel data = ResponseQrModel.fromJson(decodeResp['response']);
      //debugPrint(response.body);
      return data;
    } else {
      return null;
    }
  }
}
