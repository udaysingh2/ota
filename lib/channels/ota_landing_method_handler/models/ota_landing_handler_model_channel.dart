// To parse this JSON data, do
//
//     final otaLandingHandlerModelChannel = otaLandingHandlerModelChannelFromMap(jsonString);

import 'dart:convert';

import 'package:ota/core_pack/graphql/auth_model.dart';

class OtaLandingHandlerModelChannel extends AuthModel {
  OtaLandingHandlerModelChannel({
    this.userId,
    this.userType,
    this.language,
    this.env,
    this.userName,
    idToken,
    accessToken,
  }) : super(
          accessToken: accessToken,
          idToken: idToken,
        );

  final String? userId;
  final String? userType;
  final String? language;
  final String? env;
  final String? userName;

  factory OtaLandingHandlerModelChannel.fromJson(String str) =>
      OtaLandingHandlerModelChannel.fromMap(json.decode(str));

  @override
  String toJson() => json.encode(toMap());

  factory OtaLandingHandlerModelChannel.fromMap(Map<String, dynamic> json) =>
      OtaLandingHandlerModelChannel(
        userId: json["userId"],
        userType: json["userType"],
        language: json["language"],
        env: json["env"],
        idToken: json["idToken"],
        accessToken: json["accessToken"],
        userName: json["userName"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "userId": userId,
        "userType": userType,
        "language": language,
        "env": env,
        "idToken": idToken,
        "accessToken": accessToken,
        "userName": userName,
      };
}
