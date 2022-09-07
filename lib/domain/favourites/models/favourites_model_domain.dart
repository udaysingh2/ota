import 'dart:convert';

class FavoritesModelDomain {
  FavoritesModelDomain({
    this.getFavorites,
  });

  final GetFavorites? getFavorites;

  factory FavoritesModelDomain.fromJson(String str) =>
      FavoritesModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavoritesModelDomain.fromMap(Map<String, dynamic> json) =>
      FavoritesModelDomain(
        getFavorites: json["getFavorites"] == null
            ? null
            : GetFavorites.fromMap(json["getFavorites"]),
      );

  Map<String, dynamic> toMap() => {
        "getFavorites": getFavorites?.toMap(),
      };
}

class GetFavorites {
  GetFavorites({
    this.data,
    this.status,
  });

  final Data? data;
  final Status? status;

  factory GetFavorites.fromJson(String str) =>
      GetFavorites.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetFavorites.fromMap(Map<String, dynamic> json) => GetFavorites(
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
    this.favorites,
  });

  final List<Favorite>? favorites;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        favorites: json["favorites"] == null
            ? null
            : List<Favorite>.from(
                json["favorites"].map((x) => Favorite.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "favorites": favorites == null
            ? null
            : List<dynamic>.from(favorites!.map((x) => x.toMap())),
      };
}

class Favorite {
  Favorite({
    this.id,
    this.cityId,
    this.countryId,
    this.name,
    this.image,
    this.location,
    this.category,
    this.serviceName,
    this.promotionList,
  });

  final String? id;
  final String? cityId;
  final String? countryId;
  final String? name;
  final String? image;
  final String? location;
  final String? category;
  final String? serviceName;
  final List<HotelPromotionList>? promotionList;

  factory Favorite.fromJson(String str) => Favorite.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Favorite.fromMap(Map<String, dynamic> json) => Favorite(
        id: json["serviceId"],
        cityId: json["cityId"],
        countryId: json["countryId"],
        name: json["name"],
        image: json["image"],
        location: json["location"],
        category: json["category"],
        serviceName: json["serviceName"],
        promotionList: json["promotionList"] == null
            ? null
            : List<HotelPromotionList>.from(json["promotionList"]
                .map((x) => HotelPromotionList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "cityId": cityId,
        "countryId": countryId,
        "name": name,
        "image": image,
        "location": location,
        "category": category,
        "serviceName": serviceName,
        "promotionList": promotionList == null
            ? null
            : List<dynamic>.from(promotionList!.map((x) => x.toMap())),
      };
}

class HotelPromotionList {
  HotelPromotionList({
    this.productId,
    this.productType,
    this.promotionType,
    this.promotionCode,
    this.line1,
    this.line2,
    this.startDate,
    this.endDate,
  });

  final String? productId;
  final String? productType;
  final String? promotionType;
  final String? promotionCode;
  final String? line1;
  final String? line2;
  final DateTime? startDate;
  final DateTime? endDate;

  factory HotelPromotionList.fromMap(Map<String, dynamic> json) =>
      HotelPromotionList(
        productId: json["productId"],
        productType: json["productType"],
        promotionType: json["promotionType"],
        promotionCode: json["promotionCode"],
        line1: json["line1"],
        line2: json["line2"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
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
