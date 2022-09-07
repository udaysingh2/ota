// To parse this JSON data, do
//
//     final otaFilterSort = otaFilterSortFromMap(jsonString);

import 'dart:convert';

class OtaFilterSort {
  OtaFilterSort({
    this.status,
    this.data,
  });

  final Status? status;
  final Data? data;

  factory OtaFilterSort.fromJson(String str) =>
      OtaFilterSort.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtaFilterSort.fromMap(Map<String, dynamic> json) => OtaFilterSort(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status?.toMap(),
        "data": data?.toMap(),
      };
}

class Data {
  Data({
    this.sortInfo,
    this.criteria,
  });

  final List<Criterion>? sortInfo;
  final List<Criterion>? criteria;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        sortInfo: json["sortInfo"] == null
            ? null
            : List<Criterion>.from(
                json["sortInfo"].map((x) => Criterion.fromMap(x))),
        criteria: json["criteria"] == null
            ? null
            : List<Criterion>.from(
                json["criteria"].map((x) => Criterion.fromMap(x))),
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

class Criterion {
  Criterion({
    this.displayTitle,
    this.sortSeq,
    this.value,
  });

  final String? displayTitle;
  final int? sortSeq;
  final String? value;

  factory Criterion.fromJson(String str) => Criterion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Criterion.fromMap(Map<String, dynamic> json) => Criterion(
        displayTitle: json["displayTitle"],
        sortSeq: json["sortSeq"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "displayTitle": displayTitle,
        "sortSeq": sortSeq,
        "value": value,
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
