import 'dart:convert';

class SearchRecommendationModel {
  SearchRecommendationModel({
    this.getSearchRecommendation,
  });

  final GetSearchRecommendation? getSearchRecommendation;

  factory SearchRecommendationModel.fromJson(String str) =>
      SearchRecommendationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchRecommendationModel.fromMap(Map<String, dynamic> json) =>
      SearchRecommendationModel(
        getSearchRecommendation: json["getSearchRecommendation"] == null
            ? null
            : GetSearchRecommendation.fromMap(json["getSearchRecommendation"]),
      );

  Map<String, dynamic> toMap() => {
        "getSearchRecommendation": getSearchRecommendation?.toMap(),
      };
}

class GetSearchRecommendation {
  GetSearchRecommendation({
    this.data,
    this.status,
  });

  final GetSearchRecommendationData? data;
  final Status? status;

  factory GetSearchRecommendation.fromJson(String str) =>
      GetSearchRecommendation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetSearchRecommendation.fromMap(Map<String, dynamic> json) =>
      GetSearchRecommendation(
        data: json["data"] == null
            ? null
            : GetSearchRecommendationData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class GetSearchRecommendationData {
  GetSearchRecommendationData({
    this.recommendationKey,
    this.recommendations,
    this.searchHistory,
  });

  final String? recommendationKey;
  final List<Recommendation>? recommendations;
  final List<SearchHistory>? searchHistory;

  factory GetSearchRecommendationData.fromJson(String str) =>
      GetSearchRecommendationData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetSearchRecommendationData.fromMap(Map<String, dynamic> json) =>
      GetSearchRecommendationData(
        recommendationKey: json["recommendationKey"],
        recommendations: json["recommendations"] == null
            ? null
            : List<Recommendation>.from(
                json["recommendations"].map((x) => Recommendation.fromMap(x))),
        searchHistory: json["searchHistory"] == null
            ? null
            : List<SearchHistory>.from(
                json["searchHistory"].map((x) => SearchHistory.fromMap(x))),
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

class Recommendation {
  Recommendation({
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

  factory Recommendation.fromJson(String str) =>
      Recommendation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Recommendation.fromMap(Map<String, dynamic> json) => Recommendation(
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

class SearchHistory {
  SearchHistory({
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

  factory SearchHistory.fromJson(String str) =>
      SearchHistory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchHistory.fromMap(Map<String, dynamic> json) => SearchHistory(
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
