import 'dart:convert';

import 'package:cochinito_flutter/models/response_user_model.dart';

ResponseLoginModel responseLoginModelFromJson(String str) => ResponseLoginModel.fromJson(json.decode(str));

String responseLoginModelToJson(ResponseLoginModel data) => json.encode(data.toJson());

class ResponseLoginModel {
    String token;
    ResponseUserModel user;

    ResponseLoginModel({
        required this.token,
        required this.user,
    });

    factory ResponseLoginModel.fromJson(Map<String, dynamic> json) => ResponseLoginModel(
        token: json["token"],
        user: ResponseUserModel.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
    };
}