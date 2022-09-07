// To parse this JSON data, do
//
//     final thaiTranslationDataModel = thaiTranslationDataModelFromMap(jsonString);

import 'dart:convert';

class ThaiTranslationDataModel {
  ThaiTranslationDataModel({
    this.data,
  });

  final ThaiTranslationDataModelData? data;

  factory ThaiTranslationDataModel.fromJson(String str) =>
      ThaiTranslationDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ThaiTranslationDataModel.fromMap(Map<String, dynamic> json) =>
      ThaiTranslationDataModel(
        data: json["data"] == null
            ? null
            : ThaiTranslationDataModelData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class ThaiTranslationDataModelData {
  ThaiTranslationDataModelData({
    this.loadTranslation,
  });

  final LoadTranslation? loadTranslation;

  factory ThaiTranslationDataModelData.fromJson(String str) =>
      ThaiTranslationDataModelData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ThaiTranslationDataModelData.fromMap(Map<String, dynamic> json) =>
      ThaiTranslationDataModelData(
        loadTranslation: json["loadTranslation"] == null
            ? null
            : LoadTranslation.fromMap(json["loadTranslation"]),
      );

  Map<String, dynamic> toMap() => {
        "loadTranslation": loadTranslation?.toMap(),
      };
}

class LoadTranslation {
  LoadTranslation({
    this.data,
  });

  final LoadTranslationData? data;

  factory LoadTranslation.fromJson(String str) =>
      LoadTranslation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoadTranslation.fromMap(Map<String, dynamic> json) => LoadTranslation(
        data: json["data"] == null
            ? null
            : LoadTranslationData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class LoadTranslationData {
  LoadTranslationData({
    this.th,
  });

  final List<Th>? th;

  factory LoadTranslationData.fromJson(String str) =>
      LoadTranslationData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoadTranslationData.fromMap(Map<String, dynamic> json) =>
      LoadTranslationData(
        th: json["th"] == null
            ? null
            : List<Th>.from(json["th"].map((x) => Th.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "th": th == null ? null : List<dynamic>.from(th!.map((x) => x.toMap())),
      };
}

class Th {
  Th({
    this.name,
    this.value,
  });

  final String? name;
  final String? value;

  factory Th.fromJson(String str) => Th.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Th.fromMap(Map<String, dynamic> json) => Th(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "value": value,
      };
}
