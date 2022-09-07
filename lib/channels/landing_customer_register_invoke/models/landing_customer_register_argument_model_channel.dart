// To parse this JSON data, do
//
//     final landingCustomerRegisterArgumentModelChannel = landingCustomerRegisterArgumentModelChannelFromMap(jsonString);

import 'dart:convert';

class LandingCustomerRegisterArgumentModelChannel {
  LandingCustomerRegisterArgumentModelChannel({
    this.userId,
    this.userType,
    this.language,
    this.env,
  });

  final String? userId;
  final String? userType;
  final String? language;
  final String? env;

  factory LandingCustomerRegisterArgumentModelChannel.fromJson(String str) =>
      LandingCustomerRegisterArgumentModelChannel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LandingCustomerRegisterArgumentModelChannel.fromMap(
          Map<String, dynamic> json) =>
      LandingCustomerRegisterArgumentModelChannel(
        userId: json["userId"],
        userType: json["userType"],
        language: json["language"],
        env: json["env"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "userType": userType,
        "language": language,
        "env": env,
      };
}
