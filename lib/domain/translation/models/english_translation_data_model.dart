// To parse this JSON data, do
//
//     final englishTranslationDataModel = englishTranslationDataModelFromMap(jsonString);

import 'dart:convert';

class EnglishTranslationDataModel {
  EnglishTranslationDataModel({
    this.data,
  });

  final EnglishTranslationDataModelData? data;

  factory EnglishTranslationDataModel.fromJson(String str) =>
      EnglishTranslationDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EnglishTranslationDataModel.fromMap(Map<String, dynamic> json) =>
      EnglishTranslationDataModel(
        data: json["data"] == null
            ? null
            : EnglishTranslationDataModelData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class EnglishTranslationDataModelData {
  EnglishTranslationDataModelData({
    this.loadTranslation,
  });

  final LoadTranslation? loadTranslation;

  factory EnglishTranslationDataModelData.fromJson(String str) =>
      EnglishTranslationDataModelData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EnglishTranslationDataModelData.fromMap(Map<String, dynamic> json) =>
      EnglishTranslationDataModelData(
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
    this.en,
  });

  final List<En>? en;

  factory LoadTranslationData.fromJson(String str) =>
      LoadTranslationData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoadTranslationData.fromMap(Map<String, dynamic> json) =>
      LoadTranslationData(
        en: json["en"] == null
            ? null
            : List<En>.from(json["en"].map((x) => En.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "en": en == null ? null : List<dynamic>.from(en!.map((x) => x.toMap())),
      };
}

class En {
  En({
    this.name,
    this.value,
  });

  final String? name;
  final String? value;

  factory En.fromJson(String str) => En.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory En.fromMap(Map<String, dynamic> json) => En(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "value": value,
      };
}
