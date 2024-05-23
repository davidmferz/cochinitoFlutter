import 'dart:convert';

import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:cochinito_flutter/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CreditosNominaService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  Future<List<CreditosNominaModel>> getCreditosNomina() async {
    //Obtiene el historial de creditos,(a los admin no les muestra cobrados y rechazados)
    try {
      final url = Uri.parse('${Urls.creditosNomina}/${Preferences.idUser}');
      //final token = await storage.read(key: 'token');
      /* final Map<String, dynamic> data = {
        'user_id':  Preferences.idUser,
      }; */
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        /* 'Authorization': 'Bearer $token' */
      });

      if (response.body.isNotEmpty) {
        final data = json.decode(response.body)['response'];
        final List<CreditosNominaModel> body =
            listCreditosNominaModelFromJson(json.encode(data));
        /* Preferences.porcentajeMaximo = json.decode(response.body)['porcentajeMaximo'].toString();
        Preferences.plazoMaximo = json.decode(response.body)['plazoMaximo'].toString();
        Preferences.nominaTotal = json.decode(response.body)['totalNomina'].toString(); */
        return body;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<CreditosNominaModel>> getSolicitudCreditosNomina() async {
    //Funcion especifica para empleados, para calcular es estado de sus solicitudes activas y pendientes
    try {
      final url =
          Uri.parse('${Urls.getSolicitudCreditosNomina}/${Preferences.idUser}');
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        /* 'Authorization': 'Bearer $token' */
      });
      if (response.body.isNotEmpty) {
        final data = json.decode(response.body)['response'];
        final List<CreditosNominaModel> body =
            listCreditosNominaModelFromJson(json.encode(data));
        Preferences.porcentajeMaximo =
            json.decode(response.body)['porcentajeMaximo'].toString();
        Preferences.plazoMaximo =
            json.decode(response.body)['plazoMaximo'].toString();
        Preferences.nominaTotal =
            json.decode(response.body)['totalNomina'].toString();
        Preferences.ultimaFecha =
            json.decode(response.body)['ultimaFecha'].toString();
        return body;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<StatusModel>> getStatusCreditosNomina() async {
    try {
      final url =
          Uri.parse('${Urls.statusCreditosNomina}/${Preferences.idUser}');
      //final token = await storage.read(key: 'token');
      /* final Map<String, dynamic> data = {
        'user_id':  Preferences.idUser,
      }; */
      final response = await http.get(url, headers: {
        'Accept': 'application/json',
        /* 'Authorization': 'Bearer $token' */
      });

      if (response.body.isNotEmpty) {
        final data = json.decode(response.body)['response'];
        final List<StatusModel> body =
            listStatusModelFromJson(json.encode(data));
        return body;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<String?> modificarEstadoCredito(
      String nominaId, String statusId) async {
    final Map<String, dynamic> data = {
      'admin_empresa_id': Preferences.idUser,
      'nomina_id': nominaId,
      'status_id': statusId,
    };

    try {
      final url = Uri.parse(Urls.modificarEstadoCredito);
      //final token = await storage.read(key: 'token');
      final response = await http.post(url, body: data, headers: {
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

  Future<String?> agregarCreditoNomina(String anticipo) async {
    final Map<String, dynamic> data = {
      'anticipo': anticipo,
      'usuario_id': Preferences.idUser
    };

    try {
      final url = Uri.parse(Urls.verificarCredito);
      //final token = await storage.read(key: 'token');
      final response = await http.post(url, body: data, headers: {
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

  Future<String?> eliminarCreditoNomina(int id) async {
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

  Future<List<CreditosNominaModel>> getCreditoList() async {
    try {
      final List<CreditosNominaModel> creditosList = await getCreditosNomina();
      return creditosList;
    } catch (e) {
      return [];
    }
  }

  Future<List<ReporteCreditosUsuariosModel>> getReporteCreditosUsuarios(
      String empresaId) async {
    try {
      final url = Uri.parse(Urls.getReporteCreditosUsuarios);
      //final token = await storage.read(key: 'token');
      final Map<String, dynamic> data = {
        'empresa_id': empresaId,
      };
      final response = await http.post(url, body: data, headers: {
        'Accept': 'application/json',
        /* 'Authorization': 'Bearer $token' */
      });

      if (response.body.isNotEmpty) {
        final data = json.decode(response.body)['response'];
        final List<ReporteCreditosUsuariosModel> body =
            listReporteCreditosUsuariosModelFromJson(json.encode(data));
        return body;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<String?> eliminarCredito(String nominaId) async {
    final Map<String, dynamic> data = {
      'admin_empresa_id': Preferences.idUser,
      'nomina_id': nominaId,
    };

    try {
      final url = Uri.parse(Urls.eliminarCredito);
      final response = await http.delete(
        url,
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final decodeResp = json.decode(response.body);
        // Verifica si la eliminación fue exitosa
        debugPrint(response.body);
        if (decodeResp['status'] == 'success') {
          return null; // Éxito, devuelve null
        } else {
          return 'Ha ocurrido un error al eliminar el crédito'; // Error
        }
      } else {
        return 'Error en la solicitud al servidor'; // Error de solicitud HTTP
      }
    } catch (e) {
      print(e);
      return 'Ha ocurrido un error'; // Error genérico
    }
  }
}
