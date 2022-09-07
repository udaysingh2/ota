// To parse this JSON data, do
//
//     final landingCustomerRegisterArgumentModelChannel = landingCustomerRegisterArgumentModelChannelFromMap(jsonString);

import 'dart:convert';

class BookingCustomerRegisterArgumentModelChannel {
  BookingCustomerRegisterArgumentModelChannel({
    this.userId,
    this.userType,
    this.language,
    this.env,
  });

  final String? userId;
  final String? userType;
  final String? language;
  final String? env;

  factory BookingCustomerRegisterArgumentModelChannel.fromJson(String str) =>
      BookingCustomerRegisterArgumentModelChannel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BookingCustomerRegisterArgumentModelChannel.fromMap(
          Map<String, dynamic> json) =>
      BookingCustomerRegisterArgumentModelChannel(
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
