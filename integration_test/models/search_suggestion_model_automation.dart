import 'dart:convert';

class SearchSuggestionModelAutomation {
  SearchSuggestionModelAutomation({
    this.getSearchSuggestion,
  });

  final GetSearchSuggestionAutomation? getSearchSuggestion;

  factory SearchSuggestionModelAutomation.fromJson(String str) =>
      SearchSuggestionModelAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SearchSuggestionModelAutomation.fromMap(Map<String, dynamic> json) =>
      SearchSuggestionModelAutomation(
        getSearchSuggestion: json["getSearchSuggestion"] == null
            ? null
            : GetSearchSuggestionAutomation.fromMap(
                json["getSearchSuggestion"]),
      );

  Map<String, dynamic> toMap() => {
        "getSearchSuggestion":
            getSearchSuggestion == null ? null : getSearchSuggestion!.toMap(),
      };
}

class GetSearchSuggestionAutomation {
  GetSearchSuggestionAutomation({
    this.data,
  });

  final DataAutomation? data;

  factory GetSearchSuggestionAutomation.fromJson(String str) =>
      GetSearchSuggestionAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetSearchSuggestionAutomation.fromMap(Map<String, dynamic> json) =>
      GetSearchSuggestionAutomation(
        data:
            json["data"] == null ? null : DataAutomation.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
      };
}

class DataAutomation {
  DataAutomation({
    this.suggestions,
  });

  final List<SuggestionAutomation>? suggestions;

  factory DataAutomation.fromJson(String str) =>
      DataAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataAutomation.fromMap(Map<String, dynamic> json) => DataAutomation(
        suggestions: json["suggestions"] == null
            ? null
            : List<SuggestionAutomation>.from(json["suggestions"]
                .map((x) => SuggestionAutomation.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "suggestions": suggestions == null
            ? null
            : List<dynamic>.from(suggestions!.map((x) => x.toMap())),
      };
}

class SuggestionAutomation {
  SuggestionAutomation({
    this.hotelId,
    this.hotelName,
    this.cityId,
    this.cityName,
    this.countryId,
    this.countryName,
    this.locationId,
    this.locationName,
    this.level,
    this.searchid,
    this.filterName,
  });

  final String? hotelId;
  final String? hotelName;
  final String? cityId;
  final String? cityName;
  final String? countryId;
  final String? countryName;
  final String? locationId;
  final String? locationName;
  final int? level;
  final String? searchid;
  final String? filterName;

  factory SuggestionAutomation.fromJson(String str) =>
      SuggestionAutomation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SuggestionAutomation.fromMap(Map<String, dynamic> json) =>
      SuggestionAutomation(
        hotelId: json["hotelId"] == null ? null : json["hotelId"],
        hotelName: json["hotelName"] == null ? null : json["hotelName"],
        cityId: json["cityId"] == null ? null : json["cityId"],
        cityName: json["cityName"] == null ? null : json["cityName"],
        countryId: json["countryId"] == null ? null : json["countryId"],
        countryName: json["countryName"] == null ? null : json["countryName"],
        locationId: json["locationId"] == null ? null : json["locationId"],
        locationName:
            json["locationName"] == null ? null : json["locationName"],
        level: json["level"] == null ? null : json["level"],
        searchid: json["searchid"] == null ? null : json["searchid"],
        filterName: json["filterName"] == null ? null : json["filterName"],
      );

  Map<String, dynamic> toMap() => {
        "hotelId": hotelId == null ? null : hotelId,
        "hotelName": hotelName == null ? null : hotelName,
        "cityId": cityId == null ? null : cityId,
        "cityName": cityName == null ? null : cityName,
        "countryId": countryId == null ? null : countryId,
        "countryName": countryName == null ? null : countryName,
        "locationId": locationId == null ? null : locationId,
        "locationName": locationName == null ? null : locationName,
        "level": level == null ? null : level,
        "searchid": searchid == null ? null : searchid,
        "filterName": filterName == null ? null : filterName,
      };
}
