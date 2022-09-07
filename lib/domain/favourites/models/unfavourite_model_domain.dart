// To parse this JSON data, do
//
//     final unFavouriteModelDomain = unFavouriteModelDomainFromMap(jsonString);

import 'dart:convert';

UnFavouriteModelDomain unFavouriteModelDomainFromMap(String str) =>
    UnFavouriteModelDomain.fromMap(json.decode(str));

String unFavouriteModelDomainToMap(UnFavouriteModelDomain data) =>
    json.encode(data.toMap());

class UnFavouriteModelDomain {
  UnFavouriteModelDomain({
    this.status,
  });

  final Status? status;

  factory UnFavouriteModelDomain.fromMap(Map<String, dynamic> json) =>
      UnFavouriteModelDomain(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status?.toMap(),
      };
  factory UnFavouriteModelDomain.fromJson(String str) =>
      UnFavouriteModelDomain.fromMap(json.decode(str));
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
