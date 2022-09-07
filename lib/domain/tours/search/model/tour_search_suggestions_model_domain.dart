// To parse this JSON data, do
//
//     final tourSearchSuggestionsModelDomain = tourSearchSuggestionsModelDomainFromMap(jsonString);

import 'dart:convert';

class TourSearchSuggestionsModelDomain {
  TourSearchSuggestionsModelDomain({
    this.getDataScienceAutoCompleteSearch,
  });

  final GetTourAndTicketSearchSuggestion? getDataScienceAutoCompleteSearch;

  factory TourSearchSuggestionsModelDomain.fromJson(String str) =>
      TourSearchSuggestionsModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TourSearchSuggestionsModelDomain.fromMap(Map<String, dynamic> json) =>
      TourSearchSuggestionsModelDomain(
        getDataScienceAutoCompleteSearch:
            json["getDataScienceAutoCompleteSearch"] == null
                ? null
                : GetTourAndTicketSearchSuggestion.fromMap(
                    json["getDataScienceAutoCompleteSearch"]),
      );

  Map<String, dynamic> toMap() => {
        "getDataScienceAutoCompleteSearch":
            getDataScienceAutoCompleteSearch == null
                ? null
                : getDataScienceAutoCompleteSearch!.toMap(),
      };
}

class GetTourAndTicketSearchSuggestion {
  GetTourAndTicketSearchSuggestion({
    this.data,
    this.status,
  });

  final SuggestionsData? data;
  final Status? status;

  factory GetTourAndTicketSearchSuggestion.fromJson(String str) =>
      GetTourAndTicketSearchSuggestion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetTourAndTicketSearchSuggestion.fromMap(Map<String, dynamic> json) =>
      GetTourAndTicketSearchSuggestion(
        data:
            json["data"] == null ? null : SuggestionsData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
        "status": status == null ? null : status!.toMap(),
      };
}

class SuggestionsData {
  SuggestionsData({
    this.suggestions,
  });

  final Suggestions? suggestions;

  factory SuggestionsData.fromJson(String str) =>
      SuggestionsData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SuggestionsData.fromMap(Map<String, dynamic> json) => SuggestionsData(
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
    this.cityLocation,
  });

  final List<SuggestedItem>? tour;
  final List<SuggestedItem>? ticket;
  final List<SuggestedItem>? cityLocation;

  factory Suggestions.fromJson(String str) =>
      Suggestions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Suggestions.fromMap(Map<String, dynamic> json) => Suggestions(
        tour: json["tour"] == null
            ? null
            : List<SuggestedItem>.from(
                json["tour"].map((x) => SuggestedItem.fromMap(x))),
        ticket: json["ticket"] == null
            ? null
            : List<SuggestedItem>.from(
                json["ticket"].map((x) => SuggestedItem.fromMap(x))),
        cityLocation: json["cityLocation"] == null
            ? null
            : List<SuggestedItem>.from(
                json["cityLocation"].map((x) => SuggestedItem.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "tour": tour == null
            ? null
            : List<dynamic>.from(tour!.map((x) => x.toMap())),
        "ticket": ticket == null
            ? null
            : List<dynamic>.from(ticket!.map((x) => x.toMap())),
        "cityLocation": cityLocation == null
            ? null
            : List<dynamic>.from(cityLocation!.map((x) => x.toMap())),
      };
}

class SuggestedItem {
  SuggestedItem({
    this.keyword,
    this.countryId,
    this.cityId,
    this.id,
    this.locationName,
  });

  final String? keyword;
  final String? countryId;
  final String? cityId;
  final String? id;
  final String? locationName;

  factory SuggestedItem.fromJson(String str) =>
      SuggestedItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SuggestedItem.fromMap(Map<String, dynamic> json) => SuggestedItem(
        keyword: json["keyword"],
        countryId: json["countryId"],
        cityId: json["cityId"],
        id: json["id"],
        locationName: json["locationName"],
      );

  Map<String, dynamic> toMap() => {
        "keyword": keyword,
        "countryId": countryId,
        "cityId": cityId,
        "id": id,
        "locationName": locationName,
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
