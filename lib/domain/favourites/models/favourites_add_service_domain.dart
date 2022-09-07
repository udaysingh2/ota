// To parse this JSON data, do
//
//     final favouriteAddServiceDomain = favouriteAddServiceDomainFromMap(jsonString);

import 'dart:convert';

class FavouriteAddServiceDomain {
  FavouriteAddServiceDomain({
    this.markFavorite,
  });

  final MarkFavorite? markFavorite;

  factory FavouriteAddServiceDomain.fromJson(String str) =>
      FavouriteAddServiceDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavouriteAddServiceDomain.fromMap(Map<String, dynamic> json) =>
      FavouriteAddServiceDomain(
        markFavorite: json["markFavorite"] == null
            ? null
            : MarkFavorite.fromMap(json["markFavorite"]),
      );

  Map<String, dynamic> toMap() => {
        "markFavorite": markFavorite == null ? null : markFavorite!.toMap(),
      };
}

class MarkFavorite {
  MarkFavorite({
    this.status,
  });

  final Status? status;

  factory MarkFavorite.fromJson(String str) =>
      MarkFavorite.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MarkFavorite.fromMap(Map<String, dynamic> json) => MarkFavorite(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status!.toMap(),
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
