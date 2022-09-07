// To parse this JSON data, do
//
//     final hotelBookingCancellationModel = hotelBookingCancellationModelFromMap(jsonString);

import 'dart:convert';

class HotelBookingCancellationModelDomain {
  HotelBookingCancellationModelDomain({
    this.data,
    this.status,
  });

  final HotelBookingCancellationDataDomain? data;
  final Status? status;

  factory HotelBookingCancellationModelDomain.fromJson(String str) =>
      HotelBookingCancellationModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelBookingCancellationModelDomain.fromMap(
          Map<String, dynamic> json) =>
      HotelBookingCancellationModelDomain(
        data: json["data"] == null
            ? null
            : HotelBookingCancellationDataDomain.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class HotelBookingCancellationDataDomain {
  HotelBookingCancellationDataDomain({
    this.actionStatus,
    this.cancellationDate,
    this.totalAmount,
    this.refund,
  });

  final String? actionStatus;
  final DateTime? cancellationDate;
  final double? totalAmount;
  final Refund? refund;

  factory HotelBookingCancellationDataDomain.fromJson(String str) =>
      HotelBookingCancellationDataDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelBookingCancellationDataDomain.fromMap(
          Map<String, dynamic> json) =>
      HotelBookingCancellationDataDomain(
        actionStatus: json["actionStatus"],
        cancellationDate: json["cancellationDate"] == null
            ? null
            : DateTime.tryParse(json["cancellationDate"]),
        totalAmount: json["totalAmount"]?.toDouble(),
        refund: json["refund"] == null ? null : Refund.fromMap(json["refund"]),
      );

  Map<String, dynamic> toMap() => {
        "actionStatus": actionStatus,
        "cancellationDate": cancellationDate == null
            ? null
            : "${cancellationDate?.year.toString().padLeft(4, '0')}-${cancellationDate?.month.toString().padLeft(2, '0')}-${cancellationDate?.day.toString().padLeft(2, '0')}",
        "totalAmount": totalAmount,
        "refund": refund?.toMap(),
      };
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

  String toJson() => json.encode(toMap());

  factory Refund.fromMap(Map<String, dynamic> json) => Refund(
        reservationCancellationFee:
            json["reservationCancellationFee"]?.toDouble(),
        processingFee: json["processingFee"]?.toDouble(),
        refundAmount: json["refundAmount"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "reservationCancellationFee": reservationCancellationFee,
        "processingFee": processingFee,
        "refundAmount": refundAmount,
      };
}

class Status {
  Status({
    this.code,
    this.header,
  });

  final String? code;
  final String? header;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        header: json["header"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "header": header,
      };
}
