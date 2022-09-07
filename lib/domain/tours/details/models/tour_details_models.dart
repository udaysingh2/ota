// To parse this JSON data, do
//
//     final tourDetail = tourDetailFromMap(jsonString);

import 'dart:convert';

class TourDetail {
  TourDetail({
    this.getTourDetails,
  });

  final GetTourDetails? getTourDetails;

  factory TourDetail.fromJson(String str) =>
      TourDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TourDetail.fromMap(Map<String, dynamic> json) => TourDetail(
        getTourDetails: json["getTourDetails"] == null
            ? null
            : GetTourDetails.fromMap(json["getTourDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "getTourDetails":
            getTourDetails == null ? null : getTourDetails!.toMap(),
      };
}

class GetTourDetails {
  GetTourDetails({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetTourDetails.fromJson(String str) =>
      GetTourDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetTourDetails.fromMap(Map<String, dynamic> json) => GetTourDetails(
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
    this.promotionList,
    this.tour,
  });

  final List<TourDetailPromotionList>? promotionList;
  final Tour? tour;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        promotionList: json["promotionList"] == null
            ? null
            : List<TourDetailPromotionList>.from(json["promotionList"]
                .map((x) => TourDetailPromotionList.fromMap(x))),
        tour: json["tour"] == null ? null : Tour.fromMap(json["tour"]),
      );

  Map<String, dynamic> toMap() => {
        "promotionList": promotionList == null
            ? null
            : List<dynamic>.from(promotionList!.map((x) => x.toMap())),
        "tour": tour == null ? null : tour!.toMap(),
      };
}

class TourDetailPromotionList {
  TourDetailPromotionList({
    this.productType,
    this.promotionCode,
    this.title,
    this.description,
    this.web,
    this.iconImage,
    this.bannerDescDisplay,
    this.line1,
    this.line2,
    this.productId,
    this.promotionType,
  });

  final String? productType;
  final String? promotionCode;
  final String? title;
  final String? description;
  final String? web;
  final String? iconImage;
  final bool? bannerDescDisplay;
  final String? line1;
  final String? line2;
  final String? productId;
  final String? promotionType;

  factory TourDetailPromotionList.fromJson(String str) =>
      TourDetailPromotionList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TourDetailPromotionList.fromMap(Map<String, dynamic> json) =>
      TourDetailPromotionList(
        productType: json["productType"],
        promotionCode: json["promotionCode"],
        title: json["title"],
        description: json["description"],
        web: json["web"],
        iconImage: json["iconImage"],
        bannerDescDisplay: json["bannerDescDisplay"],
        line1: json["line1"],
        line2: json["line2"],
        productId: json["productId"],
        promotionType: json["promotionType"],
      );

  Map<String, dynamic> toMap() => {
        "productType": productType,
        "promotionCode": promotionCode,
        "title": title,
        "description": description,
        "web": web,
        "iconImage": iconImage,
        "bannerDescDisplay": bannerDescDisplay,
        "line1": line1,
        "line2": line2,
        "productId": productId,
        "promotionType": promotionType,
      };
}

class Tour {
  Tour({
    this.id,
    this.name,
    this.image,
    this.location,
    this.category,
    this.information,
    this.packages,
  });

  final String? id;
  final String? name;
  final String? image;
  final String? location;
  final String? category;
  final Information? information;
  final List<Package>? packages;

  factory Tour.fromJson(String str) => Tour.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tour.fromMap(Map<String, dynamic> json) => Tour(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        location: json["location"],
        category: json["category"],
        information: json["information"] == null
            ? null
            : Information.fromMap(json["information"]),
        packages: json["packages"] == null
            ? null
            : List<Package>.from(
                json["packages"].map((x) => Package.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "location": location,
        "category": category,
        "information": information == null ? null : information!.toMap(),
        "packages": packages == null
            ? null
            : List<dynamic>.from(packages!.map((x) => x.toMap())),
      };
}

class Information {
  Information({
    this.description,
    this.conditions,
    this.howToUse,
    this.providerName,
    this.openTime,
    this.closeTime,
  });

  final String? description;
  final String? conditions;
  final String? howToUse;
  final String? providerName;
  final String? openTime;
  final String? closeTime;

  factory Information.fromJson(String str) =>
      Information.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Information.fromMap(Map<String, dynamic> json) => Information(
        description: json["description"],
        conditions: json["conditions"],
        howToUse: json["howToUse"],
        providerName: json["providerName"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
      );

  Map<String, dynamic> toMap() => {
        "description": description,
        "conditions": conditions,
        "howToUse": howToUse,
        "providerName": providerName,
        "openTime": openTime,
        "closeTime": closeTime,
      };
}

class Package {
  Package({
    this.name,
    this.inclusions,
    this.style,
    this.exclusions,
    this.conditions,
    this.schedule,
    this.meetingPoint,
    this.cancellationPolicy,
    this.shuttle,
    this.adultPrice,
    this.childPrice,
    this.totalPrice,
    this.childInfo,
    this.adultPaxId,
    this.childPaxId,
    this.currency,
    this.refCode,
    this.serviceId,
    this.serviceType,
    this.timeOfDay,
    this.startTime,
    this.rateKey,
    this.availableSeats,
    this.minimumSeats,
    this.durationText,
    this.zoneId,
    this.requireInfo,
  });

  final String? name;
  final Inclusions? inclusions;
  final Style? style;
  final String? exclusions;
  final String? conditions;
  final String? schedule;
  final String? meetingPoint;
  final String? cancellationPolicy;
  final String? shuttle;
  final double? adultPrice;
  final double? childPrice;
  final double? totalPrice;
  final String? adultPaxId;
  final String? childPaxId;
  final ChildInfo? childInfo;
  final String? currency;
  final String? refCode;
  final String? serviceId;
  final String? serviceType;
  final String? timeOfDay;
  final String? startTime;
  final String? rateKey;
  final int? availableSeats;
  final int? minimumSeats;
  final String? durationText;
  final String? zoneId;
  final RequireInfo? requireInfo;

  factory Package.fromJson(String str) => Package.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Package.fromMap(Map<String, dynamic> json) {
    return Package(
      name: json["name"],
      inclusions: json["inclusions"] == null
          ? null
          : Inclusions.fromMap(json["inclusions"]),
      style: json["style"] == null ? null : Style.fromMap(json["style"]),
      exclusions: json["exclusions"],
      conditions: json["conditions"],
      schedule: json["schedule"],
      meetingPoint: json["meetingPoint"],
      cancellationPolicy: json["cancellationPolicy"],
      shuttle: json["shuttle"],
      adultPrice: json["adultPrice"]?.toDouble(),
      childPrice: json["childPrice"]?.toDouble(),
      totalPrice: json["totalPrice"]?.toDouble(),
      adultPaxId: json["adultPaxId"],
      childPaxId: json["childPaxId"],
      childInfo: json["childInfo"] == null
          ? null
          : ChildInfo.fromMap(json["childInfo"]),
      currency: json["currency"],
      refCode: json["refCode"],
      serviceId: json["serviceId"],
      serviceType: json["serviceType"],
      timeOfDay: json["timeOfDay"],
      startTime: json["startTime"],
      rateKey: json["rateKey"],
      availableSeats: json["availableSeats"],
      minimumSeats: json["minimumSeats"],
      durationText: json["durationText"],
      zoneId: json["zoneId"],
      requireInfo: json["requireInfo"] == null
          ? null
          : RequireInfo.fromMap(json["requireInfo"]),
    );
  }

  Map<String, dynamic> toMap() => {
        "name": name,
        "inclusions": inclusions == null ? null : inclusions!.toMap(),
        "style": style == null ? null : style!.toMap(),
        "exclusions": exclusions,
        "conditions": conditions,
        "schedule": schedule,
        "meetingPoint": meetingPoint,
        "cancellationPolicy": cancellationPolicy,
        "shuttle": shuttle,
        "adultPrice": adultPrice,
        "childPrice": childPrice,
        "totalPrice": totalPrice,
        "adultPaxId": adultPaxId,
        "childPaxId": childPaxId,
        "childInfo": childInfo == null ? null : childInfo!.toMap(),
        "currency": currency,
        "refCode": refCode,
        "serviceId": serviceId,
        "serviceType": serviceType,
        "startTime": startTime,
        "timeOfDay": timeOfDay,
        "rateKey": rateKey,
        "availableSeats": availableSeats,
        "minimumSeats": minimumSeats,
        "durationText": durationText,
        "zoneId": zoneId,
        "requireInfo": requireInfo == null ? null : requireInfo!.toMap(),
      };
}

class ChildInfo {
  ChildInfo({
    this.minAge,
    this.maxAge,
    this.description,
  });

  final int? minAge;
  final int? maxAge;
  final String? description;

  factory ChildInfo.fromJson(String str) => ChildInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChildInfo.fromMap(Map<String, dynamic> json) => ChildInfo(
        minAge: json["minAge"],
        maxAge: json["maxAge"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "minAge": minAge,
        "maxAge": maxAge,
        "description": description,
      };
}

class Inclusions {
  Inclusions({
    this.highlights,
    this.all,
  });

  final List<Highlight>? highlights;
  final String? all;

  factory Inclusions.fromJson(String str) =>
      Inclusions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Inclusions.fromMap(Map<String, dynamic> json) => Inclusions(
        highlights: json["highlights"] == null
            ? null
            : List<Highlight>.from(
                json["highlights"].map((x) => Highlight.fromMap(x))),
        all: json["all"],
      );

  Map<String, dynamic> toMap() => {
        "highlights": highlights == null
            ? null
            : List<dynamic>.from(highlights!.map((x) => x.toMap())),
        "all": all,
      };
}

class Highlight {
  Highlight({
    this.key,
    this.value,
  });

  final String? key;
  final String? value;

  factory Highlight.fromJson(String str) => Highlight.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Highlight.fromMap(Map<String, dynamic> json) => Highlight(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "key": key,
        "value": value,
      };
}

class RequireInfo {
  RequireInfo({
    this.weight,
    this.allName,
    this.guestName,
    this.passportId,
    this.dateOfBirth,
    this.passportCountry,
    this.passportValidDate,
    this.passportCountryIssue,
  });

  final bool? weight;
  final bool? allName;
  final bool? guestName;
  final bool? passportId;
  final bool? dateOfBirth;
  final bool? passportCountry;
  final bool? passportValidDate;
  final bool? passportCountryIssue;

  factory RequireInfo.fromJson(String str) =>
      RequireInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RequireInfo.fromMap(Map<String, dynamic> json) => RequireInfo(
        weight: json["weight"],
        allName: json["allName"],
        guestName: json["guestName"],
        passportId: json["passportId"],
        dateOfBirth: json["dateOfBirth"],
        passportCountry: json["passportCountry"],
        passportValidDate: json["passportValidDate"],
        passportCountryIssue: json["passportCountryIssue"],
      );

  Map<String, dynamic> toMap() => {
        "weight": weight,
        "allName": allName,
        "guestName": guestName,
        "passportId": passportId,
        "dateOfBirth": dateOfBirth,
        "passportCountry": passportCountry,
        "passportValidDate": passportValidDate,
        "passportCountryIssue": passportCountryIssue,
      };
}

class Style {
  Style({
    this.id,
    this.name,
  });

  final String? id;
  final String? name;

  factory Style.fromJson(String str) => Style.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Style.fromMap(Map<String, dynamic> json) => Style(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
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
