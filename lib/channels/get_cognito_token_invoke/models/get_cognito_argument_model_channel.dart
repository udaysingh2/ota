// To parse this JSON data, do
//
//     final exampleArgumentModelChannel = exampleArgumentModelChannelFromMap(jsonString);

import 'dart:convert';

import 'package:ota/core_pack/graphql/auth_model.dart';

class GetCognitoArgumentModelChannel extends AuthModel {
  GetCognitoArgumentModelChannel({
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

  factory GetCognitoArgumentModelChannel.fromJson(String str) =>
      GetCognitoArgumentModelChannel.fromMap(json.decode(str));

  @override
  String toJson() => json.encode(toMap());

  factory GetCognitoArgumentModelChannel.fromMap(Map<String, dynamic> json) =>
      GetCognitoArgumentModelChannel(
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
