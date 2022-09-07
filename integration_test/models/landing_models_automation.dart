// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

class LandingDataAutomation {
  LandingDataAutomation({
    this.getLandingPageDetails,
  });

  final GetLandingPageDetailsAutomation? getLandingPageDetails;

  factory LandingDataAutomation.fromJson(String str) =>
      LandingDataAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LandingDataAutomation.fromMap(Map<String, dynamic>? json) =>
      LandingDataAutomation(
        getLandingPageDetails: json?["getLandingPageDetails"] == null
            ? null
            : GetLandingPageDetailsAutomation.fromMap(
                json?["getLandingPageDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "getLandingPageDetails": getLandingPageDetails == null
            ? null
            : getLandingPageDetails?.toMap(),
      };
}

class GetLandingPageDetailsAutomation {
  GetLandingPageDetailsAutomation({
    this.data,
    this.status,
  });

  final GetLandingPageDetailsDataAutomation? data;
  final StatusAutomation? status;

  factory GetLandingPageDetailsAutomation.fromJson(String str) =>
      GetLandingPageDetailsAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetLandingPageDetailsAutomation.fromMap(Map<String, dynamic> json) =>
      GetLandingPageDetailsAutomation(
        data: json["data"] == null
            ? null
            : GetLandingPageDetailsDataAutomation.fromMap(json["data"]),
        status: json["status"] == null
            ? null
            : StatusAutomation.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data?.toMap(),
        "status": status == null ? null : status?.toMap(),
      };
}

class GetLandingPageDetailsDataAutomation {
  GetLandingPageDetailsDataAutomation({
    this.defaultCustomText,
    this.backgroundUrl,
    this.businessCards,
    this.banner,
    this.popups,
    this.promotions,
  });

  final String? defaultCustomText;
  final String? backgroundUrl;
  final List<BusinessCardAutomation>? businessCards;
  final List<BannerAutomation>? banner;
  final List<PopupAutomation>? popups;
  final List<PromotionAutomation>? promotions;

  factory GetLandingPageDetailsDataAutomation.fromJson(String str) =>
      GetLandingPageDetailsDataAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetLandingPageDetailsDataAutomation.fromMap(
          Map<String, dynamic> json) =>
      GetLandingPageDetailsDataAutomation(
        defaultCustomText: json["defaultCustomText"] == null
            ? null
            : json["defaultCustomText"],
        backgroundUrl:
            json["backgroundUrl"] == null ? null : json["backgroundUrl"],
        businessCards: json["businessCards"] == null
            ? null
            : List<BusinessCardAutomation>.from(json["businessCards"]
                .map((x) => BusinessCardAutomation.fromMap(x))),
        banner: json["banner"] == null
            ? null
            : List<BannerAutomation>.from(
                json["banner"].map((x) => BannerAutomation.fromMap(x))),
        popups: json["popups"] == null
            ? null
            : List<PopupAutomation>.from(
                json["popups"].map((x) => PopupAutomation.fromMap(x))),
        promotions: json["promotions"] == null
            ? null
            : List<PromotionAutomation>.from(
                json["promotions"].map((x) => PromotionAutomation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "defaultCustomText":
            defaultCustomText == null ? null : defaultCustomText,
        "backgroundUrl": backgroundUrl == null ? null : backgroundUrl,
        "businessCards": businessCards == null
            ? null
            : List<dynamic>.from(businessCards!.map((x) => x.toMap())),
        "banner": banner == null
            ? null
            : List<dynamic>.from(banner!.map((x) => x.toMap())),
        "popups": popups == null
            ? null
            : List<dynamic>.from(popups!.map((x) => x.toMap())),
        "promotions": promotions == null
            ? null
            : List<dynamic>.from(promotions!.map((x) => x.toMap())),
      };
}

class BannerAutomation {
  BannerAutomation({
    this.bannerId,
    this.type,
    this.startDate,
    this.endDate,
    this.priority,
    this.imageFilename,
    this.deeplinkUrl,
    this.deeplinkType,
    this.function,
    this.orderSection,
  });

  final String? bannerId;
  final String? type;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? priority;
  final String? imageFilename;
  final String? deeplinkUrl;
  final String? deeplinkType;
  final String? function;
  final String? orderSection;

  factory BannerAutomation.fromJson(String str) =>
      BannerAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BannerAutomation.fromMap(Map<String, dynamic> json) =>
      BannerAutomation(
        bannerId: json["bannerId"] == null ? null : json["bannerId"],
        type: json["type"] == null ? null : json["type"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        priority: json["priority"] == null ? null : json["priority"],
        imageFilename:
            json["imageFilename"] == null ? null : json["imageFilename"],
        deeplinkUrl: json["deeplinkUrl"] == null ? null : json["deeplinkUrl"],
        deeplinkType:
            json["deeplinkType"] == null ? null : json["deeplinkType"],
        function: json["function"] == null ? null : json["function"],
        orderSection:
            json["orderSection"] == null ? null : json["orderSection"],
      );

  Map<String, dynamic> toMap() => {
        "bannerId": bannerId == null ? null : bannerId,
        "type": type == null ? null : type,
        "startDate": startDate == null ? null : startDate?.toIso8601String(),
        "endDate": endDate == null ? null : endDate?.toIso8601String(),
        "priority": priority == null ? null : priority,
        "imageFilename": imageFilename == null ? null : imageFilename,
        "deeplinkUrl": deeplinkUrl == null ? null : deeplinkUrl,
        "deeplinkType": deeplinkType == null ? null : deeplinkType,
        "function": function == null ? null : function,
        "orderSection": orderSection == null ? null : orderSection,
      };
}

class BusinessCardAutomation {
  BusinessCardAutomation({
    this.serviceText,
    this.title,
    this.description,
    this.imageUrl,
    this.largeImageUrl,
    this.serviceBackgroundUrl,
    this.sortSeq,
    this.service,
    this.deeplinkUrl,
  });

  final String? serviceText;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? largeImageUrl;
  final String? serviceBackgroundUrl;
  final String? sortSeq;
  final String? service;
  final String? deeplinkUrl;

  factory BusinessCardAutomation.fromJson(String str) =>
      BusinessCardAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessCardAutomation.fromMap(Map<String, dynamic> json) =>
      BusinessCardAutomation(
        serviceText: json["serviceText"] == null ? null : json["serviceText"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        largeImageUrl:
            json["largeImageUrl"] == null ? null : json["largeImageUrl"],
        serviceBackgroundUrl: json["serviceBackgroundUrl"] == null
            ? null
            : json["serviceBackgroundUrl"],
        sortSeq: json["sortSeq"] == null ? null : json["sortSeq"],
        service: json["service"] == null ? null : json["service"],
        deeplinkUrl: json["deeplinkUrl"] == null ? null : json["deeplinkUrl"],
      );

  Map<String, dynamic> toMap() => {
        "serviceText": serviceText == null ? null : serviceText,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "largeImageUrl": largeImageUrl == null ? null : largeImageUrl,
        "serviceBackgroundUrl":
            serviceBackgroundUrl == null ? null : serviceBackgroundUrl,
        "sortSeq": sortSeq == null ? null : sortSeq,
        "service": service == null ? null : service,
        "deeplinkUrl": deeplinkUrl == null ? null : deeplinkUrl,
      };
}

class PopupAutomation {
  PopupAutomation({
    this.popupId,
    this.type,
    this.startDate,
    this.endDate,
    this.priority,
    this.imageFilename,
    this.deeplinkUrl,
    this.deeplinkType,
    this.function,
    this.orderSection,
  });

  final String? popupId;
  final String? type;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? priority;
  final String? imageFilename;
  final String? deeplinkUrl;
  final String? deeplinkType;
  final String? function;
  final String? orderSection;

  factory PopupAutomation.fromJson(String str) =>
      PopupAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PopupAutomation.fromMap(Map<String, dynamic> json) => PopupAutomation(
        popupId: json["popupId"] == null ? null : json["popupId"],
        type: json["type"] == null ? null : json["type"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        priority: json["priority"] == null ? null : json["priority"],
        imageFilename:
            json["imageFilename"] == null ? null : json["imageFilename"],
        deeplinkUrl: json["deeplinkUrl"] == null ? null : json["deeplinkUrl"],
        deeplinkType:
            json["deeplinkType"] == null ? null : json["deeplinkType"],
        function: json["function"] == null ? null : json["function"],
        orderSection:
            json["orderSection"] == null ? null : json["orderSection"],
      );

  Map<String, dynamic> toMap() => {
        "popupId": popupId == null ? null : popupId,
        "type": type == null ? null : type,
        "startDate": startDate == null ? null : startDate?.toIso8601String(),
        "endDate": endDate == null ? null : endDate?.toIso8601String(),
        "priority": priority == null ? null : priority,
        "imageFilename": imageFilename == null ? null : imageFilename,
        "deeplinkUrl": deeplinkUrl == null ? null : deeplinkUrl,
        "deeplinkType": deeplinkType == null ? null : deeplinkType,
        "function": function == null ? null : function,
        "orderSection": orderSection == null ? null : orderSection,
      };
}

class PromotionAutomation {
  PromotionAutomation({
    this.hotelId,
    this.promotionText,
  });

  final String? hotelId;
  final String? promotionText;

  factory PromotionAutomation.fromJson(String str) =>
      PromotionAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PromotionAutomation.fromMap(Map<String, dynamic> json) =>
      PromotionAutomation(
        hotelId: json["hotelId"] == null ? null : json["hotelId"],
        promotionText:
            json["promotionText"] == null ? null : json["promotionText"],
      );

  Map<String, dynamic> toMap() => {
        "hotelId": hotelId == null ? null : hotelId,
        "promotionText": promotionText == null ? null : promotionText,
      };
}

class StatusAutomation {
  StatusAutomation({
    this.code,
    this.header,
    this.description,
  });

  final String? code;
  final String? header;
  final String? description;

  factory StatusAutomation.fromJson(String str) =>
      StatusAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatusAutomation.fromMap(Map<String, dynamic> json) =>
      StatusAutomation(
        code: json["code"] == null ? null : json["code"],
        header: json["header"] == null ? null : json["header"],
        description: json["description"] == null ? null : json["description"],
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "header": header == null ? null : header,
        "description": description == null ? null : description,
      };
}
