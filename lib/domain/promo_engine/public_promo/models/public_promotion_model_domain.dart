import 'dart:convert';

class PublicPromotionModelDomain {
  PublicPromotionModelDomain({
    this.getAvailablePublicPromotions,
  });

  final GetAvailablePublicPromotions? getAvailablePublicPromotions;

  factory PublicPromotionModelDomain.fromJson(String str) =>
      PublicPromotionModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PublicPromotionModelDomain.fromMap(Map<String, dynamic> json) =>
      PublicPromotionModelDomain(
        getAvailablePublicPromotions:
            json["getAvailablePublicPromotions"] == null
                ? null
                : GetAvailablePublicPromotions.fromMap(
                    json["getAvailablePublicPromotions"]),
      );

  Map<String, dynamic> toMap() => {
        "getAvailablePublicPromotions": getAvailablePublicPromotions?.toMap(),
      };
}

class GetAvailablePublicPromotions {
  GetAvailablePublicPromotions({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetAvailablePublicPromotions.fromJson(String str) =>
      GetAvailablePublicPromotions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetAvailablePublicPromotions.fromMap(Map<String, dynamic> json) =>
      GetAvailablePublicPromotions(
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
    this.pagination,
    this.promotionList,
  });

  final Pagination? pagination;
  final List<PromotionList>? promotionList;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromMap(json["pagination"]),
        promotionList: json["promotionList"] == null
            ? null
            : List<PromotionList>.from(
                json["promotionList"].map((x) => PromotionList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "pagination": pagination?.toMap(),
        "promotionList": promotionList == null
            ? null
            : List<dynamic>.from(promotionList!.map((x) => x.toMap())),
      };
}

class Pagination {
  Pagination({
    this.currentPage,
    this.pageSize,
    this.hasNextPage,
    this.hasPreviousPage,
  });

  final int? currentPage;
  final int? pageSize;
  final bool? hasNextPage;
  final bool? hasPreviousPage;

  factory Pagination.fromJson(String str) =>
      Pagination.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pagination.fromMap(Map<String, dynamic> json) => Pagination(
        currentPage: json["currentPage"],
        pageSize: json["pageSize"],
        hasNextPage: json["hasNextPage"],
        hasPreviousPage: json["hasPreviousPage"],
      );

  Map<String, dynamic> toMap() => {
        "currentPage": currentPage,
        "pageSize": pageSize,
        "hasNextPage": hasNextPage,
        "hasPreviousPage": hasPreviousPage,
      };
}

class PromotionList {
  PromotionList({
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

  factory PromotionList.fromMap(Map<String, dynamic> json) => PromotionList(
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
    this.errors,
  });

  final String? code;
  final String? header;
  final String? description;
  final dynamic errors;

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"]?.toString(),
        header: json["header"],
        description: json["description"],
        errors: json["errors"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "header": header,
        "description": description,
        "errors": errors,
      };
}
