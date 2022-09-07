// To parse this JSON data, do
//
//     final otaLandingHandlerModelChannel = otaLandingHandlerModelChannelFromMap(jsonString);

import 'dart:convert';

import 'package:ota/core_pack/graphql/auth_model.dart';

class OtaPropertyHandlerModelChannel extends AuthModel {
  OtaPropertyHandlerModelChannel({
    this.userId,
    this.userType,
    this.serviceName,
    this.productId,
    this.cityId,
    this.countryId,
    this.pickupLocation,
    this.returnLocation,
    this.pickupCounter,
    this.reuturnCounter,
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
  final String? serviceName;
  final String? productId;
  final String? cityId;
  final String? countryId;
  final String? pickupLocation;
  final String? returnLocation;
  final String? pickupCounter;
  final String? reuturnCounter;

  /// spelling mistake
  final String? language;
  final String? env;

  factory OtaPropertyHandlerModelChannel.fromJson(String str) =>
      OtaPropertyHandlerModelChannel.fromMap(json.decode(str));

  @override
  String toJson() => json.encode(toMap());

  factory OtaPropertyHandlerModelChannel.fromMap(Map<String, dynamic> json) =>
      OtaPropertyHandlerModelChannel(
        userId: json["userId"],
        userType: json["userType"],
        serviceName: json["serviceName"],
        productId: json["productId"],
        cityId: json["cityId"],
        countryId: json["countryId"],
        pickupLocation: json["pickupLocation"],
        returnLocation: json["returnLocation"],
        pickupCounter: json["pickupCounter"],
        reuturnCounter: json["reuturnCounter"],
        language: json["language"],
        env: json["env"],
        idToken: json["idToken"],
        accessToken: json["accessToken"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "userId": userId,
        "userType": userType,
        "serviceName": serviceName,
        "productId": productId,
        "cityId": cityId,
        "countryId": countryId,
        "pickupLocation": pickupLocation,
        "returnLocation": returnLocation,
        "pickupCounter": pickupCounter,
        "reuturnCounter": reuturnCounter,
        "language": language,
        "env": env,
        "idToken": idToken,
        "accessToken": accessToken,
      };
}
