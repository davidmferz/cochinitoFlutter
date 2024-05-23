import 'dart:convert';

import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:cochinito_flutter/models/dias_festivos_model.dart';
import 'package:cochinito_flutter/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ConfiguracionesGeneralesService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  Future<String?> actualizarMailSettings(
      mailDriver,
      mailHost,
      mailPort,
      mailUserName,
      mailPassword,
      mailEncryption,
      mailFromAddress,
      mailFromName) async {
    final Map<String, dynamic> mailSettings = {
      'mail_driver': mailDriver,
      'mail_host': mailHost,
      'mail_port': mailPort,
      'mail_username': mailUserName,
      'mail_password': mailPassword,
      'mail_encryption': mailEncryption,
      'mail_from_address': mailFromAddress,
      'mail_from_name': mailFromName,
    };

    try {
      final url = Uri.parse(Urls.mailSettings);
      //final token = await storage.read(key: 'token');
      final response = await http.post(url, body: mailSettings, headers: {
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

  Future<String?> enviarCorreoPrueba( mailTest) async { 
    final Map<String, dynamic> destinatario = {
      'email_test' : mailTest
    };
    try {
      final url = Uri.parse(Urls.enviarCorreoPrueba);
      //final token = await storage.read(key: 'token');
      final response = await http.post(url, body: destinatario, headers: {
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
}
