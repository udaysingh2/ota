import 'dart:convert';

import 'package:ota/core_pack/graphql/auth_model.dart';

class OtaBookingDetailHandlerModelChannel extends AuthModel {
  OtaBookingDetailHandlerModelChannel({
    this.userId,
    this.userType,
    this.orderId,
    this.confirmationNo,
    this.bookingType,
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
  final String? orderId;
  final String? confirmationNo;
  final String? bookingType;
  final String? language;
  final String? env;

  factory OtaBookingDetailHandlerModelChannel.fromJson(String str) =>
      OtaBookingDetailHandlerModelChannel.fromMap(json.decode(str));

  @override
  String toJson() => json.encode(toMap());

  factory OtaBookingDetailHandlerModelChannel.fromMap(
          Map<String, dynamic> json) =>
      OtaBookingDetailHandlerModelChannel(
        userId: json["userId"],
        userType: json["userType"],
        idToken: json["idToken"],
        accessToken: json["accessToken"],
        orderId: json["orderId"],
        confirmationNo: json["confirmationNo"],
        bookingType: json["bookingType"],
        language: json["language"],
        env: json["env"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "userId": userId,
        "userType": userType,
        "idToken": idToken,
        "accessToken": accessToken,
        "orderId": orderId,
        "confirmationNo": confirmationNo,
        "bookingType": bookingType,
        "language": language,
        "env": env,
      };
}
