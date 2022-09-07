// To parse this JSON data, do
//
//     final exampleResponseModelChannel = exampleResponseModelChannelFromMap(jsonString);

import 'dart:convert';

import 'package:ota/core_pack/graphql/auth_model.dart';

class GetCognitoResponseModelChannel extends AuthModel {
  GetCognitoResponseModelChannel({
    this.userId,
    this.env,
    idToken,
    accessToken,
  }) : super(
          accessToken: accessToken,
          idToken: idToken,
        );

  final String? userId;
  final String? env;

  factory GetCognitoResponseModelChannel.fromJson(String str) =>
      GetCognitoResponseModelChannel.fromMap(json.decode(str));

  @override
  String toJson() => json.encode(toMap());

  factory GetCognitoResponseModelChannel.fromMap(Map<String, dynamic> json) =>
      GetCognitoResponseModelChannel(
        userId: json["userId"],
        env: json["env"],
        idToken: json["idToken"],
        accessToken: json["accessToken"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "userId": userId,
        "env": env,
        "idToken": idToken,
        "accessToken": accessToken,
      };
}
