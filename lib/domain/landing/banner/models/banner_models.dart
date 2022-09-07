// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromMap(jsonString);

import 'dart:convert';

class LandingBannerModelDomain {
  LandingBannerModelDomain({
    this.getBanners,
  });

  final GetBanners? getBanners;

  factory LandingBannerModelDomain.fromJson(String str) =>
      LandingBannerModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LandingBannerModelDomain.fromMap(Map<String, dynamic> json) => LandingBannerModelDomain(
        getBanners: json["getBanners"] == null
            ? null
            : GetBanners.fromMap(json["getBanners"]),
      );

  Map<String, dynamic> toMap() => {
        "getBanners": getBanners?.toMap(),
      };
}

class GetBanners {
  GetBanners({
    this.data,
    this.status,
  });

  final GetBannersData? data;
  final Status? status;

  factory GetBanners.fromJson(String str) =>
      GetBanners.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetBanners.fromMap(Map<String, dynamic> json) => GetBanners(
        data:
            json["data"] == null ? null : GetBannersData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class GetBannersData {
  GetBannersData({
    this.banner,
  });

  final List<Banner>? banner;

  factory GetBannersData.fromJson(String str) =>
      GetBannersData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetBannersData.fromMap(Map<String, dynamic> json) => GetBannersData(
        banner: json["banner"] == null
            ? null
            : List<Banner>.from(json["banner"].map((x) => Banner.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "banner": banner == null
            ? null
            : List<dynamic>.from(banner!.map((x) => x.toMap())),
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

class Status {
  Status({
    this.code,
    this.description,
    this.header,
  });

  final String? code;
  final String? description;
  final String? header;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        description: json["description"],
        header: json["header"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "description": description,
        "header": header,
      };
}
