// To parse this JSON data, do
//
//     final paymentNewBookingUrnModelDomain = paymentNewBookingUrnModelDomainFromMap(jsonString);

import 'dart:convert';

class PaymentNewBookingUrnModelDomain {
  PaymentNewBookingUrnModelDomain({
    this.generateNewBookingUrn,
  });

  final GenerateNewBookingUrn? generateNewBookingUrn;

  factory PaymentNewBookingUrnModelDomain.fromJson(String str) =>
      PaymentNewBookingUrnModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentNewBookingUrnModelDomain.fromMap(Map<String, dynamic> json) =>
      PaymentNewBookingUrnModelDomain(
        generateNewBookingUrn: json["generateNewBookingUrn"] == null
            ? null
            : GenerateNewBookingUrn.fromMap(json["generateNewBookingUrn"]),
      );

  Map<String, dynamic> toMap() => {
        "generateNewBookingUrn": generateNewBookingUrn?.toMap(),
      };
}

class PaymentNewCarBookingUrnModelDomain {
  PaymentNewCarBookingUrnModelDomain({
    this.generateNewBookingUrn,
  });

  final GenerateNewBookingUrn? generateNewBookingUrn;

  factory PaymentNewCarBookingUrnModelDomain.fromJson(String str) =>
      PaymentNewCarBookingUrnModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentNewCarBookingUrnModelDomain.fromMap(
          Map<String, dynamic> json) =>
      PaymentNewCarBookingUrnModelDomain(
        generateNewBookingUrn: json["generateNewCarBookingUrn"] == null
            ? null
            : GenerateNewBookingUrn.fromMap(json["generateNewCarBookingUrn"]),
      );

  Map<String, dynamic> toMap() => {
        "generateNewCarBookingUrn": generateNewBookingUrn?.toMap(),
      };
}

class GenerateNewBookingUrn {
  GenerateNewBookingUrn({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GenerateNewBookingUrn.fromJson(String str) =>
      GenerateNewBookingUrn.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GenerateNewBookingUrn.fromMap(Map<String, dynamic> json) =>
      GenerateNewBookingUrn(
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
    this.newBookingUrn,
  });

  final String? newBookingUrn;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        newBookingUrn: json["newBookingUrn"],
      );

  Map<String, dynamic> toMap() => {
        "newBookingUrn": newBookingUrn,
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
