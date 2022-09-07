// To parse this JSON data, do
//
//     final paymentInitiateModelDomain = paymentInitiateModelDomainFromMap(jsonString);

import 'dart:convert';

class PaymentStatusModelDomainAutomation {
  PaymentStatusModelDomainAutomation({
    this.paymentStatus,
  });

  final PaymentStatusAutomation? paymentStatus;

  factory PaymentStatusModelDomainAutomation.fromJson(String str) =>
      PaymentStatusModelDomainAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentStatusModelDomainAutomation.fromMap(
          Map<String, dynamic> json) =>
      PaymentStatusModelDomainAutomation(
        paymentStatus: json["paymentStatus"] == null
            ? null
            : PaymentStatusAutomation.fromMap(json["paymentStatus"]),
      );

  Map<String, dynamic> toMap() => {
        "paymentStatus": paymentStatus == null ? null : paymentStatus?.toMap(),
      };
}

class PaymentStatusAutomation {
  PaymentStatusAutomation({
    this.data,
    this.status,
  });

  final PaymentStatusDataAutomation? data;
  final StatusAutomation? status;

  factory PaymentStatusAutomation.fromJson(String str) =>
      PaymentStatusAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentStatusAutomation.fromMap(Map<String, dynamic> json) =>
      PaymentStatusAutomation(
        data: json["data"] == null
            ? null
            : PaymentStatusDataAutomation.fromMap(json["data"]),
        status: json["status"] == null
            ? null
            : StatusAutomation.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data?.toMap(),
        "status": status == null ? null : status?.toMap(),
      };
}

class PaymentStatusDataAutomation {
  PaymentStatusDataAutomation({
    this.paymentMethod,
    this.paymentStatus,
    this.paymentPhase,
    this.phaseState,
    this.deeplinkUrl,
    this.callbackUrl,
    this.errorDescription,
  });

  final String? paymentMethod;
  final String? paymentStatus;
  final String? paymentPhase;
  final String? phaseState;
  final dynamic deeplinkUrl;
  final dynamic callbackUrl;
  final dynamic errorDescription;

  factory PaymentStatusDataAutomation.fromJson(String str) =>
      PaymentStatusDataAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentStatusDataAutomation.fromMap(Map<String, dynamic> json) =>
      PaymentStatusDataAutomation(
        paymentMethod:
            json["paymentMethod"] == null ? null : json["paymentMethod"],
        paymentStatus:
            json["paymentStatus"] == null ? null : json["paymentStatus"],
        paymentPhase:
            json["paymentPhase"] == null ? null : json["paymentPhase"],
        phaseState: json["phaseState"] == null ? null : json["phaseState"],
        deeplinkUrl: json["deeplinkUrl"],
        callbackUrl: json["callbackUrl"],
        errorDescription: json["errorDescription"],
      );

  Map<String, dynamic> toMap() => {
        "paymentMethod": paymentMethod == null ? null : paymentMethod,
        "paymentStatus": paymentStatus == null ? null : paymentStatus,
        "paymentPhase": paymentPhase == null ? null : paymentPhase,
        "phaseState": phaseState == null ? null : phaseState,
        "deeplinkUrl": deeplinkUrl,
        "callbackUrl": callbackUrl,
        "errorDescription": errorDescription,
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
  final dynamic description;

  factory StatusAutomation.fromJson(String str) =>
      StatusAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatusAutomation.fromMap(Map<String, dynamic> json) =>
      StatusAutomation(
        code: json["code"] == null ? null : json["code"],
        header: json["header"] == null ? null : json["header"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "header": header == null ? null : header,
        "description": description,
      };
}
