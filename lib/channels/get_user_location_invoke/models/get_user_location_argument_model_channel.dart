// To parse this JSON data, do
//
//     final exampleArgumentModelChannel = exampleArgumentModelChannelFromMap(jsonString);

import 'dart:convert';

import 'package:ota/core_pack/graphql/auth_model.dart';

class GetUserLocationArgumentModelChannel extends AuthModel {
  GetUserLocationArgumentModelChannel({
    this.userId,
    this.env,
    this.userType,
    this.language,
    this.latitude,
    this.longitude,
    idToken,
    accessToken,
  }) : super(
          accessToken: accessToken,
          idToken: idToken,
        );

  final String? userId;
  final String? env;
  final String? userType;
  final String? language;
  final String? latitude;
  final String? longitude;
  factory GetUserLocationArgumentModelChannel.fromJson(String str) =>
      GetUserLocationArgumentModelChannel.fromMap(json.decode(str));

  @override
  String toJson() => json.encode(toMap());

  factory GetUserLocationArgumentModelChannel.fromMap(
          Map<String, dynamic> json) =>
      GetUserLocationArgumentModelChannel(
        userId: json["userId"],
        env: json["env"],
        userType: json["userType"],
        language: json["language"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        idToken: json["idToken"],
        accessToken: json["accessToken"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "userId": userId,
        "env": env,
        "userType": userType,
        "language": language,
        "latitude": latitude,
        "longitude": longitude,
        "idToken": idToken,
        "accessToken": accessToken,
      };
}
