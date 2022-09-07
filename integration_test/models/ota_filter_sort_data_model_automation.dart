// To parse this JSON data, do
//
//     final otaFilterSort = otaFilterSortFromMap(jsonString);

import 'dart:convert';

class OtaFilterSortAutomation {
  OtaFilterSortAutomation({
    this.status,
    this.data,
  });

  final StatusAutomation? status;
  final DataAutomation? data;

  factory OtaFilterSortAutomation.fromJson(String str) =>
      OtaFilterSortAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtaFilterSortAutomation.fromMap(Map<String, dynamic> json) =>
      OtaFilterSortAutomation(
        status: json["status"] == null
            ? null
            : StatusAutomation.fromMap(json["status"]),
        data:
            json["data"] == null ? null : DataAutomation.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status?.toMap(),
        "data": data == null ? null : data?.toMap(),
      };
}

class DataAutomation {
  DataAutomation({
    this.sortInfo,
    this.criteria,
  });

  final List<CriterionAutomation>? sortInfo;
  final List<CriterionAutomation>? criteria;

  factory DataAutomation.fromJson(String str) =>
      DataAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataAutomation.fromMap(Map<String, dynamic> json) => DataAutomation(
        sortInfo: json["sortInfo"] == null
            ? null
            : List<CriterionAutomation>.from(
                json["sortInfo"].map((x) => CriterionAutomation.fromMap(x))),
        criteria: json["criteria"] == null
            ? null
            : List<CriterionAutomation>.from(
                json["criteria"].map((x) => CriterionAutomation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "sortInfo": sortInfo == null
            ? null
            : List<dynamic>.from(sortInfo!.map((x) => x.toMap())),
        "criteria": criteria == null
            ? null
            : List<dynamic>.from(criteria!.map((x) => x.toMap())),
      };
}

class CriterionAutomation {
  CriterionAutomation({
    this.displayTitle,
    this.sortSeq,
    this.value,
  });

  final String? displayTitle;
  final int? sortSeq;
  final String? value;

  factory CriterionAutomation.fromJson(String str) =>
      CriterionAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CriterionAutomation.fromMap(Map<String, dynamic> json) =>
      CriterionAutomation(
        displayTitle:
            json["displayTitle"] == null ? null : json["displayTitle"],
        sortSeq: json["sortSeq"] == null ? null : json["sortSeq"],
        value: json["value"] == null ? null : json["value"],
      );

  Map<String, dynamic> toMap() => {
        "displayTitle": displayTitle == null ? null : displayTitle,
        "sortSeq": sortSeq == null ? null : sortSeq,
        "value": value == null ? null : value,
      };
}

class StatusAutomation {
  StatusAutomation({
    this.code,
    this.header,
    this.description,
  });

  final String? code;
  final String? header;
  final String? description;

  factory StatusAutomation.fromJson(String str) =>
      StatusAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatusAutomation.fromMap(Map<String, dynamic> json) =>
      StatusAutomation(
        code: json["code"] == null ? null : json["code"],
        header: json["header"] == null ? null : json["header"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "header": header == null ? null : header,
        "description": description == null ? null : description,
      };
}
