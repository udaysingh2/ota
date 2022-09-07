import 'dart:convert';

class DeleteFavoriteModelDomain {
  DeleteFavoriteModelDomain({
    this.deleteFavorite,
  });

  final DeleteFavorite? deleteFavorite;

  factory DeleteFavoriteModelDomain.fromJson(String str) =>
      DeleteFavoriteModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteFavoriteModelDomain.fromMap(Map<String, dynamic> json) =>
      DeleteFavoriteModelDomain(
        deleteFavorite: json["deleteFavorite"] == null
            ? null
            : DeleteFavorite.fromMap(json["deleteFavorite"]),
      );

  Map<String, dynamic> toMap() => {
        "deleteFavorite":
            deleteFavorite == null ? null : deleteFavorite!.toMap(),
      };
}

class DeleteFavorite {
  DeleteFavorite({
    this.status,
  });

  final Status? status;

  factory DeleteFavorite.fromJson(String str) =>
      DeleteFavorite.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteFavorite.fromMap(Map<String, dynamic> json) => DeleteFavorite(
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
  final String? description;

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
