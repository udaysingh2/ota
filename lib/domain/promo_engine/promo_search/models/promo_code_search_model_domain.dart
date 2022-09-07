import 'dart:convert';

class PromoCodeSearchModelDomain {
  PromoCodeSearchModelDomain({
    this.searchPromoCode,
  });

  final SearchPromoCode? searchPromoCode;

  factory PromoCodeSearchModelDomain.fromJson(String str) =>
      PromoCodeSearchModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PromoCodeSearchModelDomain.fromMap(Map<String, dynamic> json) =>
      PromoCodeSearchModelDomain(
        searchPromoCode: json["searchPromoCode"] == null
            ? null
            : SearchPromoCode.fromMap(json["searchPromoCode"]),
      );

  Map<String, dynamic> toMap() => {
        "searchPromoCode": searchPromoCode?.toMap(),
      };
}

class SearchPromoCode {
  SearchPromoCode({
    this.data,
    this.status,
  });

  final PromoCodeData? data;
  final Status? status;

  factory SearchPromoCode.fromJson(String str) =>
      SearchPromoCode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchPromoCode.fromMap(Map<String, dynamic> json) => SearchPromoCode(
        data: json["data"] == null ? null : PromoCodeData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class PromoCodeData {
  PromoCodeData({
    this.promotionId,
    this.promotionName,
    this.shortDescription,
    this.discount,
    this.maximumDiscount,
    this.discountType,
    this.discountFor,
    this.promotionLink,
    this.promotionType,
    this.iconUrl,
    this.voucherCode,
    this.promotionCode,
    this.startDate,
    this.endDate,
    this.applicationKey,
  });

  final int? promotionId;
  final String? promotionName;
  final String? shortDescription;
  final double? discount;
  final double? maximumDiscount;
  final String? discountType;
  final String? discountFor;
  final String? promotionLink;
  final String? promotionType;
  final String? iconUrl;
  final String? voucherCode;
  final String? promotionCode;
  final String? startDate;
  final String? endDate;
  final String? applicationKey;

  factory PromoCodeData.fromJson(String str) =>
      PromoCodeData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PromoCodeData.fromMap(Map<String, dynamic> json) => PromoCodeData(
        promotionId: json["promotionId"],
        promotionName: json["promotionName"],
        shortDescription: json["shortDescription"],
        discount: json["discount"]?.toDouble(),
        maximumDiscount: json["maximumDiscount"]?.toDouble(),
        discountType: json["discountType"],
        discountFor: json["discountFor"],
        promotionLink: json["promotionLink"],
        promotionType: json["promotionType"],
        iconUrl: json["iconUrl"],
        voucherCode: json["voucherCode"],
        promotionCode: json["promotionCode"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        applicationKey: json["applicationKey"],
      );

  Map<String, dynamic> toMap() => {
        "promotionId": promotionId,
        "promotionName": promotionName,
        "shortDescription": shortDescription,
        "discount": discount,
        "maximumDiscount": maximumDiscount,
        "discountType": discountType,
        "discountFor": discountFor,
        "promotionLink": promotionLink,
        "promotionType": promotionType,
        "iconUrl": iconUrl,
        "voucherCode": voucherCode,
        "promotionCode": promotionCode,
        "startDate": startDate,
        "endDate": endDate,
        "applicationKey": applicationKey,
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
        code: json["code"]?.toString(),
        header: json["header"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "header": header,
        "description": description,
      };
}
