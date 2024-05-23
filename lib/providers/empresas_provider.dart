import 'package:cochinito_flutter/models/users_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cochinito_flutter/helpers/urls.dart';

class EmpresasProvider with ChangeNotifier {
  List<UsersResponse> users = [];

  Future<void> getUsers() async {
    final result = await http.get(Uri.parse(Urls.empresa));
    final response = usersResponseFromJson(result.body);
    print(response.response);
  }
}
