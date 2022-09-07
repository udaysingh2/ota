// To parse this JSON data, do
//
//     final splash = splashFromMap(jsonString);

import 'dart:convert';

class SplashAutomation {
  SplashAutomation({
    this.data,
  });

  final SplashModelAutomation? data;

  factory SplashAutomation.fromJson(String str) =>
      SplashAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SplashAutomation.fromMap(Map<String, dynamic> json) =>
      SplashAutomation(
        data: json["data"] == null
            ? null
            : SplashModelAutomation.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
      };
}

class SplashModelAutomation {
  SplashModelAutomation({
    this.getSplashScreen,
  });

  final GetSplashScreenAutomation? getSplashScreen;

  factory SplashModelAutomation.fromJson(String str) =>
      SplashModelAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SplashModelAutomation.fromMap(Map<String, dynamic> json) =>
      SplashModelAutomation(
        getSplashScreen: json["getSplashScreen"] == null
            ? null
            : GetSplashScreenAutomation.fromMap(json["getSplashScreen"]),
      );

  Map<String, dynamic> toMap() => {
        "getSplashScreen":
            getSplashScreen == null ? null : getSplashScreen!.toMap(),
      };
}

class GetSplashScreenAutomation {
  GetSplashScreenAutomation({
    this.status,
    this.data,
  });

  final Status? status;
  final GetSplashScreenDataAutomation? data;

  factory GetSplashScreenAutomation.fromJson(String str) =>
      GetSplashScreenAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetSplashScreenAutomation.fromMap(Map<String, dynamic> json) =>
      GetSplashScreenAutomation(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
        data: json["data"] == null
            ? null
            : GetSplashScreenDataAutomation.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status!.toMap(),
        "data": data == null ? null : data!.toMap(),
      };
}

class GetSplashScreenDataAutomation {
  GetSplashScreenDataAutomation({
    this.splashScreenUrl,
  });

  final String? splashScreenUrl;

  factory GetSplashScreenDataAutomation.fromJson(String str) =>
      GetSplashScreenDataAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetSplashScreenDataAutomation.fromMap(Map<String, dynamic> json) =>
      GetSplashScreenDataAutomation(
        splashScreenUrl:
            json["splashScreenUrl"] == null ? null : json["splashScreenUrl"],
      );

  Map<String, dynamic> toMap() => {
        "splashScreenUrl": splashScreenUrl == null ? null : splashScreenUrl,
      };
}

class Status {
  Status({
    this.code,
    this.header,
  });

  final String? code;
  final String? header;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"] == null ? null : json["code"],
        header: json["header"] == null ? null : json["header"],
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "header": header == null ? null : header,
      };
}
