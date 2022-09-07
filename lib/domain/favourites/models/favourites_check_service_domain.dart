// To parse this JSON data, do
//
//     final favouriteCheckServiceDomain = favouriteCheckServiceDomainFromMap(jsonString);

import 'dart:convert';

class FavouriteCheckServiceDomain {
  FavouriteCheckServiceDomain({
    this.isFavorite,
  });

  final IsFavorite? isFavorite;

  factory FavouriteCheckServiceDomain.fromJson(String str) =>
      FavouriteCheckServiceDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavouriteCheckServiceDomain.fromMap(Map<String, dynamic> json) =>
      FavouriteCheckServiceDomain(
        isFavorite: json["isFavorite"] == null
            ? null
            : IsFavorite.fromMap(json["isFavorite"]),
      );

  Map<String, dynamic> toMap() => {
        "isFavorite": isFavorite == null ? null : isFavorite!.toMap(),
      };
}

class IsFavorite {
  IsFavorite({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory IsFavorite.fromJson(String str) =>
      IsFavorite.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IsFavorite.fromMap(Map<String, dynamic> json) => IsFavorite(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
        "status": status == null ? null : status!.toMap(),
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

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

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
