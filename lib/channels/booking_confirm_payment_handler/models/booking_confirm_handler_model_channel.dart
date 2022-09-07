import 'dart:convert';

import 'package:ota/core_pack/graphql/auth_model.dart';

class BookingConfirmHandlerModelChannel extends AuthModel {
  BookingConfirmHandlerModelChannel({
    this.orderId,
    this.language,
    this.env,
    idToken,
    accessToken,
  }) : super(
          accessToken: accessToken,
          idToken: idToken,
        );

  final String? orderId;
  final String? language;
  final String? env;

  factory BookingConfirmHandlerModelChannel.fromJson(String str) =>
      BookingConfirmHandlerModelChannel.fromMap(json.decode(str));

  @override
  String toJson() => json.encode(toMap());

  factory BookingConfirmHandlerModelChannel.fromMap(
          Map<String, dynamic> json) =>
      BookingConfirmHandlerModelChannel(
        orderId: json["orderId"],
        language: json["language"],
        env: json["env"],
        idToken: json["idToken"],
        accessToken: json["accessToken"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "orderId": orderId,
        "language": language,
        "env": env,
        "idToken": idToken,
        "accessToken": accessToken,
      };
}
