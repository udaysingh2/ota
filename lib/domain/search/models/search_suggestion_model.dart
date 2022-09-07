import 'dart:convert';

class SearchSuggestionModel {
  SearchSuggestionModel({
    this.getDataScienceAutoCompleteSearch,
  });

  final GetDataScienceAutoCompleteSearch? getDataScienceAutoCompleteSearch;

  factory SearchSuggestionModel.fromJson(String str) =>
      SearchSuggestionModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchSuggestionModel.fromMap(Map<String, dynamic> json) =>
      SearchSuggestionModel(
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
    this.data,
    this.status,
  });

  final GetDataScienceAutoCompleteSearchData? data;
  final Status? status;

  factory GetDataScienceAutoCompleteSearch.fromJson(String str) =>
      GetDataScienceAutoCompleteSearch.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetDataScienceAutoCompleteSearch.fromMap(Map<String, dynamic> json) =>
      GetDataScienceAutoCompleteSearch(
        data: json["data"] == null
            ? null
            : GetDataScienceAutoCompleteSearchData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
        "status": status == null ? null : status!.toMap(),
      };
}

class GetDataScienceAutoCompleteSearchData {
  GetDataScienceAutoCompleteSearchData({
    this.suggestions,
  });

  final Suggestions? suggestions;

  factory GetDataScienceAutoCompleteSearchData.fromJson(String str) =>
      GetDataScienceAutoCompleteSearchData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetDataScienceAutoCompleteSearchData.fromMap(
          Map<String, dynamic> json) =>
      GetDataScienceAutoCompleteSearchData(
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
    this.hotel,
  });

  final List<City>? tour;
  final List<City>? ticket;
  final List<City>? city;
  final List<City>? cityLocation;
  final List<City>? location;
  final List<Hotel>? hotel;

  factory Suggestions.fromJson(String str) =>
      Suggestions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Suggestions.fromMap(Map<String, dynamic> json) => Suggestions(
        tour: json["tour"] == null
            ? null
            : List<City>.from(json["tour"].map((x) => City.fromMap(x))),
        ticket: json["ticket"] == null
            ? null
            : List<City>.from(json["ticket"].map((x) => City.fromMap(x))),
        city: json["city"] == null
            ? null
            : List<City>.from(json["city"].map((x) => City.fromMap(x))),
        cityLocation: json["cityLocation"] == null
            ? null
            : List<City>.from(json["cityLocation"].map((x) => City.fromMap(x))),
        location: json["location"] == null
            ? null
            : List<City>.from(json["location"].map((x) => City.fromMap(x))),
        hotel: json["hotel"] == null
            ? null
            : List<Hotel>.from(json["hotel"].map((x) => Hotel.fromMap(x))),
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
        "hotel": hotel == null
            ? null
            : List<dynamic>.from(hotel!.map((x) => x.toMap())),
      };
}

class City {
  City({
    this.keyword,
    this.id,
    this.locationName,
    this.cityId,
    this.cityName,
    this.countryId,
  });

  final String? keyword;
  final String? id;
  final String? locationName;
  final String? cityId;
  final String? cityName;
  final String? countryId;

  factory City.fromJson(String str) => City.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory City.fromMap(Map<String, dynamic> json) => City(
        keyword: json["keyword"],
        id: json["id"],
        locationName: json["locationName"],
        cityId: json["cityId"],
        cityName: json["cityName"],
        countryId: json["countryId"],
      );

  Map<String, dynamic> toMap() => {
        "keyword": keyword,
        "id": id,
        "locationName": locationName,
        "cityId": cityId,
        "cityName": cityName,
        "countryId": countryId,
      };
}

class Hotel {
  Hotel({
    this.cityId,
    this.displayText,
    this.hotelId,
    this.countryId,
    this.hotelName,
    this.locationId,
  });

  final String? cityId;
  final String? displayText;
  final String? hotelId;
  final String? countryId;
  final String? hotelName;
  final String? locationId;

  factory Hotel.fromJson(String str) => Hotel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Hotel.fromMap(Map<String, dynamic> json) => Hotel(
        cityId: json["cityId"],
        displayText: json["displayText"],
        hotelId: json["hotelId"],
        countryId: json["countryId"],
        hotelName: json["hotelName"],
        locationId: json["locationId"],
      );

  Map<String, dynamic> toMap() => {
        "cityId": cityId,
        "displayText": displayText,
        "hotelId": hotelId,
        "countryId": countryId,
        "hotelName": hotelName,
        "locationId": locationId,
      };
}

class Status {
  Status({
    this.code,
    this.header,
    this.description,
    this.errors,
  });

  final String? code;
  final String? header;
  final String? description;
  final String? errors;

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        header: json["header"],
        description: json["description"],
        errors: json["errors"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "header": header,
        "description": description,
        "errors": errors,
      };
}
