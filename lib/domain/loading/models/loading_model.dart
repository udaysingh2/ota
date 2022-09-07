import 'dart:convert';

class LoadingModel {
  LoadingModel({
    this.data,
  });

  final LoadingModelData? data;

  factory LoadingModel.fromJson(String str) =>
      LoadingModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoadingModel.fromMap(Map<String, dynamic> json) => LoadingModel(
        data: json["data"] == null
            ? null
            : LoadingModelData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
      };
}

class LoadingModelData {
  LoadingModelData({
    this.getLoadScreen,
  });

  final GetLoadScreen? getLoadScreen;

  factory LoadingModelData.fromJson(String str) =>
      LoadingModelData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoadingModelData.fromMap(Map<String, dynamic> json) =>
      LoadingModelData(
        getLoadScreen: json["getLoadScreen"] == null
            ? null
            : GetLoadScreen.fromMap(json["getLoadScreen"]),
      );

  Map<String, dynamic> toMap() => {
        "getLoadScreen": getLoadScreen == null ? null : getLoadScreen!.toMap(),
      };
}

class GetLoadScreen {
  GetLoadScreen({
    this.data,
    this.status,
  });

  final GetLoadScreenData? data;
  final Status? status;

  factory GetLoadScreen.fromJson(String str) =>
      GetLoadScreen.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetLoadScreen.fromMap(Map<String, dynamic> json) => GetLoadScreen(
        data: json["data"] == null
            ? null
            : GetLoadScreenData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
        "status": status == null ? null : status!.toMap(),
      };
}

class GetLoadScreenData {
  GetLoadScreenData({
    this.loadScreenUrl,
  });

  final String? loadScreenUrl;

  factory GetLoadScreenData.fromJson(String str) =>
      GetLoadScreenData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetLoadScreenData.fromMap(Map<String, dynamic> json) =>
      GetLoadScreenData(
        loadScreenUrl: json["loadScreenUrl"],
      );

  Map<String, dynamic> toMap() => {
        "loadScreenUrl": loadScreenUrl,
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
