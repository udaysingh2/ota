import 'dart:convert';

class CarSaveSearchHistoryModelDomain {
  CarSaveSearchHistoryModelDomain({
    this.saveRecentCarRentalSearchHistory,
  });

  final SaveRecentCarRentalSearchHistory? saveRecentCarRentalSearchHistory;

  factory CarSaveSearchHistoryModelDomain.fromJson(String str) =>
      CarSaveSearchHistoryModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarSaveSearchHistoryModelDomain.fromMap(Map<String, dynamic> json) =>
      CarSaveSearchHistoryModelDomain(
        saveRecentCarRentalSearchHistory:
            json["saveRecentCarRentalSearchHistory"] == null
                ? null
                : SaveRecentCarRentalSearchHistory.fromMap(
                    json["saveRecentCarRentalSearchHistory"]),
      );

  Map<String, dynamic> toMap() => {
        "saveRecentCarRentalSearchHistory":
            saveRecentCarRentalSearchHistory == null
                ? null
                : saveRecentCarRentalSearchHistory!.toMap(),
      };
}

class SaveRecentCarRentalSearchHistory {
  SaveRecentCarRentalSearchHistory({
    this.status,
  });

  final Status? status;

  factory SaveRecentCarRentalSearchHistory.fromJson(String str) =>
      SaveRecentCarRentalSearchHistory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SaveRecentCarRentalSearchHistory.fromMap(Map<String, dynamic> json) =>
      SaveRecentCarRentalSearchHistory(
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
