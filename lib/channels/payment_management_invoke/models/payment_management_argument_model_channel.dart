// To parse this JSON data, do
//
//     final landingCustomerRegisterArgumentModelChannel = landingCustomerRegisterArgumentModelChannelFromMap(jsonString);

import 'dart:convert';

class PaymentManagementArgumentModelChannel {
  PaymentManagementArgumentModelChannel({
    this.userId,
    this.serviceType,
    this.language,
    this.env,
  });

  final String? userId;
  final String? serviceType;
  final String? language;
  final String? env;

  factory PaymentManagementArgumentModelChannel.fromJson(String str) =>
      PaymentManagementArgumentModelChannel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentManagementArgumentModelChannel.fromMap(
          Map<String, dynamic> json) =>
      PaymentManagementArgumentModelChannel(
        userId: json["userId"],
        serviceType: json["serviceType"],
        language: json["language"],
        env: json["env"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "serviceType": serviceType,
        "language": language,
        "env": env,
      };
}
