// To parse this JSON data, do
//
//     final splash = splashFromMap(jsonString);

import 'dart:convert';

class Splash {
  Splash({
    this.data,
  });

  final SplashModel? data;

  factory Splash.fromJson(String str) => Splash.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Splash.fromMap(Map<String, dynamic> json) => Splash(
        data: json["data"] == null ? null : SplashModel.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
      };
}

class SplashModel {
  SplashModel({
    this.getSplashScreen,
  });

  final GetSplashScreen? getSplashScreen;

  factory SplashModel.fromJson(String str) =>
      SplashModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SplashModel.fromMap(Map<String, dynamic> json) => SplashModel(
        getSplashScreen: json["getSplashScreen"] == null
            ? null
            : GetSplashScreen.fromMap(json["getSplashScreen"]),
      );

  Map<String, dynamic> toMap() => {
        "getSplashScreen":
            getSplashScreen == null ? null : getSplashScreen!.toMap(),
      };
}

class GetSplashScreen {
  GetSplashScreen({
    this.status,
    this.data,
  });

  final Status? status;
  final GetSplashScreenData? data;

  factory GetSplashScreen.fromJson(String str) =>
      GetSplashScreen.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetSplashScreen.fromMap(Map<String, dynamic> json) => GetSplashScreen(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
        data: json["data"] == null
            ? null
            : GetSplashScreenData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status!.toMap(),
        "data": data == null ? null : data!.toMap(),
      };
}

class GetSplashScreenData {
  GetSplashScreenData({
    this.splashScreenUrl,
  });

  final String? splashScreenUrl;

  factory GetSplashScreenData.fromJson(String str) =>
      GetSplashScreenData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetSplashScreenData.fromMap(Map<String, dynamic> json) =>
      GetSplashScreenData(
        splashScreenUrl: json["splashScreenUrl"],
      );

  Map<String, dynamic> toMap() => {
        "splashScreenUrl": splashScreenUrl,
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
        code: json["code"],
        header: json["header"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "header": header,
      };
}
