import 'dart:convert';

class FavouritesCarRentalModelDomain {
  FavouritesCarRentalModelDomain({
    this.getAllFavorites,
  });

  final GetAllFavorites? getAllFavorites;

  factory FavouritesCarRentalModelDomain.fromJson(String str) =>
      FavouritesCarRentalModelDomain.fromMap(json.decode(str));

  factory FavouritesCarRentalModelDomain.fromMap(Map<String, dynamic> json) =>
      FavouritesCarRentalModelDomain(
        getAllFavorites: json["getCarRentalFavorites"] == null
            ? null
            : GetAllFavorites.fromMap(json["getCarRentalFavorites"]),
      );

  Map<String, dynamic> toMap() => {
        "getCarRentalFavorites": getAllFavorites?.toMap(),
      };
}

class GetAllFavorites {
  GetAllFavorites({
    this.data,
    this.status,
  });

  final GetAllFavoritesData? data;
  final Status? status;

  factory GetAllFavorites.fromMap(Map<String, dynamic> json) => GetAllFavorites(
        data: json["data"] == null
            ? null
            : GetAllFavoritesData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class GetAllFavoritesData {
  GetAllFavoritesData({
    this.favorites,
  });

  final List<Favorite>? favorites;

  factory GetAllFavoritesData.fromMap(Map<String, dynamic> json) =>
      GetAllFavoritesData(
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
  Favorite(
      {this.image,
      this.name,
      this.location,
      this.supplierId,
      this.id,
      this.pickupLocationId,
      this.dropLocationId,
      this.promotionList,
      this.pickupCounter,
      this.returnCounter});

  final String? image;
  final String? name;
  final String? location;
  final String? supplierId;
  final String? id;
  final String? pickupLocationId;
  final String? dropLocationId;
  final String? pickupCounter;
  final String? returnCounter;
  final List<CarPromotionList>? promotionList;

  factory Favorite.fromMap(Map<String, dynamic> json) => Favorite(
        image: json["image"],
        name: json["name"],
        location: json["location"],
        supplierId: json["supplierId"],
        id: json["serviceId"],
        pickupLocationId: json["pickupLocationId"],
        dropLocationId: json["dropLocationId"],
        pickupCounter: json["pickupCounter"],
        returnCounter: json["returnCounter"],
        promotionList: json["promotionList"] == null
            ? null
            : List<CarPromotionList>.from(
                json["promotionList"].map((x) => CarPromotionList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "image": image,
        "name": name,
        "location": location,
        "supplierId": supplierId,
        "serviceId": id,
        "pickupLocationId": pickupLocationId,
        "dropLocationId": dropLocationId,
        "pickupCounter": pickupCounter,
        "returnCounter": returnCounter,
        "promotionList": promotionList == null
            ? null
            : List<dynamic>.from(promotionList!.map((x) => x.toMap())),
      };
}

class CarPromotionList {
  CarPromotionList({
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

  factory CarPromotionList.fromMap(Map<String, dynamic> json) =>
      CarPromotionList(
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
