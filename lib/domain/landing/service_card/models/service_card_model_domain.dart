// To parse this JSON data, do
//
//     final serviceCardModelDomain = serviceCardModelDomainFromMap(jsonString);

import 'dart:convert';

class ServiceCardModelDomain {
  ServiceCardModelDomain({
    this.data,
  });

  final ServiceCardModelDomainData? data;

  factory ServiceCardModelDomain.fromJson(String str) =>
      ServiceCardModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceCardModelDomain.fromMap(Map<String, dynamic> json) =>
      ServiceCardModelDomain(
        data: json["data"] == null
            ? null
            : ServiceCardModelDomainData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data ?? data?.toMap(),
      };
}

class ServiceCardModelDomainData {
  ServiceCardModelDomainData({
    this.getServiceCard,
  });

  final GetServiceCard? getServiceCard;

  factory ServiceCardModelDomainData.fromJson(String str) =>
      ServiceCardModelDomainData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServiceCardModelDomainData.fromMap(Map<String, dynamic> json) =>
      ServiceCardModelDomainData(
        getServiceCard: json["getServiceCard"] == null
            ? null
            : GetServiceCard.fromMap(json["getServiceCard"]),
      );

  Map<String, dynamic> toMap() => {
        "getServiceCard": getServiceCard ?? getServiceCard?.toMap(),
      };
}

class GetServiceCard {
  GetServiceCard({
    this.data,
    this.status,
  });

  final GetServiceCardData? data;
  final Status? status;

  factory GetServiceCard.fromJson(String str) =>
      GetServiceCard.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetServiceCard.fromMap(Map<String, dynamic> json) => GetServiceCard(
        data: json["data"] == null
            ? null
            : GetServiceCardData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data ?? data?.toMap(),
        "status": status ?? status?.toMap(),
      };
}

class GetServiceCardData {
  GetServiceCardData({
    this.defaultCustomText,
    this.backgroundUrl,
    this.businessCards,
  });

  final String? defaultCustomText;
  final String? backgroundUrl;
  final List<BusinessCard>? businessCards;

  factory GetServiceCardData.fromJson(String str) =>
      GetServiceCardData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetServiceCardData.fromMap(Map<String, dynamic> json) =>
      GetServiceCardData(
        defaultCustomText:
            json["defaultCustomText"] ?? json["defaultCustomText"],
        backgroundUrl: json["backgroundUrl"] ?? json["backgroundUrl"],
        businessCards: json["businessCards"] == null
            ? null
            : List<BusinessCard>.from(
                json["businessCards"].map((x) => BusinessCard.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "defaultCustomText": defaultCustomText ?? defaultCustomText,
        "backgroundUrl": backgroundUrl ?? backgroundUrl,
        "businessCards": businessCards == null
            ? null
            : List<dynamic>.from(businessCards!.map((x) => x.toMap())),
      };
}

class BusinessCard {
  BusinessCard({
    this.title,
    this.serviceText,
    this.description,
    this.imageUrl,
    this.largeImageUrl,
    this.serviceBackgroundUrl,
    this.sortSeq,
    this.service,
    this.deeplinkUrl,
  });

  final String? title;
  final String? serviceText;
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
        title: json["title"] ?? json["title"],
        serviceText: json["serviceText"] ?? json["serviceText"],
        description: json["description"] ?? json["description"],
        imageUrl: json["imageUrl"] ?? json["imageUrl"],
        largeImageUrl: json["largeImageUrl"] ?? json["largeImageUrl"],
        serviceBackgroundUrl:
            json["serviceBackgroundUrl"] ?? json["serviceBackgroundUrl"],
        sortSeq: json["sortSeq"] ?? json["sortSeq"],
        service: json["service"] ?? json["service"],
        deeplinkUrl: json["deeplinkUrl"] ?? json["deeplinkUrl"],
      );

  Map<String, dynamic> toMap() => {
        "title": title ?? title,
        "serviceText": serviceText ?? serviceText,
        "description": description ?? description,
        "imageUrl": imageUrl ?? imageUrl,
        "largeImageUrl": largeImageUrl ?? largeImageUrl,
        "serviceBackgroundUrl": serviceBackgroundUrl ?? serviceBackgroundUrl,
        "sortSeq": sortSeq ?? sortSeq,
        "service": service ?? service,
        "deeplinkUrl": deeplinkUrl ?? deeplinkUrl,
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
        code: json["code"] ?? json["code"],
        header: json["header"] ?? json["header"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "code": code ?? code,
        "header": header ?? header,
        "description": description,
      };
}
