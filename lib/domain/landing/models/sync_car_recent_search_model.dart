import 'dart:convert';

SyncCarRecentSearchDomainModel syncCarRecentSearchDomainModelFromMap(
        String str) =>
    SyncCarRecentSearchDomainModel.fromMap(json.decode(str));

String syncCarRecentSearchDomainModelToMap(
        SyncCarRecentSearchDomainModel data) =>
    json.encode(data.toMap());

class SyncCarRecentSearchDomainModel {
  SyncCarRecentSearchDomainModel({
    this.saveRecentCarrentalSearch,
  });

  final SaveRecentCarrentalSearch? saveRecentCarrentalSearch;

  factory SyncCarRecentSearchDomainModel.fromMap(Map<String, dynamic> json) =>
      SyncCarRecentSearchDomainModel(
        saveRecentCarrentalSearch: SaveRecentCarrentalSearch.fromMap(
            json),
      );

  Map<String, dynamic> toMap() => {
        "saveRecentCarrentalSearch": saveRecentCarrentalSearch?.toMap(),
      };
  factory SyncCarRecentSearchDomainModel.fromJson(String str) =>
      SyncCarRecentSearchDomainModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
}

class SaveRecentCarrentalSearch {
  SaveRecentCarrentalSearch({
    this.status,
  });

  final Status? status;

  factory SaveRecentCarrentalSearch.fromMap(Map<String, dynamic> json) =>
      SaveRecentCarrentalSearch(
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
