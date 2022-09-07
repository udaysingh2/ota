import 'dart:convert';

class PreferencePopUpModelDomain {
  PreferencePopUpModelDomain({
    this.status,
  });

  final Status? status;

  factory PreferencePopUpModelDomain.fromJson(String str) =>
      PreferencePopUpModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PreferencePopUpModelDomain.fromMap(Map<String, dynamic> json) =>
      PreferencePopUpModelDomain(
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

  final int? code;
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
