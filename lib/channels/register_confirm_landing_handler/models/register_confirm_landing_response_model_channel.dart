// To parse this JSON data, do
//
//     final registerConfirmLandingModelChannel = registerConfirmLandingModelChannelFromMap(jsonString);

import 'dart:convert';

import 'package:ota/core_pack/graphql/auth_model.dart';

class RegisterConfirmLandingModelChannel extends AuthModel {
  RegisterConfirmLandingModelChannel({
    this.userId,
    this.userType,
    this.language,
    this.env,
    this.userName,
    this.existingCust,
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
  final String? existingCust;
  factory RegisterConfirmLandingModelChannel.fromJson(String str) =>
      RegisterConfirmLandingModelChannel.fromMap(json.decode(str));

  @override
  String toJson() => json.encode(toMap());

  factory RegisterConfirmLandingModelChannel.fromMap(
          Map<String, dynamic> json) =>
      RegisterConfirmLandingModelChannel(
        userId: json["userId"],
        userType: json["userType"],
        language: json["language"],
        env: json["env"],
        idToken: json["idToken"],
        accessToken: json["accessToken"],
        userName: json["userName"],
        existingCust: json["existingCust"],
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
        "existingCust": existingCust,
      };
}
