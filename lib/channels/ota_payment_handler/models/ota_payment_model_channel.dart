// To parse this JSON data, do
//
//     final registerConfirmBookingModelChannel = registerConfirmBookingModelChannelFromMap(jsonString);

import 'dart:convert';

import 'package:ota/core_pack/graphql/auth_model.dart';

class OtaPaymentModelChannel extends AuthModel {
  OtaPaymentModelChannel({
    this.userId,
    this.serviceType,
    this.language,
    this.env,
    this.cardType,
    this.cardMark,
    this.cardNickName,
    this.cardRef,
    this.paymentMethodId,
    idToken,
    accessToken,
  }) : super(
          accessToken: accessToken,
          idToken: idToken,
        );

  final String? userId;
  final String? serviceType;
  final String? language;
  final String? env;
  final String? cardType;
  final String? cardMark;
  final String? cardNickName;
  final String? cardRef;
  final String? paymentMethodId;
  factory OtaPaymentModelChannel.fromJson(String str) =>
      OtaPaymentModelChannel.fromMap(json.decode(str));

  @override
  String toJson() => json.encode(toMap());

  factory OtaPaymentModelChannel.fromMap(Map<String, dynamic> json) =>
      OtaPaymentModelChannel(
        userId: json["userId"],
        serviceType: json["serviceType"],
        language: json["language"],
        env: json["env"],
        idToken: json["idToken"],
        accessToken: json["accessToken"],
        cardType: json["cardType"],
        cardMark: json["cardMark"],
        cardNickName: json["cardNickname"],
        cardRef: json["cardRef"],
        paymentMethodId: json["paymentMethodId"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "userId": userId,
        "serviceType": serviceType,
        "language": language,
        "env": env,
        "idToken": idToken,
        "accessToken": accessToken,
        "cardType": cardType,
        "cardMark": cardMark,
        "cardNickname": cardNickName,
        "cardRef": cardRef,
        "paymentMethodId": paymentMethodId,
      };
}
