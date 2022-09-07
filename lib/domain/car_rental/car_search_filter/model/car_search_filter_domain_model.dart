import 'dart:convert';

class CarSearchFilterDomainModel {
  CarSearchFilterDomainModel({
    this.status,
    this.filterData,
  });

  final Status? status;
  final CarSearchFilterData? filterData;

  factory CarSearchFilterDomainModel.fromMap(Map<String, dynamic>? json) =>
      CarSearchFilterDomainModel(
        status:
            json?["status"] == null ? null : Status.fromMap(json?["status"]),
        filterData: json?["data"] == null
            ? null
            : CarSearchFilterData.fromMap(json?["data"]),
      );

  factory CarSearchFilterDomainModel.fromString(String str) =>
      CarSearchFilterDomainModel.fromMap(json.decode(str));
}

class CarSearchFilterData {
  CarSearchFilterData({
    this.sortInfo,
    this.criteria,
  });

  final List<Criterion>? sortInfo;
  final List<Criterion>? criteria;

  factory CarSearchFilterData.fromMap(Map<String, dynamic> json) =>
      CarSearchFilterData(
        sortInfo: json["sortInfo"] == null
            ? null
            : List<Criterion>.from(
                json["sortInfo"].map((x) => Criterion.fromMap(x))),
        criteria: json["criteria"] == null
            ? null
            : List<Criterion>.from(
                json["criteria"].map((x) => Criterion.fromMap(x))),
      );
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

  factory Criterion.fromMap(Map<String, dynamic> json) => Criterion(
        displayTitle: json["displayTitle"],
        sortSeq:
            json["sortSeq"] == null ? null : int.tryParse("${json["sortSeq"]}"),
        value: json["value"],
        description: json["description"],
      );
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

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"] == null ? null : int.tryParse("${json["code"]}"),
        header: json["header"],
        description: json["description"],
      );
}
