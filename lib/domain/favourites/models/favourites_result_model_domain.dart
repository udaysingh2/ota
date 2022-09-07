import 'dart:convert';

class FavouritesResultModelDomain {
  FavouritesResultModelDomain({
    this.getAllFavorites,
  });

  final GetFavouritesResultModel? getAllFavorites;

  factory FavouritesResultModelDomain.fromJson(String str) =>
      FavouritesResultModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavouritesResultModelDomain.fromMap(Map<String, dynamic> json) =>
      FavouritesResultModelDomain(
        getAllFavorites: json["getAllFavorites"] == null
            ? null
            : GetFavouritesResultModel.fromMap(json["getAllFavorites"]),
      );

  Map<String, dynamic> toMap() => {
        "getAllFavorites":
            getAllFavorites == null ? null : getAllFavorites!.toMap(),
      };
}

class GetFavouritesResultModel {
  GetFavouritesResultModel({
    this.data,
  });

  final Data? data;

  factory GetFavouritesResultModel.fromJson(String str) =>
      GetFavouritesResultModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetFavouritesResultModel.fromMap(Map<String, dynamic> json) =>
      GetFavouritesResultModel(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
      };
}

class Data {
  Data({
    required this.favourites,
  });

  final List<Favourites> favourites;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        favourites: json["favorites"] == null
            ? []
            : List<Favourites>.from(
                json["favorites"].map((x) => Favourites.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "favorites": List<dynamic>.from(favourites.map((x) => x.toMap())),
      };
}

class Favourites {
  final String hotelId;
  final String hotelName;
  final String location;
  final String imageUrl;
  final String cityId;
  final String countryId;
  final double latitude;
  final double longitude;
  final List<PromotionList>? promotionList;

  Favourites({
    required this.hotelId,
    required this.hotelName,
    required this.location,
    required this.imageUrl,
    required this.cityId,
    required this.countryId,
    required this.latitude,
    required this.longitude,
    required this.promotionList,
  });

  factory Favourites.fromJson(String str) =>
      Favourites.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Favourites.fromMap(Map<String, dynamic> json) => Favourites(
        hotelId: json["hotelId"] ?? '',
        hotelName: json["hotelName"] ?? '',
        location: json["location"] ?? '',
        imageUrl: json["hotelImage"] ?? '',
        cityId: json["cityId"] ?? '',
        countryId: json["countryId"] ?? '',
        latitude: json["latitude"] ?? 0.0,
        longitude: json["longitude"] ?? 0.0,
        promotionList: json["promotionList"] == null
            ? null
            : List<PromotionList>.from(
                json["promotionList"].map((x) => PromotionList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "hotelId": hotelId,
        "hotelName": hotelName,
        "location": location,
        "hotelImage": imageUrl,
        "cityId": cityId,
        "countryId": countryId,
        "latitude": latitude,
        "longitude": longitude,
        "promotionList": promotionList == null
            ? null
            : List<dynamic>.from(promotionList!.map((x) => x.toMap())),
      };
}

class PromotionList {
  PromotionList({
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

  factory PromotionList.fromJson(String str) =>
      PromotionList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PromotionList.fromMap(Map<String, dynamic> json) => PromotionList(
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
