// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

class LandingData {
  LandingData({
    this.getLandingPageDetails,
  });

  final GetLandingPageDetails? getLandingPageDetails;

  factory LandingData.fromJson(String str) =>
      LandingData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LandingData.fromMap(Map<String, dynamic>? json) => LandingData(
        getLandingPageDetails: json?["getLandingPageDetails"] == null
            ? null
            : GetLandingPageDetails.fromMap(json?["getLandingPageDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "getLandingPageDetails": getLandingPageDetails?.toMap(),
      };
}

class GetLandingPageDetails {
  GetLandingPageDetails({
    this.data,
    this.status,
  });

  final GetLandingPageDetailsData? data;
  final Status? status;

  factory GetLandingPageDetails.fromJson(String str) =>
      GetLandingPageDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetLandingPageDetails.fromMap(Map<String, dynamic> json) =>
      GetLandingPageDetails(
        data: json["data"] == null
            ? null
            : GetLandingPageDetailsData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class GetLandingPageDetailsData {
  GetLandingPageDetailsData({
    this.defaultCustomText,
    this.backgroundUrl,
    this.userName,
    this.businessCards,
    this.banner,
    this.popups,
    this.promotions,
    this.preferences,
  });

  final String? defaultCustomText;
  final String? backgroundUrl;
  final String? userName;
  final List<BusinessCard>? businessCards;
  final List<Banner>? banner;
  final List<Popup>? popups;
  final List<Promotion>? promotions;
  final List<Preference>? preferences;

  factory GetLandingPageDetailsData.fromJson(String str) =>
      GetLandingPageDetailsData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetLandingPageDetailsData.fromMap(Map<String, dynamic> json) =>
      GetLandingPageDetailsData(
        defaultCustomText: json["defaultCustomText"],
        backgroundUrl: json["backgroundUrl"],
        userName: json["userName"],
        businessCards: json["businessCards"] == null
            ? null
            : List<BusinessCard>.from(
                json["businessCards"].map((x) => BusinessCard.fromMap(x))),
        banner: json["banner"] == null
            ? null
            : List<Banner>.from(json["banner"].map((x) => Banner.fromMap(x))),
        popups: json["popups"] == null
            ? null
            : List<Popup>.from(json["popups"].map((x) => Popup.fromMap(x))),
        promotions: json["promotions"] == null
            ? null
            : List<Promotion>.from(
                json["promotions"].map((x) => Promotion.fromMap(x))),
        preferences: json["preferences"] == null
            ? null
            : List<Preference>.from(
                json["preferences"].map((x) => Preference.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "defaultCustomText": defaultCustomText,
        "backgroundUrl": backgroundUrl,
        "userName": userName,
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
        "preferences": preferences == null
            ? null
            : List<dynamic>.from(preferences!.map((x) => x.toMap())),
      };
}

class Banner {
  Banner({
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

  factory Banner.fromJson(String str) => Banner.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Banner.fromMap(Map<String, dynamic> json) => Banner(
        bannerId: json["bannerId"],
        type: json["type"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.tryParse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.tryParse(json["endDate"]),
        priority: json["priority"],
        imageFilename: json["imageFilename"],
        deeplinkUrl: json["deeplinkUrl"],
        deeplinkType: json["deeplinkType"],
        function: json["function"],
        orderSection: json["orderSection"],
      );

  Map<String, dynamic> toMap() => {
        "bannerId": bannerId,
        "type": type,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "priority": priority,
        "imageFilename": imageFilename,
        "deeplinkUrl": deeplinkUrl,
        "deeplinkType": deeplinkType,
        "function": function,
        "orderSection": orderSection,
      };
}

class BusinessCard {
  BusinessCard({
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

  factory BusinessCard.fromJson(String str) =>
      BusinessCard.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusinessCard.fromMap(Map<String, dynamic> json) => BusinessCard(
        serviceText: json["serviceText"],
        title: json["title"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        largeImageUrl: json["largeImageUrl"],
        serviceBackgroundUrl: json["serviceBackgroundUrl"],
        sortSeq: json["sortSeq"],
        service: json["service"],
        deeplinkUrl: json["deeplinkUrl"],
      );

  Map<String, dynamic> toMap() => {
        "serviceText": serviceText,
        "title": title,
        "description": description,
        "imageUrl": imageUrl,
        "largeImageUrl": largeImageUrl,
        "serviceBackgroundUrl": serviceBackgroundUrl,
        "sortSeq": sortSeq,
        "service": service,
        "deeplinkUrl": deeplinkUrl,
      };
}

class Preference {
  Preference({
    this.questionId,
    this.description1,
    this.description2,
    this.multiChoice,
    this.backgroundImageUrl,
    this.options,
  });

  final String? questionId;
  final String? description1;
  final String? description2;
  final bool? multiChoice;
  final String? backgroundImageUrl;
  final List<Option>? options;

  factory Preference.fromJson(String str) =>
      Preference.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Preference.fromMap(Map<String, dynamic> json) => Preference(
        questionId: json["questionId"],
        description1: json["description1"],
        description2: json["description2"],
        multiChoice: json["multiChoice"],
        backgroundImageUrl: json["backgroundImageUrl"],
        options: json["options"] == null
            ? null
            : List<Option>.from(json["options"].map((x) => Option.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "questionId": questionId,
        "description1": description1,
        "description2": description2,
        "backgroundImageUrl": backgroundImageUrl,
        "multiChoice": multiChoice,
        "options": options == null
            ? null
            : List<dynamic>.from(options!.map((x) => x.toMap())),
      };
}

class Option {
  Option({
    this.optionCode,
    this.optionDesc,
    this.imageUrl,
  });

  final String? optionCode;
  final String? optionDesc;
  final String? imageUrl;

  factory Option.fromJson(String str) => Option.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Option.fromMap(Map<String, dynamic> json) => Option(
        optionCode: json["optionCode"],
        optionDesc: json["optionDesc"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toMap() => {
        "optionCode": optionCode,
        "optionDesc": optionDesc,
        "imageUrl": imageUrl,
      };
}

class Popup {
  Popup({
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

  factory Popup.fromJson(String str) => Popup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Popup.fromMap(Map<String, dynamic> json) => Popup(
        popupId: json["popupId"],
        type: json["type"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.tryParse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.tryParse(json["endDate"]),
        priority: json["priority"],
        imageFilename: json["imageFilename"],
        deeplinkUrl: json["deeplinkUrl"],
        deeplinkType: json["deeplinkType"],
        function: json["function"],
        orderSection: json["orderSection"],
      );

  Map<String, dynamic> toMap() => {
        "popupId": popupId,
        "type": type,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "priority": priority,
        "imageFilename": imageFilename,
        "deeplinkUrl": deeplinkUrl,
        "deeplinkType": deeplinkType,
        "function": function,
        "orderSection": orderSection,
      };
}

class Promotion {
  Promotion({
    this.hotelId,
    this.promotionText,
  });

  final String? hotelId;
  final String? promotionText;

  factory Promotion.fromJson(String str) => Promotion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Promotion.fromMap(Map<String, dynamic> json) => Promotion(
        hotelId: json["hotelId"],
        promotionText: json["promotionText"],
      );

  Map<String, dynamic> toMap() => {
        "hotelId": hotelId,
        "promotionText": promotionText,
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
