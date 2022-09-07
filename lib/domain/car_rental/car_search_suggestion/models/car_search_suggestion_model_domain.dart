// To parse this JSON data, do
//
//     final carSearchSuggestionData = carSearchSuggestionDataFromMap(jsonString);

import 'dart:convert';

class CarSearchSuggestionData {
  CarSearchSuggestionData({
    this.getDataScienceAutoCompleteSearch,
  });

  final GetDataScienceAutoCompleteSearch? getDataScienceAutoCompleteSearch;

  factory CarSearchSuggestionData.fromJson(String str) =>
      CarSearchSuggestionData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarSearchSuggestionData.fromMap(Map<String, dynamic> json) =>
      CarSearchSuggestionData(
        getDataScienceAutoCompleteSearch:
            json["getDataScienceAutoCompleteSearch"] == null
                ? null
                : GetDataScienceAutoCompleteSearch.fromMap(
                    json["getDataScienceAutoCompleteSearch"]),
      );

  Map<String, dynamic> toMap() => {
        "getDataScienceAutoCompleteSearch":
            getDataScienceAutoCompleteSearch == null
                ? null
                : getDataScienceAutoCompleteSearch!.toMap(),
      };
}

class GetDataScienceAutoCompleteSearch {
  GetDataScienceAutoCompleteSearch({
    this.status,
    this.data,
  });

  final Status? status;
  final Data? data;

  factory GetDataScienceAutoCompleteSearch.fromJson(String str) =>
      GetDataScienceAutoCompleteSearch.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetDataScienceAutoCompleteSearch.fromMap(Map<String, dynamic> json) =>
      GetDataScienceAutoCompleteSearch(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status!.toMap(),
        "data": data == null ? null : data!.toMap(),
      };
}

class Data {
  Data({
    this.suggestions,
  });

  final Suggestions? suggestions;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        suggestions: json["suggestions"] == null
            ? null
            : Suggestions.fromMap(json["suggestions"]),
      );

  Map<String, dynamic> toMap() => {
        "suggestions": suggestions == null ? null : suggestions!.toMap(),
      };
}

class Suggestions {
  Suggestions({
    this.tour,
    this.ticket,
    this.city,
    this.cityLocation,
    this.location,
  });

  final List<CityLocation>? tour;
  final List<CityLocation>? ticket;
  final List<City>? city;
  final List<CityLocation>? cityLocation;
  final List<CityLocation>? location;

  factory Suggestions.fromJson(String str) =>
      Suggestions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Suggestions.fromMap(Map<String, dynamic> json) => Suggestions(
        tour: json["tour"] == null
            ? null
            : List<CityLocation>.from(
                json["tour"].map((x) => CityLocation.fromMap(x))),
        ticket: json["ticket"] == null
            ? null
            : List<CityLocation>.from(
                json["ticket"].map((x) => CityLocation.fromMap(x))),
        city: json["city"] == null
            ? null
            : List<City>.from(json["city"].map((x) => City.fromMap(x))),
        cityLocation: json["cityLocation"] == null
            ? null
            : List<CityLocation>.from(
                json["cityLocation"].map((x) => CityLocation.fromMap(x))),
        location: json["location"] == null
            ? null
            : List<CityLocation>.from(
                json["location"].map((x) => CityLocation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "tour": tour == null
            ? null
            : List<dynamic>.from(tour!.map((x) => x.toMap())),
        "ticket": ticket == null
            ? null
            : List<dynamic>.from(ticket!.map((x) => x.toMap())),
        "city": city == null
            ? null
            : List<dynamic>.from(city!.map((x) => x.toMap())),
        "cityLocation": cityLocation == null
            ? null
            : List<dynamic>.from(cityLocation!.map((x) => x.toMap())),
        "location": location == null
            ? null
            : List<dynamic>.from(location!.map((x) => x.toMap())),
      };
}

class City {
  City({
    this.keyword,
    this.cityId,
    this.cityName,
    this.countryId,
  });

  final String? keyword;
  final String? cityId;
  final String? cityName;
  final String? countryId;

  factory City.fromJson(String str) => City.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory City.fromMap(Map<String, dynamic> json) => City(
        keyword: json["keyword"],
        cityId: json["cityId"],
        cityName: json["cityName"],
        countryId: json["countryId"],
      );

  Map<String, dynamic> toMap() => {
        "keyword": keyword,
        "cityId": cityId,
        "cityName": cityName,
        "countryId": countryId,
      };
}

class CityLocation {
  CityLocation({
    this.type,
    this.keyword,
    this.id,
    this.locationName,
    this.cityId,
    this.countryId,
  });

  final String? type;
  final String? keyword;
  final String? id;
  final String? locationName;
  final String? cityId;
  final String? countryId;

  factory CityLocation.fromJson(String str) =>
      CityLocation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CityLocation.fromMap(Map<String, dynamic> json) => CityLocation(
        type: json["type"],
        keyword: json["keyword"],
        id: json["id"],
        locationName: json["locationName"],
        cityId: json["cityId"],
        countryId: json["countryId"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "keyword": keyword,
        "id": id,
        "locationName": locationName,
        "cityId": cityId,
        "countryId": countryId,
      };
}

class Status {
  Status({
    this.code,
    this.header,
  });

  final String? code;
  final String? header;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        header: json["header"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "header": header,
      };
}
