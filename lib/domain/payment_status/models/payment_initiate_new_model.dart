import 'dart:convert';

class PaymentInitiateNewModelDomain {
  PaymentInitiateNewModelDomain({
    this.initiatePaymentV2,
  });

  final InitiatePaymentV2? initiatePaymentV2;

  factory PaymentInitiateNewModelDomain.fromJson(String str) =>
      PaymentInitiateNewModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentInitiateNewModelDomain.fromMap(Map<String, dynamic> json) =>
      PaymentInitiateNewModelDomain(
        initiatePaymentV2: json["initiatePaymentV2"] == null
            ? null
            : InitiatePaymentV2.fromMap(json["initiatePaymentV2"]),
      );

  Map<String, dynamic> toMap() => {
        "initiatePaymentV2": initiatePaymentV2?.toMap(),
      };
}

class InitiatePaymentV2 {
  InitiatePaymentV2({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory InitiatePaymentV2.fromJson(String str) =>
      InitiatePaymentV2.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InitiatePaymentV2.fromMap(Map<String, dynamic> json) =>
      InitiatePaymentV2(
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
    this.bookingUrn,
  });

  final String? bookingUrn;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        bookingUrn: json["bookingUrn"],
      );

  Map<String, dynamic> toMap() => {
        "bookingUrn": bookingUrn,
      };
}

class Status {
  Status({this.code, this.header, this.description});

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
