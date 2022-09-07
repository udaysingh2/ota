// To parse this JSON data, do
//
//     final applyPromoModelDomain = applyPromoModelDomainFromMap(jsonString);

import 'dart:convert';

class ApplyPromoModelDomain {
  ApplyPromoModelDomain({
    this.applyPromoCode,
  });

  final ApplyPromoCode? applyPromoCode;

  factory ApplyPromoModelDomain.fromJson(String str) =>
      ApplyPromoModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ApplyPromoModelDomain.fromMap(Map<String, dynamic> json) =>
      ApplyPromoModelDomain(
        applyPromoCode: json["applyPromoCode"] == null
            ? null
            : ApplyPromoCode.fromMap(json["applyPromoCode"]),
      );

  Map<String, dynamic> toMap() => {
        "applyPromoCode":
            applyPromoCode == null ? null : applyPromoCode!.toMap(),
      };
}

class ApplyPromoCode {
  ApplyPromoCode({
    this.status,
    this.data,
  });

  final Status? status;
  final Data? data;

  factory ApplyPromoCode.fromJson(String str) =>
      ApplyPromoCode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ApplyPromoCode.fromMap(Map<String, dynamic> json) => ApplyPromoCode(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status!.toMap(),
        "data": data == null ? null : data!.toMap(),
      };
}

class Data {
  Data({
    this.bookingUrn,
    this.priceDetails,
  });

  final String? bookingUrn;
  final PriceDetails? priceDetails;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        bookingUrn: json["bookingUrn"],
        priceDetails: json["priceDetails"] == null
            ? null
            : PriceDetails.fromMap(json["priceDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "bookingUrn": bookingUrn,
        "priceDetails": priceDetails == null ? null : priceDetails!.toMap(),
      };
}

class PriceDetails {
  PriceDetails({
    this.effectiveDiscount,
    this.orderPrice,
    this.addonPrice,
    this.billingAmount,
    this.totalAmount,
  });

  final double? effectiveDiscount;
  final double? orderPrice;
  final double? addonPrice;
  final double? billingAmount;
  final double? totalAmount;

  factory PriceDetails.fromJson(String str) =>
      PriceDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PriceDetails.fromMap(Map<String, dynamic> json) => PriceDetails(
        effectiveDiscount: json["effectiveDiscount"]?.toDouble(),
        orderPrice: json["orderPrice"]?.toDouble(),
        addonPrice: json["addonPrice"]?.toDouble(),
        billingAmount: json["billingAmount"]?.toDouble(),
        totalAmount: json["totalAmount"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "effectiveDiscount": effectiveDiscount,
        "orderPrice": orderPrice,
        "addonPrice": addonPrice,
        "billingAmount": billingAmount,
        "totalAmount": totalAmount,
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
