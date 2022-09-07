// To parse this JSON data, do
//
//     final tourSaveSearchHistoryModelDomain = tourSaveSearchHistoryModelDomainFromMap(jsonString);

import 'dart:convert';

class TourSaveSearchHistoryModelDomain {
  TourSaveSearchHistoryModelDomain({
    this.saveRecentTourAndTicketSearchHistory,
  });

  final SaveRecentTourAndTicketSearchHistory?
      saveRecentTourAndTicketSearchHistory;

  factory TourSaveSearchHistoryModelDomain.fromJson(String str) =>
      TourSaveSearchHistoryModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TourSaveSearchHistoryModelDomain.fromMap(Map<String, dynamic> json) =>
      TourSaveSearchHistoryModelDomain(
        saveRecentTourAndTicketSearchHistory:
            json["saveRecentTourAndTicketSearchHistory"] == null
                ? null
                : SaveRecentTourAndTicketSearchHistory.fromMap(
                    json["saveRecentTourAndTicketSearchHistory"]),
      );

  Map<String, dynamic> toMap() => {
        "saveRecentTourAndTicketSearchHistory":
            saveRecentTourAndTicketSearchHistory == null
                ? null
                : saveRecentTourAndTicketSearchHistory!.toMap(),
      };
}

class SaveRecentTourAndTicketSearchHistory {
  SaveRecentTourAndTicketSearchHistory({
    this.status,
  });

  final Status? status;

  factory SaveRecentTourAndTicketSearchHistory.fromJson(String str) =>
      SaveRecentTourAndTicketSearchHistory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SaveRecentTourAndTicketSearchHistory.fromMap(
          Map<String, dynamic> json) =>
      SaveRecentTourAndTicketSearchHistory(
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
