// To parse this JSON data, do
//
//     final landingCustomerRegisterArgumentModelChannel = landingCustomerRegisterArgumentModelChannelFromMap(jsonString);

import 'dart:convert';

class LogCrashlyticsArgumentModelChannel {
  LogCrashlyticsArgumentModelChannel({
    this.message,
    this.className,
    this.stackTrace,
  });

  final String? message;
  final String? className;
  final String? stackTrace;

  factory LogCrashlyticsArgumentModelChannel.fromJson(String str) =>
      LogCrashlyticsArgumentModelChannel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LogCrashlyticsArgumentModelChannel.fromMap(
          Map<String, dynamic> json) =>
      LogCrashlyticsArgumentModelChannel(
        message: json["message"],
        className: json["className"],
        stackTrace: json["stackTrace"],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "className": className,
        "stackTrace": stackTrace,
      };
}
