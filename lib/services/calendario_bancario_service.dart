import 'dart:convert';

import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:cochinito_flutter/models/dias_festivos_model.dart';
import 'package:cochinito_flutter/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CalendarioBancarioService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  Future<List<DiasLaboralesModel>> getDiasLaborales() async {
    try {
      final url = Uri.parse(Urls.diasLaborales);
      //final token = await storage.read(key: 'token');
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        /* 'Authorization': 'Bearer $token' */
      });

      if (response.body.isNotEmpty) {
        final data = json.decode(response.body)['response'];
        final List<DiasLaboralesModel> body =
            listDiasLaboralesModelFromJson(json.encode(data));
        return body;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<String?> actualizarDiasLaborales(List<DiasLaboralesModel> data) async {
    final Map<String, dynamic> diasData = {
      'dias_data': jsonEncode(data),
    };

    try {
      final url = Uri.parse('${Urls.diasLaborales}/1');
      //final token = await storage.read(key: 'token');
      final response = await http.put(url, body: diasData, headers: {
        'Accept': 'application/json',
        /* 'Authorization': 'Bearer $token' */
      });

      final decodeResp = await json.decode(response.body);
      if (response.statusCode == 200) {
        try {
          String combinedMessage = "";
          decodeResp.forEach((key, messages) {
            for (var message in messages) {
              combinedMessage = "$combinedMessage$message\n";
            }
          });
          return combinedMessage;
        } catch (e) {
          if (decodeResp['status'] == 'error') {
            return 'Ha ocurrido un error';
          } else {
            return null;
          }
        }
      }
    } catch (e) {
      return 'Ha ocurrido un error';
    }
  }

  Future<List<DiasFestivosModel>> getDiasFestivos() async {
    try {
      final url = Uri.parse(Urls.diasFestivos);
      //final token = await storage.read(key: 'token');
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        /* 'Authorization': 'Bearer $token' */
      });

      if (response.body.isNotEmpty) {
        final data = json.decode(response.body)['response'];
        final List<DiasFestivosModel> body =
            listDiasFestivosModelFromJson(json.encode(data));
        return body;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<String?> actualizarDiaFestivo(int id, String fecha) async {
    final Map<String, dynamic> diasData = {
      'fecha': fecha,
    };

    try {
      final url = Uri.parse('${Urls.diasFestivos}/${id}');
      //final token = await storage.read(key: 'token');
      final response = await http.put(url, body: diasData, headers: {
        'Accept': 'application/json',
        /* 'Authorization': 'Bearer $token' */
      });

      final decodeResp = await json.decode(response.body);
      if (response.statusCode == 200) {
        try {
          String combinedMessage = "";
          decodeResp.forEach((key, messages) {
            for (var message in messages) {
              combinedMessage = "$combinedMessage$message\n";
            }
          });
          return combinedMessage;
        } catch (e) {
          if (decodeResp['status'] == 'error') {
            return 'Ha ocurrido un error';
          } else {
            return null;
          }
        }
      }
    } catch (e) {
      return 'Ha ocurrido un error';
    }
  }

  Future<String?> agregarDiaFestivo(String fecha) async {
    final Map<String, dynamic> diasData = {
      'fecha': fecha,
    };

    try {
      final url = Uri.parse(Urls.diasFestivos);
      //final token = await storage.read(key: 'token');
      final response = await http.post(url, body: diasData, headers: {
        'Accept': 'application/json',
        /* 'Authorization': 'Bearer $token' */
      });

      final decodeResp = await json.decode(response.body);
      if (response.statusCode == 200) {
        try {
          String combinedMessage = "";
          decodeResp.forEach((key, messages) {
            for (var message in messages) {
              combinedMessage = "$combinedMessage$message\n";
            }
          });
          return combinedMessage;
        } catch (e) {
          if (decodeResp['status'] == 'error') {
            return 'Ha ocurrido un error';
          } else {
            return null;
          }
        }
      }
    } catch (e) {
      return 'Ha ocurrido un error';
    }
  }

  Future<String?> eliminarDiaFestivo(int id) async {
    try {
      //final token = await storage.read(key: 'token');
      final url = Uri.parse('${Urls.diasFestivos}/$id');

      final http.Response response = await http.delete(
        url,
        headers: <String, String>{
          "Accept": "application/json",
          /* 'Authorization': 'Bearer $token' */
        },
      );

      final decodeResp = await json.decode(response.body);

      if (decodeResp['status'] == 'error') {
        return 'Ha ocurrido un error';
      } else {
        return null;
      }
    } catch (e) {
      return 'Ha ocurrido un error';
    }
  }
}
