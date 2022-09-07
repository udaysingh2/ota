import 'dart:convert';

class AddFavoriteModelDomain {
  AddFavoriteModelDomain({
    this.addFavorite,
  });

  final AddFavorite? addFavorite;

  factory AddFavoriteModelDomain.fromJson(String str) =>
      AddFavoriteModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddFavoriteModelDomain.fromMap(Map<String, dynamic> json) =>
      AddFavoriteModelDomain(
        addFavorite: json["addFavorite"] == null
            ? null
            : AddFavorite.fromMap(json["addFavorite"]),
      );

  Map<String, dynamic> toMap() => {
        "addFavorite": addFavorite?.toMap(),
      };
}

class AddFavorite {
  AddFavorite({
    this.status,
  });

  final Status? status;

  factory AddFavorite.fromJson(String str) =>
      AddFavorite.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

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
