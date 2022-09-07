import 'dart:convert';

class TicketBookingDetailCancellationDomain {
  TicketBookingDetailCancellationDomain({
    this.getTicketBookingReject,
  });

  final GetTicketBookingReject? getTicketBookingReject;

  factory TicketBookingDetailCancellationDomain.fromJson(String str) =>
      TicketBookingDetailCancellationDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TicketBookingDetailCancellationDomain.fromMap(
          Map<String, dynamic> json) =>
      TicketBookingDetailCancellationDomain(
        getTicketBookingReject: json["getTicketBookingReject"] == null
            ? null
            : GetTicketBookingReject.fromMap(json["getTicketBookingReject"]),
      );

  Map<String, dynamic> toMap() => {
        "getTicketBookingReject": getTicketBookingReject?.toMap(),
      };
}

class GetTicketBookingReject {
  GetTicketBookingReject({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetTicketBookingReject.fromJson(String str) =>
      GetTicketBookingReject.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetTicketBookingReject.fromMap(Map<String, dynamic> json) =>
      GetTicketBookingReject(
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
    this.actionStatus,
    this.cancellationDate,
    this.totalAmount,
    this.refund,
  });

  final String? actionStatus;
  final String? cancellationDate;
  final double? totalAmount;
  final Refund? refund;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        actionStatus: json["actionStatus"],
        cancellationDate: json["cancellationDate"],
        totalAmount: json["totalAmount"]?.toDouble(),
        refund: json["refund"] == null ? null : Refund.fromMap(json["refund"]),
      );

  Map<String, dynamic> toMap() => {
        "actionStatus": actionStatus,
        "cancellationDate": cancellationDate,
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

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        header: json["header"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "header": header,
      };
}
