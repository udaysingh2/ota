// To parse this JSON data, do
//
//     final otaLandingHandlerModelChannel = otaLandingHandlerModelChannelFromMap(jsonString);

import 'dart:convert';

import 'package:ota/core_pack/graphql/auth_model.dart';

class PropertyDetailHandlerModelChannel extends AuthModel {
  PropertyDetailHandlerModelChannel({
    this.userId,
    this.userType,
    this.hotelId,
    this.cityId,
    this.countryId,
    this.language,
    this.env,
    idToken,
    accessToken,
  }) : super(
          accessToken: accessToken,
          idToken: idToken,
        );

  final String? userId;
  final String? userType;
  final String? hotelId;
  final String? cityId;
  final String? countryId;
  final String? language;
  final String? env;

  factory PropertyDetailHandlerModelChannel.fromJson(String str) =>
      PropertyDetailHandlerModelChannel.fromMap(json.decode(str));

  @override
  String toJson() => json.encode(toMap());

  factory PropertyDetailHandlerModelChannel.fromMap(
          Map<String, dynamic> json) =>
      PropertyDetailHandlerModelChannel(
        userId: json["userId"],
        userType: json["userType"],
        hotelId: json["hotelId"],
        cityId: json["cityId"],
        countryId: json["countryId"],
        language: json["language"],
        env: json["env"],
        idToken: json["idToken"],
        accessToken: json["accessToken"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "userId": userId,
        "userType": userType,
        "hotelId": hotelId,
        "cityId": cityId,
        "countryId": countryId,
        "language": language,
        "env": env,
        "idToken": idToken,
        "accessToken": accessToken,
      };
}
