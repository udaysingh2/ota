// To parse this JSON data, do
//
//     final carBookingCancellationModelDomain = carBookingCancellationModelDomainFromMap(jsonString);

import 'dart:convert';

class CarBookingCancellationModelDomain {
  CarBookingCancellationModelDomain({
    this.status,
    this.data,
  });

  final Status? status;
  final Data? data;

  factory CarBookingCancellationModelDomain.fromJson(String str) =>
      CarBookingCancellationModelDomain.fromMap(json.decode(str));

  factory CarBookingCancellationModelDomain.fromMap(
          Map<String, dynamic> json) =>
      CarBookingCancellationModelDomain(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );
}

class Data {
  Data({
    this.actionStatus,
  });

  final String? actionStatus;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        actionStatus: json["actionStatus"],
      );
}

class Refund {
  Refund({
    this.reservationCancellationFee,
    this.processingFee,
    this.refundAmount,
  });

  final double? reservationCancellationFee;
  final double? processingFee;
  final double? refundAmount;

  factory Refund.fromJson(String str) => Refund.fromMap(json.decode(str));

  factory Refund.fromMap(Map<String, dynamic> json) => Refund(
        reservationCancellationFee: json["reservationCancellationFee"] == null
            ? null
            : double.tryParse("${json["reservationCancellationFee"]}"),
        processingFee: json["processingFee"] == null
            ? null
            : double.tryParse("${json["processingFee"]}"),
        refundAmount: json["refundAmount"] == null
            ? null
            : double.tryParse("${json["refundAmount"]}"),
      );
}

class Status {
  Status({this.code, this.header, this.description});

  final String? code;
  final String? header;
  final String? description;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  factory Status.fromMap(Map<String, dynamic> json) => Status(
      code: json["code"],
      header: json["header"],
      description: json['description']);
}
