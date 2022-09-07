import 'dart:convert';

class TourSearchFilterModelDomain {
  TourSearchFilterModelDomain({
    this.getSortCriteria,
  });

  final GetSortCriteria? getSortCriteria;

  factory TourSearchFilterModelDomain.fromJson(String str) =>
      TourSearchFilterModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TourSearchFilterModelDomain.fromMap(Map<String, dynamic> json) =>
      TourSearchFilterModelDomain(
        getSortCriteria: json["getSortCriteriaForService"] == null
            ? null
            : GetSortCriteria.fromMap(json["getSortCriteriaForService"]),
      );

  Map<String, dynamic> toMap() => {
        "getSortCriteriaForService": getSortCriteria?.toMap(),
      };
}

class GetSortCriteria {
  GetSortCriteria({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetSortCriteria.fromJson(String str) =>
      GetSortCriteria.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetSortCriteria.fromMap(Map<String, dynamic> json) => GetSortCriteria(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
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
    this.description,
  });

  final String? displayTitle;
  final int? sortSeq;
  final String? value;
  final String? description;

  factory Criterion.fromJson(String str) => Criterion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Criterion.fromMap(Map<String, dynamic> json) => Criterion(
        displayTitle: json["displayTitle"],
        sortSeq: json["sortSeq"],
        value: json["value"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "displayTitle": displayTitle,
        "sortSeq": sortSeq,
        "value": value,
        "description": description,
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
