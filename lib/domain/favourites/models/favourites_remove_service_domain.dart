// To parse this JSON data, do
//
//     final favouriteRemoveServiceDomain = favouriteRemoveServiceDomainFromMap(jsonString);

import 'dart:convert';

class FavouriteRemoveServiceDomain {
  FavouriteRemoveServiceDomain({
    this.removeFavorite,
  });

  final RemoveFavorite? removeFavorite;

  factory FavouriteRemoveServiceDomain.fromJson(String str) =>
      FavouriteRemoveServiceDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavouriteRemoveServiceDomain.fromMap(Map<String, dynamic> json) =>
      FavouriteRemoveServiceDomain(
        removeFavorite: json["removeFavorite"] == null
            ? null
            : RemoveFavorite.fromMap(json["removeFavorite"]),
      );

  Map<String, dynamic> toMap() => {
        "removeFavorite":
            removeFavorite == null ? null : removeFavorite!.toMap(),
      };
}

class RemoveFavorite {
  RemoveFavorite({
    this.status,
  });

  final Status? status;

  factory RemoveFavorite.fromJson(String str) =>
      RemoveFavorite.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RemoveFavorite.fromMap(Map<String, dynamic> json) => RemoveFavorite(
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
