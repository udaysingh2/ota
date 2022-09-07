import 'dart:convert';

class TourAttractionsModelDomain {
  TourAttractionsModelDomain({
    this.getTourServiceSuggestions,
  });

  final GetTourServiceSuggestions? getTourServiceSuggestions;

  factory TourAttractionsModelDomain.fromJson(String str) =>
      TourAttractionsModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TourAttractionsModelDomain.fromMap(Map<String, dynamic> json) =>
      TourAttractionsModelDomain(
        getTourServiceSuggestions: json["getTourServiceSuggestions"] == null
            ? null
            : GetTourServiceSuggestions.fromMap(
                json["getTourServiceSuggestions"]),
      );

  Map<String, dynamic> toMap() => {
        "getTourServiceSuggestions": getTourServiceSuggestions == null
            ? null
            : getTourServiceSuggestions!.toMap(),
      };
}

class GetTourServiceSuggestions {
  GetTourServiceSuggestions({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetTourServiceSuggestions.fromJson(String str) =>
      GetTourServiceSuggestions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetTourServiceSuggestions.fromMap(Map<String, dynamic> json) =>
      GetTourServiceSuggestions(
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
    this.serviceTitle,
    this.searchKey,
    this.imageUrl,
    this.cityId,
    this.countryId,
  });

  final String? serviceTitle;
  final String? searchKey;
  final String? imageUrl;
  final String? cityId;
  final String? countryId;

  factory LocationList.fromJson(String str) =>
      LocationList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LocationList.fromMap(Map<String, dynamic> json) => LocationList(
        serviceTitle: json["serviceTitle"],
        searchKey: json["searchKey"],
        imageUrl: json["imageUrl"],
        cityId: json["cityId"],
        countryId: json["imageUrl"] == null ? null : json["countryId"],
      );

  Map<String, dynamic> toMap() => {
        "serviceTitle": serviceTitle,
        "searchKey": searchKey,
        "imageUrl": imageUrl,
        "cityId": cityId,
        "countryId": countryId,
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
