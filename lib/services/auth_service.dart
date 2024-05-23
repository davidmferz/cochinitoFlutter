import 'dart:convert';
import 'dart:io';

import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:cochinito_flutter/models/models.dart';
/* import 'package:cochinito_flutter/models/roles_model.dart'; */
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  final preferences = Preferences();
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    try {
      final url = Uri.parse(Urls.login);
      final res = await http.post(url, body: jsonEncode(authData), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });
      final decodeResp = json.decode(res.body);

      if (res.statusCode == 200) {
        if (decodeResp is Map<String, dynamic> &&
            decodeResp.containsKey('response')) {
          final dynamic responseData = decodeResp['response'];
          if (responseData is Map<String, dynamic>) {
            final ResponseLoginModel response =
                responseLoginModelFromJson(json.encode(responseData));

            final token = response.token;
            await storage.write(key: 'token', value: token);

            if (response.user.id != null) {
              Preferences.idUser = response.user.id.toString();
            } else {
              return 'El id del usuario es null';
            }

            if (response.user.rolId != null) {
              Preferences.idRol = response.user.rolId.toString();
            } else {
              return 'El rolId del usuario es null';
            }

            Preferences.nameRol = response.user.rol.tipoRol;
            Preferences.nameEmpresa =
                response.user.empresa?.nombreEmpresa ?? '';
            Preferences.nombreUser =
                "${response.user.nombre} ${response.user.apellidoPaterno} ${response.user.apellidoMaterno}";
            if (response.user.rolId == 2) {
              if (response.user.empresaId != null) {
                Preferences.idEmpresa = response.user.empresaId.toString();
              } else {
                return 'El empresaId del usuario es null';
              }
            }
            return null;
          } else if (responseData is String) {
            return responseData;
          } else {
            return 'La respuesta del servidor no tiene el formato esperado.';
          }
        } else {
          return 'La respuesta del servidor no tiene el formato esperado.';
        }
      } else {
        return decodeResp['response'];
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<dynamic> registro(
      String userid,
      String nombre,
      String apellidoPaterno,
      String apellidoMaterno,
      String telefonoPrincipal,
      String telefonoSecundario,
      String nomina, //nomina $
      String nominaId, //tipo de nomina
      String rolId,
      String empresaId,
      String rfc,
      String email,
      String contrato) async {
    final Map<String, dynamic> authData = {
      'userid': userid,
      'nombre': nombre,
      'apellido_paterno': apellidoPaterno,
      'apellido_materno': apellidoMaterno,
      'telefono_principal': telefonoPrincipal,
      'telefono_secundario': telefonoSecundario,
      'nomina': nomina,
      'nomina_id': nominaId,
      'rol_id': rolId,
      'empresa_id': empresaId,
      'rfc': rfc,
      'email': email,
      'contratoFirmado': contrato
    };
    debugPrint("userid: $userid");
    try {
      //final token = await storage.read(key: 'token');
      final url = Uri.parse(Urls.user);
      final res = await http.post(url, body: authData, headers: {
        'Accept': 'application/json',
        /* 'Authorization': 'Bearer $token' */
      });

      final decodeResp = await json.decode(res.body);
      if (res.statusCode == 200) {
        //final ResponseUserModel response = decodeResp['response'];
        /* final token = response.token;
          await storage.write(key: 'token', value: token); */
        /* Preferences.idUser = response.user.id.toString(); */
        try {
          String combinedMessage = "";
          decodeResp.forEach((key, messages) {
            for (var message in messages) {
              combinedMessage = "$combinedMessage$message\n";
            }
            // Use your Flushbar here to show combinedMessage variable
          });
          debugPrint(decodeResp.toString());
          return decodeResp.toString();
        } catch (e) {
          if (decodeResp['status'] == 'error') {
            debugPrint(decodeResp['response']);
            return decodeResp['response'];
          } else {
            return null;
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
      return 'Ha ocurrido un error';
    }
  }

  Future<dynamic> registroEmpresas(
      String nombre, String idEmpresaConsultar) async {
    final Map<String, dynamic> authData = {
      'nombre_empresa': nombre,
      'id_empresa': idEmpresaConsultar,
    };
    try {
      final url = Uri.parse(Urls.empresa);
      final res = await http.post(url, body: authData, headers: {
        'Accept': 'application/json',
      });
      final decodeResp = await json.decode(res.body);
      if (res.statusCode == 200) {
        try {
          return null;
        } catch (e) {
          //print(e);
          return e;
        }
      }
    } catch (e) {
      //print(e);
      return 'error';
    }
  }

  Future<dynamic> registroNotificacion(
      String nombre, String dispositivo) async {
    final Map<String, dynamic> authData = {
      'onesignal': nombre,
      'dispositivo': dispositivo,
      'userId': Preferences.idUser
    };
    try {
      final url = Uri.parse(Urls.registroIdNotificacion);
      final res = await http.post(url, body: authData, headers: {
        'Accept': 'application/json',
      });
      final decodeResp = await json.decode(res.body);
      if (res.statusCode == 200) {
        try {
          String combinedMessage = "";
          decodeResp.forEach((key, messages) {
            for (var message in messages) {
              combinedMessage = "$combinedMessage$message\n";
            }
          });
          return combinedMessage;
        } catch (e) {
          return null;
        }
      }
    } catch (e) {
      return 'error';
    }
  }

  Future<dynamic> registroCondiciones(
      int idEmpresa, int porcentaje, int plazo, int interes) async {
    final Map<String, dynamic> authData = {
      'id_empresa': idEmpresa,
      'porcentaje': porcentaje,
      'plazo': plazo,
      'interes': interes
    };
    //print(authData);
    try {
      final url = Uri.parse(Urls.condicionesCredito);
      final res = await http.post(url, body: jsonEncode(authData), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });
      final decodeResp = await json.decode(res.body);
      if (res.statusCode == 200) {
        try {
          String combinedMessage = "";
          decodeResp.forEach((key, messages) {
            for (var message in messages) {
              combinedMessage = "$combinedMessage$message\n";
            }
          });
          return combinedMessage;
        } catch (e) {
          return null;
        }
      }
    } catch (e) {
      //print(e);
      return 'error API: $e';
    }
  }

  Future registerToken() async {
    final Map<String, dynamic> data = {
      'token': '0', //Preferences.firebaseToken,
      'userId': Preferences.idUser,
      'dispositivo': getPlatform(),
      'onesignal': OneSignal.User.pushSubscription.id.toString()
    };
    try {
      //final token = await storage.read(key: 'token');
      final url = Uri.parse(Urls.registerToken);
      final res = await http.post(url, body: data, headers: {
        'Accept': 'application/json',
        /* 'Authorization': 'Bearer $token' */
      });
      return res.statusCode;
    } catch (e) {
      return e;
    }
  }

  limpiarListas() {
    notifyListeners();
  }

  Future logout() async {
    // return await storage.deleteAll();
    await storage.delete(key: 'token');
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //Falta borrar el token_app para evitar recibir notificaciones de firebase
    preferences.clear();
    //Preferences.toSt();
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  String getPlatform() {
    if (Platform.isIOS) {
      return 'iOS';
    } else if (Platform.isAndroid) {
      return 'Android';
    } else {
      return 'Otro';
    }
  }
}
