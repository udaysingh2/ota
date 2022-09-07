// To parse this JSON data, do
//
//     final exampleResponseModelChannel = exampleResponseModelChannelFromMap(jsonString);

import 'dart:convert';

class ExampleResponseModelChannel {
  ExampleResponseModelChannel({
    this.from,
    this.to,
    this.userId,
    this.userType,
    this.language,
    this.envId,
  });

  final String? from;
  final String? to;
  final String? userId;
  final String? userType;
  final String? language;
  final String? envId;

  factory ExampleResponseModelChannel.fromJson(String str) =>
      ExampleResponseModelChannel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExampleResponseModelChannel.fromMap(Map<String, dynamic> json) =>
      ExampleResponseModelChannel(
        from: json["from"],
        to: json["to"],
        userId: json["userId"],
        userType: json["userType"],
        language: json["language"],
        envId: json["envId"],
      );

  Map<String, dynamic> toMap() => {
        "from": from,
        "to": to,
        "userId": userId,
        "userType": userType,
        "language": language,
        "envId": envId,
      };
}
