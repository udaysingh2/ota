// To parse this JSON data, do
//
//     final paymentInitiateModelDomain = paymentInitiateModelDomainFromMap(jsonString);

import 'dart:convert';

class PaymentStatusModelDomain {
  PaymentStatusModelDomain({
    this.paymentStatus,
  });

  final PaymentStatus? paymentStatus;

  factory PaymentStatusModelDomain.fromJson(String str) =>
      PaymentStatusModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentStatusModelDomain.fromMap(Map<String, dynamic> json) =>
      PaymentStatusModelDomain(
        paymentStatus: json["paymentStatus"] == null
            ? null
            : PaymentStatus.fromMap(json["paymentStatus"]),
      );

  Map<String, dynamic> toMap() => {
        "paymentStatus": paymentStatus?.toMap(),
      };
}

class PaymentStatus {
  PaymentStatus({
    this.data,
    this.status,
  });

  final PaymentStatusData? data;
  final Status? status;

  factory PaymentStatus.fromJson(String str) =>
      PaymentStatus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentStatus.fromMap(Map<String, dynamic> json) => PaymentStatus(
        data: json["data"] == null
            ? null
            : PaymentStatusData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class PaymentStatusData {
  PaymentStatusData({
    this.paymentMethod,
    this.paymentStatus,
    this.paymentPhase,
    this.phaseState,
    this.deeplinkUrl,
    this.callbackUrl,
    this.errorDescription,
    this.isFirstOrder,
  });

  final String? paymentMethod;
  final String? paymentStatus;
  final String? paymentPhase;
  final String? phaseState;
  final dynamic deeplinkUrl;
  final dynamic callbackUrl;
  final dynamic errorDescription;
  final bool? isFirstOrder;

  factory PaymentStatusData.fromJson(String str) =>
      PaymentStatusData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentStatusData.fromMap(Map<String, dynamic> json) =>
      PaymentStatusData(
        paymentMethod: json["paymentMethod"],
        paymentStatus: json["paymentStatus"],
        paymentPhase: json["paymentPhase"],
        phaseState: json["phaseState"],
        deeplinkUrl: json["deeplinkUrl"],
        callbackUrl: json["callbackUrl"],
        errorDescription: json["errorDescription"],
        isFirstOrder: json["isFirstOrder"],
      );

  Map<String, dynamic> toMap() => {
        "paymentMethod": paymentMethod,
        "paymentStatus": paymentStatus,
        "paymentPhase": paymentPhase,
        "phaseState": phaseState,
        "deeplinkUrl": deeplinkUrl,
        "callbackUrl": callbackUrl,
        "errorDescription": errorDescription,
        "isFirstOrder": isFirstOrder,
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
  final dynamic description;

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
