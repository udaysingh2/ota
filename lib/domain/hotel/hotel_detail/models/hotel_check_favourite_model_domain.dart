// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

class IsFavoritesDomain {
  IsFavoritesDomain({
    this.checkFavorites,
  });

  final CheckFavorites? checkFavorites;

  factory IsFavoritesDomain.fromJson(String str) =>
      IsFavoritesDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IsFavoritesDomain.fromMap(Map<String, dynamic> json) =>
      IsFavoritesDomain(
        checkFavorites: json["checkFavorites"] == null
            ? null
            : CheckFavorites.fromMap(json["checkFavorites"]),
      );

  Map<String, dynamic> toMap() => {
        "checkFavorites": checkFavorites?.toMap(),
      };
}

class CheckFavorites {
  CheckFavorites({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory CheckFavorites.fromJson(String str) =>
      CheckFavorites.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CheckFavorites.fromMap(Map<String, dynamic> json) => CheckFavorites(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class Data {
  Data({
    this.isFavorite,
  });

  final bool? isFavorite;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        isFavorite: json["isFavorite"],
      );

  Map<String, dynamic> toMap() => {
        "isFavorite": isFavorite,
      };
}

class Status {
  Status({
    this.code,
    this.header,
    this.description,
  });

  final String? code;
  final String? header;
  final dynamic description;

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        header: json["header"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "header": header,
        "description": description,
      };
}
