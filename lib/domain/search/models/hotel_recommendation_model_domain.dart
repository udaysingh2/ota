// To parse this JSON data, do
//
//     final hotelRecommendationModelDomain = hotelRecommendationModelDomainFromMap(jsonString);

import 'dart:convert';

class HotelRecommendationModelDomain {
  HotelRecommendationModelDomain({
    required this.getHotelSearchRecommendation,
  });

  final GetHotelSearchRecommendation? getHotelSearchRecommendation;

  factory HotelRecommendationModelDomain.fromJson(String str) =>
      HotelRecommendationModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelRecommendationModelDomain.fromMap(Map<String, dynamic> json) =>
      HotelRecommendationModelDomain(
        getHotelSearchRecommendation:
            json["getHotelSearchRecommendation"] == null
                ? null
                : GetHotelSearchRecommendation.fromMap(
                    json["getHotelSearchRecommendation"]),
      );

  Map<String, dynamic> toMap() => {
        "getHotelSearchRecommendation": getHotelSearchRecommendation == null
            ? null
            : getHotelSearchRecommendation!.toMap(),
      };
}

class GetHotelSearchRecommendation {
  GetHotelSearchRecommendation({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetHotelSearchRecommendation.fromJson(String str) =>
      GetHotelSearchRecommendation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetHotelSearchRecommendation.fromMap(Map<String, dynamic> json) =>
      GetHotelSearchRecommendation(
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
    this.recommendationKey,
    this.recommendations,
    this.searchHistory,
  });

  final String? recommendationKey;
  final List<HotelRecommendation>? recommendations;
  final List<HotelSearchHistory>? searchHistory;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        recommendationKey: json["recommendationKey"],
        recommendations: json["recommendations"] == null
            ? null
            : List<HotelRecommendation>.from(json["recommendations"]
                .map((x) => HotelRecommendation.fromMap(x))),
        searchHistory: json["searchHistory"] == null
            ? null
            : List<HotelSearchHistory>.from(json["searchHistory"]
                .map((x) => HotelSearchHistory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "recommendationKey": recommendationKey,
        "recommendations": recommendations == null
            ? null
            : List<dynamic>.from(recommendations!.map((x) => x.toMap())),
        "searchHistory": searchHistory == null
            ? null
            : List<dynamic>.from(searchHistory!.map((x) => x.toMap())),
      };
}

class HotelSearchHistory {
  HotelSearchHistory({
    this.keyword,
    this.checkInDate,
    this.checkOutDate,
    this.hotelId,
    this.cityId,
    this.countryId,
    this.locationId,
  });

  final String? keyword;
  final String? checkInDate;
  final String? checkOutDate;
  final String? hotelId;
  final String? cityId;
  final String? countryId;
  final String? locationId;

  factory HotelSearchHistory.fromJson(String str) =>
      HotelSearchHistory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelSearchHistory.fromMap(Map<String, dynamic> json) =>
      HotelSearchHistory(
          keyword: json["keyword"],
          checkInDate: json["checkInDate"],
          checkOutDate: json["checkOutDate"],
          hotelId: json["hotelId"],
          cityId: json["cityId"],
          countryId: json["countryId"],
          locationId: json["locationId"]);

  Map<String, dynamic> toMap() => {
        "keyword": keyword,
        "checkInDate": checkInDate,
        "checkOutDate": checkOutDate,
        "hotelId": hotelId,
        "cityId": cityId,
        "countryId": countryId,
        "locationId": locationId,
      };
}

class HotelRecommendation {
  HotelRecommendation({
    this.playlistId,
    this.serviceTitle,
    this.hotelId,
    this.cityId,
    this.countryId,
    this.imageUrl,
  });

  final String? playlistId;
  final String? serviceTitle;
  final String? hotelId;
  final String? cityId;
  final String? countryId;
  final String? imageUrl;

  factory HotelRecommendation.fromJson(String str) =>
      HotelRecommendation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelRecommendation.fromMap(Map<String, dynamic> json) =>
      HotelRecommendation(
        playlistId: json["playlistId"],
        serviceTitle: json["serviceTitle"],
        hotelId: json["hotelId"],
        cityId: json["cityId"],
        countryId: json["countryId"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toMap() => {
        "playlistId": playlistId,
        "serviceTitle": serviceTitle,
        "hotelId": hotelId,
        "cityId": cityId,
        "countryId": countryId,
        "imageUrl": imageUrl,
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
