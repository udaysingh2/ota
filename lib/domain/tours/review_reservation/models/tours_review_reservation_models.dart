// To parse this JSON data, do
//
//     final tourReviewReservation = tourReviewReservationFromMap(jsonString);

import 'dart:convert';

class TourReviewReservation {
  TourReviewReservation({
    this.getTourBookingInitiate,
  });

  final GetTourBookingInitiate? getTourBookingInitiate;

  factory TourReviewReservation.fromJson(String str) =>
      TourReviewReservation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TourReviewReservation.fromMap(Map<String, dynamic> json) =>
      TourReviewReservation(
        getTourBookingInitiate: json["getTourBookingInitiate"] == null
            ? null
            : GetTourBookingInitiate.fromMap(json["getTourBookingInitiate"]),
      );

  Map<String, dynamic> toMap() => {
        "getTourBookingInitiate": getTourBookingInitiate == null
            ? null
            : getTourBookingInitiate!.toMap(),
      };
}

class GetTourBookingInitiate {
  GetTourBookingInitiate({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetTourBookingInitiate.fromJson(String str) =>
      GetTourBookingInitiate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetTourBookingInitiate.fromMap(Map<String, dynamic> json) =>
      GetTourBookingInitiate(
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
    this.bookingUrn,
    this.tourName,
    this.tourImage,
    this.promotionList,
    this.tourDetails,
  });

  final String? bookingUrn;
  final String? tourName;
  final String? tourImage;
  final List<TourReservationPromotionList>? promotionList;
  final TourDetails? tourDetails;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        bookingUrn: json["bookingUrn"],
        tourName: json["tourName"],
        tourImage: json["tourImage"],
        promotionList: json["promotionList"] == null
            ? null
            : List<TourReservationPromotionList>.from(json["promotionList"]
                .map((x) => TourReservationPromotionList.fromMap(x))),
        tourDetails: json["tourDetails"] == null
            ? null
            : TourDetails.fromMap(json["tourDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "bookingUrn": bookingUrn,
        "tourName": tourName,
        "tourImage": tourImage,
        "promotionList": promotionList == null
            ? null
            : List<dynamic>.from(promotionList!.map((x) => x.toMap())),
        "tourDetails": tourDetails == null ? null : tourDetails!.toMap(),
      };
}

class TourReservationPromotionList {
  TourReservationPromotionList({
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

  factory TourReservationPromotionList.fromJson(String str) =>
      TourReservationPromotionList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TourReservationPromotionList.fromMap(Map<String, dynamic> json) =>
      TourReservationPromotionList(
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

class TourDetails {
  TourDetails({
    this.id,
    this.name,
    this.image,
    this.category,
    this.location,
    this.information,
    this.packages,
  });

  final String? id;
  final String? name;
  final String? image;
  final String? category;
  final String? location;
  final Information? information;
  final List<Package>? packages;

  factory TourDetails.fromJson(String str) =>
      TourDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TourDetails.fromMap(Map<String, dynamic> json) => TourDetails(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        category: json["category"],
        location: json["location"],
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
        "category": category,
        "location": location,
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
    this.options,
    this.inclusions,
    this.exclusions,
    this.schedule,
    this.meetingPoint,
    this.conditions,
    this.cancellationPolicy,
    this.shuttle,
    this.adultPrice,
    this.childPrice,
    this.adultPaxId,
    this.childPaxId,
    this.childInfo,
    this.currency,
    this.refCode,
    this.serviceId,
    this.rateKey,
    this.availableSeats,
    this.minimumSeats,
    this.durationText,
    this.duration,
    this.zoneId,
    this.requireInfo,
  });

  final String? name;
  final String? options;
  final Inclusions? inclusions;
  final String? exclusions;
  final String? schedule;
  final String? meetingPoint;
  final String? conditions;
  final String? cancellationPolicy;
  final String? shuttle;
  final double? adultPrice;
  final double? childPrice;
  final String? adultPaxId;
  final String? childPaxId;
  final ChildInfo? childInfo;
  final String? currency;
  final String? refCode;
  final String? serviceId;
  final String? rateKey;
  final int? availableSeats;
  final int? minimumSeats;
  final String? durationText;
  final String? duration;
  final String? zoneId;
  final RequireInfo? requireInfo;

  factory Package.fromJson(String str) => Package.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Package.fromMap(Map<String, dynamic> json) => Package(
        name: json["name"],
        options: json["options"],
        inclusions: json["inclusions"] == null
            ? null
            : Inclusions.fromMap(json["inclusions"]),
        exclusions: json["exclusions"],
        schedule: json["schedule"],
        meetingPoint: json["meetingPoint"],
        conditions: json["conditions"],
        cancellationPolicy: json["cancellationPolicy"],
        shuttle: json["shuttle"],
        adultPrice: json["adultPrice"]?.toDouble(),
        childPrice: json["childPrice"]?.toDouble(),
        adultPaxId: json["adultPaxId"],
        childPaxId: json["childPaxId"],
        childInfo: json["childInfo"] == null
            ? null
            : ChildInfo.fromMap(json["childInfo"]),
        currency: json["currency"],
        refCode: json["refCode"],
        serviceId: json["serviceId"],
        rateKey: json["rateKey"],
        availableSeats: json["availableSeats"],
        minimumSeats: json["minimumSeats"],
        durationText: json["durationText"],
        duration: json["duration"],
        zoneId: json["zoneId"],
        requireInfo: json["requireInfo"] == null
            ? null
            : RequireInfo.fromMap(json["requireInfo"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "options": options,
        "inclusions": inclusions == null ? null : inclusions!.toMap(),
        "exclusions": exclusions,
        "schedule": schedule,
        "meetingPoint": meetingPoint,
        "conditions": conditions,
        "cancellationPolicy": cancellationPolicy,
        "shuttle": shuttle,
        "adultPrice": adultPrice,
        "childPrice": childPrice,
        "adultPaxId": adultPaxId,
        "childPaxId": childPaxId,
        "childInfo": childInfo == null ? null : childInfo!.toMap(),
        "currency": currency,
        "refCode": refCode,
        "serviceId": serviceId,
        "rateKey": rateKey,
        "availableSeats": availableSeats,
        "minimumSeats": minimumSeats,
        "durationText": durationText,
        "duration": duration,
        "zoneId": zoneId,
        "requireInfo": requireInfo == null ? null : requireInfo!.toMap(),
      };
}

class ChildInfo {
  ChildInfo({
    this.minAge,
    this.maxAge,
  });

  final int? minAge;
  final int? maxAge;

  factory ChildInfo.fromJson(String str) => ChildInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChildInfo.fromMap(Map<String, dynamic> json) => ChildInfo(
        minAge: json["minAge"],
        maxAge: json["maxAge"],
      );

  Map<String, dynamic> toMap() => {
        "minAge": minAge,
        "maxAge": maxAge,
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
