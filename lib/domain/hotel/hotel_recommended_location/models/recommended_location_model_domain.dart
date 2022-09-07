// To parse this JSON data, do
//
//     final recommendedLocationModelDomain = recommendedLocationModelDomainFromMap(jsonString);

import 'dart:convert';

class RecommendedLocationModelDomain {
  RecommendedLocationModelDomain({
    this.getRecommendedLocation,
  });

  final GetRecommendedLocation? getRecommendedLocation;

  factory RecommendedLocationModelDomain.fromJson(String str) =>
      RecommendedLocationModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecommendedLocationModelDomain.fromMap(Map<String, dynamic> json) =>
      RecommendedLocationModelDomain(
        getRecommendedLocation: json["getRecommendedLocation"] == null
            ? null
            : GetRecommendedLocation.fromMap(json["getRecommendedLocation"]),
      );

  Map<String, dynamic> toMap() => {
        "getRecommendedLocation": getRecommendedLocation == null
            ? null
            : getRecommendedLocation!.toMap(),
      };
}

class GetRecommendedLocation {
  GetRecommendedLocation({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetRecommendedLocation.fromJson(String str) =>
      GetRecommendedLocation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetRecommendedLocation.fromMap(Map<String, dynamic> json) =>
      GetRecommendedLocation(
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
    this.locationList,
  });

  final List<LocationList>? locationList;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        locationList: json["locationList"] == null
            ? null
            : List<LocationList>.from(
                json["locationList"].map((x) => LocationList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "locationList": locationList == null
            ? null
            : List<dynamic>.from(locationList!.map((x) => x.toMap())),
      };
}

class LocationList {
  LocationList({
    this.playlistId,
    this.searchKey,
    this.serviceTitle,
    this.hotelId,
    this.imageUrl,
    this.countryId,
    this.cityId,
  });

  final String? playlistId;
  final String? searchKey;
  final String? serviceTitle;
  final String? hotelId;
  final String? imageUrl;
  final String? countryId;
  final String? cityId;

  factory LocationList.fromJson(String str) =>
      LocationList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LocationList.fromMap(Map<String, dynamic> json) => LocationList(
        playlistId: json["playlistId"],
        searchKey: json["searchKey"],
        serviceTitle: json["serviceTitle"],
        hotelId: json["hotelId"],
        imageUrl: json["imageUrl"],
        countryId: json["countryId"],
        cityId: json["cityId"],
      );

  Map<String, dynamic> toMap() => {
        "playlistId": playlistId,
        "searchKey": searchKey,
        "serviceTitle": serviceTitle,
        "hotelId": hotelId,
        "imageUrl": imageUrl,
        "countryId": countryId,
        "cityId": cityId,
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
  final dynamic description;

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
