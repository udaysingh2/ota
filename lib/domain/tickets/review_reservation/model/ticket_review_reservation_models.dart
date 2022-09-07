// To parse this JSON data, do
//
//     final ticketReviewReservation = ticketReviewReservationFromMap(jsonString);

import 'dart:convert';

class TicketReviewReservation {
  TicketReviewReservation({
    this.getTicketBookingInitiate,
  });

  final GetTicketBookingInitiateDetails? getTicketBookingInitiate;

  factory TicketReviewReservation.fromJson(String str) =>
      TicketReviewReservation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TicketReviewReservation.fromMap(Map<String, dynamic> json) =>
      TicketReviewReservation(
        getTicketBookingInitiate:
            json["getTicketBookingInitiateDetails"] == null
                ? null
                : GetTicketBookingInitiateDetails.fromMap(
                    json["getTicketBookingInitiateDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "getTicketBookingInitiateDetails": getTicketBookingInitiate == null
            ? null
            : getTicketBookingInitiate!.toMap(),
      };
}

class GetTicketBookingInitiateDetails {
  GetTicketBookingInitiateDetails({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetTicketBookingInitiateDetails.fromJson(String str) =>
      GetTicketBookingInitiateDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetTicketBookingInitiateDetails.fromMap(Map<String, dynamic> json) =>
      GetTicketBookingInitiateDetails(
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
    this.totalPrice,
    this.ticketName,
    this.ticketImage,
    this.promotionList,
    this.ticketDetails,
  });

  final String? bookingUrn;
  final double? totalPrice;
  final String? ticketName;
  final String? ticketImage;
  final List<TicketReservationPromotionList>? promotionList;
  final TicketDetails? ticketDetails;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        bookingUrn: json["bookingUrn"],
        totalPrice:
            json["totalPrice"] == null ? null : json["totalPrice"]!.toDouble(),
        ticketName: json["ticketName"],
        ticketImage: json["ticketImage"],
        promotionList: json["promotionList"] == null
            ? null
            : List<TicketReservationPromotionList>.from(json["promotionList"]
                .map((x) => TicketReservationPromotionList.fromMap(x))),
        ticketDetails: json["ticketDetails"] == null
            ? null
            : TicketDetails.fromMap(json["ticketDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "bookingUrn": bookingUrn,
        "totalPrice": totalPrice,
        "ticketName": ticketName,
        "ticketImage": ticketImage,
        "promotionList": promotionList == null
            ? null
            : List<dynamic>.from(promotionList!.map((x) => x.toMap())),
        "ticketDetails": ticketDetails == null ? null : ticketDetails!.toMap(),
      };
}

class TicketReservationPromotionList {
  TicketReservationPromotionList({
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
  factory TicketReservationPromotionList.fromJson(String str) =>
      TicketReservationPromotionList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TicketReservationPromotionList.fromMap(Map<String, dynamic> json) =>
      TicketReservationPromotionList(
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

class TicketDetails {
  TicketDetails({
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

  factory TicketDetails.fromJson(String str) =>
      TicketDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TicketDetails.fromMap(Map<String, dynamic> json) => TicketDetails(
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
    this.options,
    this.inclusions,
    this.exclusions,
    this.conditions,
    this.schedule,
    this.meetingPoint,
    this.shuttle,
    this.cancellationPolicy,
    this.childInfo,
    this.ticketTypes,
    this.currency,
    this.refCode,
    this.serviceId,
    this.rateKey,
    this.durationText,
    this.duration,
    this.zoneId,
    this.requireInfo,
  });

  final String? name;
  final String? options;
  final Inclusions? inclusions;
  final String? exclusions;
  final String? conditions;
  final String? schedule;
  final String? meetingPoint;
  final String? shuttle;
  final String? cancellationPolicy;
  final ChildInfo? childInfo;
  final List<TicketType>? ticketTypes;
  final String? currency;
  final String? refCode;
  final String? serviceId;
  final String? rateKey;
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
        conditions: json["conditions"],
        schedule: json["schedule"],
        meetingPoint: json["meetingPoint"],
        shuttle: json["shuttle"],
        cancellationPolicy: json["cancellationPolicy"],
        childInfo: json["childInfo"] == null
            ? null
            : ChildInfo.fromMap(json["childInfo"]),
        ticketTypes: json["ticketTypes"] == null
            ? null
            : List<TicketType>.from(
                json["ticketTypes"].map((x) => TicketType.fromMap(x))),
        currency: json["currency"],
        refCode: json["refCode"],
        serviceId: json["serviceId"],
        rateKey: json["rateKey"],
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
        "conditions": conditions,
        "schedule": schedule,
        "meetingPoint": meetingPoint,
        "shuttle": shuttle,
        "cancellationPolicy": cancellationPolicy,
        "childInfo": childInfo == null ? null : childInfo!.toMap(),
        "ticketTypes": ticketTypes == null
            ? null
            : List<dynamic>.from(ticketTypes!.map((x) => x.toMap())),
        "currency": currency,
        "refCode": refCode,
        "serviceId": serviceId,
        "rateKey": rateKey,
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

class TicketType {
  TicketType({
    this.paxId,
    this.name,
    this.price,
    this.noOfTickets,
    this.minimum,
    this.available,
  });

  final String? paxId;
  final String? name;
  final double? price;
  final int? noOfTickets;
  final int? minimum;
  final int? available;

  factory TicketType.fromJson(String str) =>
      TicketType.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TicketType.fromMap(Map<String, dynamic> json) => TicketType(
        paxId: json["paxId"],
        name: json["name"],
        price: json["price"] == null ? null : json["price"]!.toDouble(),
        noOfTickets: json["noOfTickets"],
        minimum: json["minimum"],
        available: json["available"],
      );

  Map<String, dynamic> toMap() => {
        "paxId": paxId,
        "name": name,
        "price": price,
        "noOfTickets": noOfTickets,
        "minimum": minimum,
        "available": available,
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
