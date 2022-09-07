import 'dart:convert';

class SearchRecommendationModelAutomation {
  SearchRecommendationModelAutomation({
    this.getSearchRecommendation,
  });

  final GetSearchRecommendationAutomation? getSearchRecommendation;

  factory SearchRecommendationModelAutomation.fromJson(String str) =>
      SearchRecommendationModelAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchRecommendationModelAutomation.fromMap(
          Map<String, dynamic> json) =>
      SearchRecommendationModelAutomation(
        getSearchRecommendation: json["getSearchRecommendation"] == null
            ? null
            : GetSearchRecommendationAutomation.fromMap(
                json["getSearchRecommendation"]),
      );

  Map<String, dynamic> toMap() => {
        "getSearchRecommendation": getSearchRecommendation == null
            ? null
            : getSearchRecommendation?.toMap(),
      };
}

class GetSearchRecommendationAutomation {
  GetSearchRecommendationAutomation({
    this.data,
    this.status,
  });

  final GetSearchRecommendationDataAutomation? data;
  final StatusAutomation? status;

  factory GetSearchRecommendationAutomation.fromJson(String str) =>
      GetSearchRecommendationAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetSearchRecommendationAutomation.fromMap(
          Map<String, dynamic> json) =>
      GetSearchRecommendationAutomation(
        data: json["data"] == null
            ? null
            : GetSearchRecommendationDataAutomation.fromMap(json["data"]),
        status: json["status"] == null
            ? null
            : StatusAutomation.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data?.toMap(),
        "status": status == null ? null : status?.toMap(),
      };
}

class GetSearchRecommendationDataAutomation {
  GetSearchRecommendationDataAutomation({
    this.recommendationKey,
    this.recommendations,
  });

  final String? recommendationKey;
  final List<RecommendationAutomation>? recommendations;

  factory GetSearchRecommendationDataAutomation.fromJson(String str) =>
      GetSearchRecommendationDataAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetSearchRecommendationDataAutomation.fromMap(
          Map<String, dynamic> json) =>
      GetSearchRecommendationDataAutomation(
        recommendationKey: json["recommendationKey"] == null
            ? null
            : json["recommendationKey"],
        recommendations: json["recommendations"] == null
            ? null
            : List<RecommendationAutomation>.from(json["recommendations"]
                .map((x) => RecommendationAutomation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "recommendationKey":
            recommendationKey == null ? null : recommendationKey,
        "recommendations": recommendations == null
            ? null
            : List<dynamic>.from(recommendations!.map((x) => x.toMap())),
      };
}

class RecommendationAutomation {
  RecommendationAutomation({
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

  factory RecommendationAutomation.fromJson(String str) =>
      RecommendationAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecommendationAutomation.fromMap(Map<String, dynamic> json) =>
      RecommendationAutomation(
        playlistId: json["playlistId"] == null ? null : json["playlistId"],
        serviceTitle:
            json["serviceTitle"] == null ? null : json["serviceTitle"],
        hotelId: json["hotelId"] == null ? null : json["hotelId"],
        cityId: json["cityId"] == null ? null : json["cityId"],
        countryId: json["countryId"] == null ? null : json["countryId"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
      );

  Map<String, dynamic> toMap() => {
        "playlistId": playlistId == null ? null : playlistId,
        "serviceTitle": serviceTitle == null ? null : serviceTitle,
        "hotelId": hotelId == null ? null : hotelId,
        "cityId": cityId == null ? null : cityId,
        "countryId": countryId == null ? null : countryId,
        "imageUrl": imageUrl == null ? null : imageUrl,
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
