import 'dart:convert';

class TourSearchResultModelDomain {
  TourSearchResultModelDomain({
    this.getTourAndTicketSearchResult,
  });

  final GetTourAndTicketSearchResult? getTourAndTicketSearchResult;

  factory TourSearchResultModelDomain.fromJson(String str) =>
      TourSearchResultModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TourSearchResultModelDomain.fromMap(Map<String, dynamic> json) =>
      TourSearchResultModelDomain(
        getTourAndTicketSearchResult:
            json["getTourAndTicketSearchResult"] == null
                ? null
                : GetTourAndTicketSearchResult.fromMap(
                    json["getTourAndTicketSearchResult"]),
      );

  Map<String, dynamic> toMap() => {
        "getTourAndTicketSearchResult": getTourAndTicketSearchResult == null
            ? null
            : getTourAndTicketSearchResult!.toMap(),
      };
}

class GetTourAndTicketSearchResult {
  GetTourAndTicketSearchResult({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetTourAndTicketSearchResult.fromJson(String str) =>
      GetTourAndTicketSearchResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetTourAndTicketSearchResult.fromMap(Map<String, dynamic> json) =>
      GetTourAndTicketSearchResult(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
        "status": status == null ? null : status!.toMap(),
      };
}

class Data {
  Data({
    this.location,
    this.tourAndTicketActivityList,
    this.filter,
  });

  final String? location;
  final List<TourAndTicketActivityList>? tourAndTicketActivityList;
  final Filter? filter;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        location: json["location"],
        tourAndTicketActivityList: json["tourAndTicketActivityList"] == null
            ? null
            : List<TourAndTicketActivityList>.from(
                json["tourAndTicketActivityList"]
                    .map((x) => TourAndTicketActivityList.fromMap(x))),
        filter: json["filter"] == null ? null : Filter.fromMap(json["filter"]),
      );

  Map<String, dynamic> toMap() => {
        "id": location,
        "tourAndTicketActivityList": tourAndTicketActivityList == null
            ? null
            : List<dynamic>.from(
                tourAndTicketActivityList!.map((x) => x.toMap())),
        "filter": filter == null ? null : filter!.toMap(),
      };
}

class Filter {
  Filter({
    this.minPrice,
    this.maxPrice,
    this.styleName,
  });

  final double? minPrice;
  final double? maxPrice;
  final List<String>? styleName;

  factory Filter.fromJson(String str) => Filter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Filter.fromMap(Map<String, dynamic> json) => Filter(
        minPrice: json["minPrice"]?.toDouble(),
        maxPrice: json["maxPrice"]?.toDouble(),
        styleName: json["styleName"] == null
            ? null
            : List<String>.from(json["styleName"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "minPrice": minPrice,
        "maxPrice": maxPrice,
        "styleName": styleName == null
            ? null
            : List<dynamic>.from(styleName!.map((x) => x)),
      };
}

class TourAndTicketActivityList {
  TourAndTicketActivityList({
    this.id,
    this.name,
    this.styleName,
    this.locationName,
    this.cityId,
    this.cityName,
    this.countryId,
    this.countryName,
    this.imageUrl,
    this.startPrice,
    this.promotionTextLine1,
    this.promotionTextLine2,
    this.capsulePromotion,
  });

  final String? id;
  final String? name;
  final String? styleName;
  final String? locationName;
  final String? cityId;
  final String? cityName;
  final String? countryId;
  final String? countryName;
  final String? imageUrl;
  final double? startPrice;
  final String? promotionTextLine1;
  final String? promotionTextLine2;
  final List<CapsulePromotion>? capsulePromotion;

  factory TourAndTicketActivityList.fromJson(String str) =>
      TourAndTicketActivityList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TourAndTicketActivityList.fromMap(Map<String, dynamic> json) =>
      TourAndTicketActivityList(
        id: json["id"],
        name: json["name"],
        styleName: json["styleName"],
        locationName: json["locationName"],
        cityId: json["cityId"],
        cityName: json["cityName"],
        countryId: json["countryId"],
        countryName: json["countryName"],
        imageUrl: json["imageUrl"],
        startPrice: json["startPrice"]?.toDouble(),
        promotionTextLine1: json["promotionText_line1"],
        promotionTextLine2: json["promotionText_line2"],
        capsulePromotion: json["capsulePromotion"] == null
            ? null
            : List<CapsulePromotion>.from(json["capsulePromotion"]
                .map((x) => CapsulePromotion.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "styleName": styleName,
        "locationName": locationName,
        "cityId": cityId,
        "cityName": cityName,
        "countryId": countryId,
        "countryName": countryName,
        "imageUrl": imageUrl,
        "startPrice": startPrice,
        "promotionText_line1": promotionTextLine1,
        "promotionText_line2": promotionTextLine2,
        "capsulePromotion": capsulePromotion == null
            ? null
            : List<dynamic>.from(capsulePromotion!.map((x) => x.toMap())),
      };
}

class CapsulePromotion {
  CapsulePromotion({
    this.name,
    this.code,
  });

  final String? name;
  final String? code;

  factory CapsulePromotion.fromMap(Map<String, dynamic> json) =>
      CapsulePromotion(
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "code": code,
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
