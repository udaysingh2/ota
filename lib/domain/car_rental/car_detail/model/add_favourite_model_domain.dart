// To parse this JSON data, do
//
//     final addfavouriteModelDomain = addfavouriteModelDomainFromMap(jsonString);

import 'dart:convert';

AddfavouriteModelDomain addfavouriteModelDomainFromMap(String str) =>
    AddfavouriteModelDomain.fromMap(json.decode(str));

String addfavouriteModelDomainToMap(AddfavouriteModelDomain data) =>
    json.encode(data.toMap());

class AddfavouriteModelDomain {
  AddfavouriteModelDomain({
    this.addFavorite,
  });

  final AddFavorite? addFavorite;

  factory AddfavouriteModelDomain.fromMap(Map<String, dynamic> json) =>
      AddfavouriteModelDomain(
        addFavorite: json["addFavorite"] == null
            ? null
            : AddFavorite.fromMap(json["addFavorite"]),
      );

  Map<String, dynamic> toMap() => {
        "addFavorite": addFavorite?.toMap(),
      };
  factory AddfavouriteModelDomain.fromJson(String str) =>
      AddfavouriteModelDomain.fromMap(json.decode(str));
}

class AddFavorite {
  AddFavorite({
    this.status,
  });

  final Status? status;

  factory AddFavorite.fromMap(Map<String, dynamic> json) => AddFavorite(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status?.toMap(),
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
  final String? description;

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
