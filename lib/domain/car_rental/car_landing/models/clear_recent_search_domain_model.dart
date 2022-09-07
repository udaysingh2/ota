import 'dart:convert';

class ClearRecentSearchDomainModel {
  ClearRecentSearchDomainModel({
    this.status,
  });

  final Status? status;
  factory ClearRecentSearchDomainModel.fromJson(String str) =>
      ClearRecentSearchDomainModel.fromMap(json.decode(str));

  factory ClearRecentSearchDomainModel.fromMap(Map<String, dynamic> json) =>
      ClearRecentSearchDomainModel(
        status: Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status!.toMap(),
      };
}

class Status {
  Status({
    this.code,
    this.header,
  });

  final String? code;
  final String? header;

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        header: json["header"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "header": header,
      };
}
