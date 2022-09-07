// To parse this JSON data, do
//
//     final checkFavouriteDomainModel = checkFavouriteDomainModelFromMap(jsonString);

import 'dart:convert';

CheckFavouriteDomainModel checkFavouriteDomainModelFromMap(String str) =>
    CheckFavouriteDomainModel.fromMap(json.decode(str));

String checkFavouriteDomainModelToMap(CheckFavouriteDomainModel data) =>
    json.encode(data.toMap());

class CheckFavouriteDomainModel {
  CheckFavouriteDomainModel({
    this.checkCarFavorites,
  });

  final CheckCarFavorites? checkCarFavorites;

  factory CheckFavouriteDomainModel.fromMap(Map<String, dynamic> json) =>
      CheckFavouriteDomainModel(
        checkCarFavorites: json["checkCarFavorites"] == null
            ? null
            : CheckCarFavorites.fromMap(json["checkCarFavorites"]),
      );

  Map<String, dynamic> toMap() => {
        "checkCarFavorites": checkCarFavorites?.toMap(),
      };
  factory CheckFavouriteDomainModel.fromJson(String str) =>
      CheckFavouriteDomainModel.fromMap(json.decode(str));
}

class CheckCarFavorites {
  CheckCarFavorites({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory CheckCarFavorites.fromMap(Map<String, dynamic> json) =>
      CheckCarFavorites(
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
  });

  final String? code;
  final String? header;

  factory Status.fromMap(Map<String, dynamic> json) =>
      Status(code: json["code"], header: json["header"]);

  Map<String, dynamic> toMap() => {
        "code": code,
        "header": header,
      };
}
