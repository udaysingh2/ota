import 'dart:convert';

class TourRecentPlaylistModelDomain {
  TourRecentPlaylistModelDomain({
    this.getTourRecentlyViewedItems,
  });

  final GetTourRecentlyViewedItems? getTourRecentlyViewedItems;

  factory TourRecentPlaylistModelDomain.fromJson(String str) =>
      TourRecentPlaylistModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TourRecentPlaylistModelDomain.fromMap(Map<String, dynamic> json) =>
      TourRecentPlaylistModelDomain(
        getTourRecentlyViewedItems: json["getTourRecentlyViewedItems"] == null
            ? null
            : GetTourRecentlyViewedItems.fromMap(
                json["getTourRecentlyViewedItems"]),
      );

  Map<String, dynamic> toMap() => {
        "getTourRecentlyViewedItems": getTourRecentlyViewedItems?.toMap(),
      };
}

class GetTourRecentlyViewedItems {
  GetTourRecentlyViewedItems({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetTourRecentlyViewedItems.fromJson(String str) =>
      GetTourRecentlyViewedItems.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetTourRecentlyViewedItems.fromMap(Map<String, dynamic> json) =>
      GetTourRecentlyViewedItems(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class Data {
  Data({
    this.recentViewPlaylist,
  });

  final List<RecentViewPlaylist>? recentViewPlaylist;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        recentViewPlaylist: json["recentViewPlaylist"] == null
            ? null
            : List<RecentViewPlaylist>.from(json["recentViewPlaylist"]
                .map((x) => RecentViewPlaylist.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "recentViewPlaylist": recentViewPlaylist == null
            ? null
            : List<dynamic>.from(recentViewPlaylist!.map((x) => x.toMap())),
      };
}

class RecentViewPlaylist {
  RecentViewPlaylist({
    this.id,
    this.cityId,
    this.countryId,
    this.name,
    this.image,
    this.locationName,
    this.category,
    this.type,
    this.promotions,
    this.location,
  });

  final String? id;
  final String? cityId;
  final String? countryId;
  final String? name;
  final String? image;
  final String? locationName;
  final String? category;
  final String? type;
  final List<Promotions>? promotions;
  final String? location;

  factory RecentViewPlaylist.fromJson(String str) =>
      RecentViewPlaylist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RecentViewPlaylist.fromMap(Map<String, dynamic> json) =>
      RecentViewPlaylist(
        id: json["id"],
        cityId: json["cityId"],
        countryId: json["countryId"],
        name: json["name"],
        image: json["image"],
        locationName: json["locationName"],
        category: json["category"],
        type: json["type"],
        promotions: json["promotions"] == null
            ? null
            : List<Promotions>.from(
                json["promotions"].map((x) => Promotions.fromMap(x))),
        location: json["location"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "cityId": cityId,
        "countryId": countryId,
        "name": name,
        "image": image,
        "locationName": locationName,
        "category": category,
        "type": type,
        "promotions": promotions == null
            ? null
            : List<dynamic>.from(promotions!.map((x) => x.toMap())),
        "location": location,
      };
}

class Promotions {
  Promotions({
    this.productId,
    this.productType,
    this.promotionType,
    this.promotionCode,
    this.line1,
    this.line2,
    this.startDate,
    this.endDate,
    this.title,
  });

  final String? productId;
  final String? productType;
  final String? promotionType;
  final String? promotionCode;
  final String? line1;
  final String? line2;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? title;

  factory Promotions.fromJson(String str) =>
      Promotions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Promotions.fromMap(Map<String, dynamic> json) => Promotions(
        productId: json["productId"],
        productType: json["productType"],
        promotionType: json["promotionType"],
        promotionCode: json["promotionCode"],
        line1: json["line1"],
        line2: json["line2"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.tryParse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.tryParse(json["endDate"]),
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "productId": productId,
        "productType": productType,
        "promotionType": promotionType,
        "promotionCode": promotionCode,
        "line1": line1,
        "line2": line2,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "title": title,
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
