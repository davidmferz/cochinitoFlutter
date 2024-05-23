import 'dart:convert';

import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:cochinito_flutter/models/models.dart';
import 'package:cochinito_flutter/models/periodos_pago_model.dart';
import 'package:cochinito_flutter/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class PeriodosPagoService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  final preferences = Preferences();

  Future<List<PeriodosPagoModel>> getPeriodosPago() async {
    try {
      final url = Uri.parse('${Urls.periodosPago}/${Preferences.idUser}');
      //final token = await storage.read(key: 'token');
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        /* 'Authorization': 'Bearer $token' */
      });

      if (response.body.isNotEmpty) {
        final data = json.decode(response.body)['response'];
        final List<PeriodosPagoModel> body =
            listPeriodosPagoModelFromJson(json.encode(data));
        return body;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<String?> actualizarPeriodoPago(
      int id, PeriodosPagoProvider periodo) async {
    final Map<String, dynamic> diasData = {
      'nomina_id': periodo.getNominaId.toString(),
      'dia_semanal': periodo.getDiaSemanal.toString(),
      'dia_catorcena': periodo.getDiaCatorcena.toString(),
      'tipo_catorcena': periodo.getTipoCatorcena.toString(),
      'primer_dia_quincena': periodo.getPrimerDiaQuincena.toString(),
      'segundo_dia_quincena': periodo.getSegundoDiaQuincena.toString(),
      'dia_mensual': periodo.getDiaMensual.toString(),
    };

    try {
      final url = Uri.parse('${Urls.periodosPago}/$id');
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

  Future<String?> agregarPeriodoPago(PeriodosPagoProvider periodo) async {
    final Map<String, dynamic> diasData = {
      'nomina_id': periodo.getNominaId.toString(),
      'empresa_id': Preferences.idEmpresa,
      'dia_semanal': periodo.getDiaSemanal.toString(),
      'dia_catorcena': periodo.getDiaCatorcena.toString(),
      'tipo_catorcena': periodo.getTipoCatorcena.toString(),
      'primer_dia_quincena': periodo.getPrimerDiaQuincena.toString(),
      'segundo_dia_quincena': periodo.getSegundoDiaQuincena.toString(),
      'dia_mensual': periodo.getDiaMensual.toString(),
    };

    try {
      final url = Uri.parse(Urls.periodosPago);
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
            return decodeResp['response'];
          } else {
            return null;
          }
        }
      }
    } catch (e) {
      return 'Ha ocurrido un error';
    }
  }

  Future<String?> eliminarPeriodoPago(int id) async {
    try {
      //final token = await storage.read(key: 'token');
      final url = Uri.parse('${Urls.periodosPago}/$id');

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
