import 'dart:convert';

import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:cochinito_flutter/models/models.dart';
import 'package:cochinito_flutter/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersService with ChangeNotifier {
  List<Users> users = [];

  Future<void> getUsers({int? idUsuario}) async {
    try {
      final url = Uri.parse("${Urls.user}/${idUsuario ?? ''}");
      print("${Urls.user}/${idUsuario ?? ''}");
      final result = await http.get(url, headers: {
        'Accept': 'application/json',
      });

      if (result.body.isNotEmpty) {
        final Map<String, dynamic> data = json.decode(result.body);
         users.clear();
        if (data['response'] != null) {
          if (data['response'] is List) {
            
            for (var userJson in data['response']) {
              users.add(Users.fromJson(userJson));
            }
          } else {
            // Si es un objeto individual
            users = [Users.fromJson(data['response'])];
          }

          notifyListeners();
        } else {
          debugPrint("La propiedad 'response' es nula en la respuesta JSON.");
        }
      } else {
        debugPrint("Sin datos");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

Future<ResponseUserModel?> getUser() async {
    try {
      final url = Uri.parse('${Urls.user}/${Preferences.idUser}');
      final result = await http.get(url, headers: {
        'Accept': 'application/json',
      });
      //final data = json.decode(result.body)['response'] as ResponseUserModel;
      final data = responseUserModelFromJson(
          json.encode(json.decode(result.body)['response']));
      Preferences.nominaTotal = data.nomina;
      return data;
    } catch (e) {
      return null;
    }
  }
}
