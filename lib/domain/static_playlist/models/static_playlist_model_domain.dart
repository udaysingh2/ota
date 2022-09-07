// To parse this JSON data, do
//
//     final staticPlayListModelDomain = staticPlayListModelDomainFromMap(jsonString);

import 'dart:convert';

class StaticPlayListModelDomain {
  StaticPlayListModelDomain({
    this.getPlaylists,
  });

  final GetPlaylists? getPlaylists;

  factory StaticPlayListModelDomain.fromJson(String str) =>
      StaticPlayListModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StaticPlayListModelDomain.fromMap(Map<String, dynamic> json) =>
      StaticPlayListModelDomain(
        getPlaylists: json["getPlaylists_v2"] == null
            ? null
            : GetPlaylists.fromMap(json["getPlaylists_v2"]),
      );

  Map<String, dynamic> toMap() => {
        "getPlaylists_v2": getPlaylists == null ? null : getPlaylists!.toMap(),
      };
}

class GetPlaylists {
  GetPlaylists({
    this.status,
    this.data,
  });

  final Status? status;
  final OtaStaticCardListData? data;

  factory GetPlaylists.fromJson(String str) =>
      GetPlaylists.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetPlaylists.fromMap(Map<String, dynamic> json) => GetPlaylists(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
        data: json["data"] == null
            ? null
            : OtaStaticCardListData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status == null ? null : status!.toMap(),
        "data": data == null ? null : data!.toMap(),
      };
}

class OtaStaticCardListData {
  OtaStaticCardListData({
    this.serviceName,
    this.language,
    this.playlist,
  });

  final String? serviceName;
  final String? language;
  final List<OtaStaticPlaylist>? playlist;

  factory OtaStaticCardListData.fromJson(String str) =>
      OtaStaticCardListData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtaStaticCardListData.fromMap(Map<String, dynamic> json) =>
      OtaStaticCardListData(
        serviceName: json["serviceName"],
        language: json["language"],
        playlist: json["playlist"] == null
            ? null
            : List<OtaStaticPlaylist>.from(
                json["playlist"].map((x) => OtaStaticPlaylist.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "serviceName": serviceName,
        "language": language,
        "playlist": playlist == null
            ? null
            : List<dynamic>.from(playlist!.map((x) => x.toMap())),
      };
}

class OtaStaticPlaylist {
  OtaStaticPlaylist({
    this.playlistId,
    this.playlistName,
    this.cardList,
  });

  final String? playlistId;
  final String? playlistName;
  final List<OtaStaticCardList>? cardList;

  factory OtaStaticPlaylist.fromJson(String str) =>
      OtaStaticPlaylist.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtaStaticPlaylist.fromMap(Map<String, dynamic> json) =>
      OtaStaticPlaylist(
        playlistId: json["playlistId"],
        playlistName: json["playlistName"],
        cardList: json["cardList"] == null
            ? null
            : List<OtaStaticCardList>.from(
                json["cardList"].map((x) => OtaStaticCardList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "playlistId": playlistId,
        "playlistName": playlistName,
        "cardList": cardList == null
            ? null
            : List<dynamic>.from(cardList!.map((x) => x.toMap())),
      };
}

class OtaStaticCardList {
  OtaStaticCardList({
    this.productType,
    this.hotel,
    this.car,
    this.tour,
    this.ticket,
  });

  final String? productType;
  final HotelCard? hotel;
  final CarCard? car;
  final TourCard? tour;
  final TourCard? ticket;

  factory OtaStaticCardList.fromJson(String str) =>
      OtaStaticCardList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OtaStaticCardList.fromMap(Map<String, dynamic> json) =>
      OtaStaticCardList(
        productType: json["productType"],
        hotel: json["hotel"] == null ? null : HotelCard.fromMap(json["hotel"]),
        car: json["carrental"] == null
            ? null
            : CarCard.fromMap(json["carrental"]),
        tour: json["tour"] == null ? null : TourCard.fromMap(json["tour"]),
        ticket:
            json["ticket"] == null ? null : TourCard.fromMap(json["ticket"]),
      );

  Map<String, dynamic> toMap() => {
        "productType": productType,
        "hotel": hotel == null ? null : hotel!.toMap(),
        "carrental": car == null ? null : car!.toMap(),
        "tour": tour == null ? null : tour!.toMap(),
        "ticket": ticket == null ? null : ticket!.toMap(),
      };
}

class HotelCard {
  HotelCard({
    this.id,
    this.name,
    this.locationName,
    this.cityId,
    this.cityName,
    this.countryId,
    this.capsulePromotion,
    this.rating,
    this.infoPromotion,
    this.imageUrl,
    this.startPrice,
    this.styleName,
    this.promotionTextLine1,
    this.promotionTextLine2,
  });

  final String? id;
  final String? name;
  final String? locationName;
  final String? cityId;
  final String? cityName;
  final String? countryId;
  final List<CardCapsulePromotion>? capsulePromotion;
  final int? rating;
  final List<InfoPromotion>? infoPromotion;
  final String? imageUrl;
  final double? startPrice;
  final String? styleName;
  final String? promotionTextLine1;
  final String? promotionTextLine2;

  factory HotelCard.fromJson(String str) => HotelCard.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelCard.fromMap(Map<String, dynamic> json) => HotelCard(
        id: json["id"],
        name: json["name"],
        locationName: json["locationName"],
        cityId: json["cityId"],
        cityName: json["cityName"],
        countryId: json["countryId"],
        capsulePromotion: json["capsulePromotion"] == null
            ? null
            : List<CardCapsulePromotion>.from(json["capsulePromotion"]
                .map((x) => CardCapsulePromotion.fromMap(x))),
        rating: json["rating"],
        infoPromotion: json["infopromotion"] == null
            ? null
            : List<InfoPromotion>.from(
                json["infopromotion"].map((x) => InfoPromotion.fromMap(x))),
        imageUrl: json["imageUrl"],
        startPrice: json["startPrice"].toDouble(),
        styleName: json["styleName"],
        promotionTextLine1: json["promotionText_line1"],
        promotionTextLine2: json["promotionText_line2"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "locationName": locationName,
        "cityId": cityId,
        "cityName": cityName,
        "countryId": countryId,
        "capsulePromotion": capsulePromotion == null
            ? null
            : List<dynamic>.from(capsulePromotion!.map((x) => x.toMap())),
        "rating": rating,
        "infopromotion": infoPromotion == null
            ? null
            : List<dynamic>.from(infoPromotion!.map((x) => x)),
        "imageUrl": imageUrl,
        "startPrice": startPrice,
        "styleName": styleName,
        "promotionText_line1": promotionTextLine1,
        "promotionText_line2": promotionTextLine2,
      };
}

class InfoPromotion {
  InfoPromotion({
    this.promotionText,
  });

  String? promotionText;

  factory InfoPromotion.fromJson(String str) =>
      InfoPromotion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InfoPromotion.fromMap(Map<String, dynamic> json) => InfoPromotion(
        promotionText: json["promotionText"],
      );

  Map<String, dynamic> toMap() => {
        "promotionText": promotionText,
      };
}

class CarCard {
  CarCard({
    this.id,
    this.name,
    this.locationName,
    this.cityId,
    this.cityName,
    this.countryId,
    this.capsulePromotion,
    this.rating,
    this.infoPromotion,
    this.imageUrl,
    this.styleName,
    this.startPrice,
    this.promotionTextLine1,
    this.promotionTextLine2,
    this.craftType,
    this.pickupLocationId,
    this.returnLocationId,
  });

  final String? id;
  final String? name;
  final String? locationName;
  final String? cityId;
  final String? cityName;
  final String? countryId;
  final List<CardCapsulePromotion>? capsulePromotion;
  final int? rating;
  final List<InfoPromotion>? infoPromotion;
  final String? imageUrl;
  final String? styleName;
  final double? startPrice;
  final String? promotionTextLine1;
  final String? promotionTextLine2;
  final String? craftType;
  final String? pickupLocationId;
  final String? returnLocationId;

  factory CarCard.fromJson(String str) => CarCard.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarCard.fromMap(Map<String, dynamic> json) => CarCard(
        id: json["id"],
        name: json["name"],
        locationName: json["locationName"],
        cityId: json["cityId"],
        cityName: json["cityName"],
        countryId: json["countryId"],
        capsulePromotion: json["capsulePromotion"] == null
            ? null
            : List<CardCapsulePromotion>.from(json["capsulePromotion"]
                .map((x) => CardCapsulePromotion.fromMap(x))),
        rating: json["rating"],
        infoPromotion: json["infopromotion"] == null
            ? null
            : List<InfoPromotion>.from(
                json["infopromotion"].map((x) => InfoPromotion.fromMap(x))),
        imageUrl: json["imageUrl"],
        styleName: json["styleName"],
        startPrice: json["startPrice"].toDouble(),
        promotionTextLine1: json["promotionText_line1"],
        promotionTextLine2: json["promotionText_line2"],
        craftType: json["craftType"],
        pickupLocationId: json["pickupLocationId"],
        returnLocationId: json["returnLocationId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "locationName": locationName,
        "cityId": cityId,
        "cityName": cityName,
        "countryId": countryId,
        "capsulePromotion": capsulePromotion == null
            ? null
            : List<dynamic>.from(capsulePromotion!.map((x) => x)),
        "rating": rating,
        "infopromotion": infoPromotion == null
            ? null
            : List<dynamic>.from(infoPromotion!.map((x) => x)),
        "imageUrl": imageUrl,
        "styleName": styleName,
        "startPrice": startPrice,
        "promotionText_line1": promotionTextLine1,
        "promotionText_line2": promotionTextLine2,
        "craftType": craftType,
        "pickupLocationId": pickupLocationId,
        "returnLocationId": returnLocationId,
      };
}

class TourCard {
  TourCard({
    this.id,
    this.name,
    this.locationName,
    this.cityId,
    this.cityName,
    this.countryId,
    this.capsulePromotion,
    this.rating,
    this.infoPromotion,
    this.imageUrl,
    this.styleName,
    this.startPrice,
    this.promotionTextLine1,
    this.promotionTextLine2,
  });

  final String? id;
  final String? name;
  final String? locationName;
  final String? cityId;
  final String? cityName;
  final String? countryId;
  final List<CardCapsulePromotion>? capsulePromotion;
  final int? rating;
  final List<InfoPromotion>? infoPromotion;
  final String? imageUrl;
  final String? styleName;
  final double? startPrice;
  final String? promotionTextLine1;
  final String? promotionTextLine2;

  factory TourCard.fromJson(String str) => TourCard.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TourCard.fromMap(Map<String, dynamic> json) => TourCard(
        id: json["id"],
        name: json["name"],
        locationName: json["locationName"],
        cityId: json["cityId"],
        cityName: json["cityName"],
        countryId: json["countryId"],
        capsulePromotion: json["capsulePromotion"] == null
            ? null
            : List<CardCapsulePromotion>.from(json["capsulePromotion"]
                .map((x) => CardCapsulePromotion.fromMap(x))),
        rating: json["rating"],
        infoPromotion: json["infopromotion"] == null
            ? null
            : List<InfoPromotion>.from(
                json["infopromotion"].map((x) => InfoPromotion.fromMap(x))),
        imageUrl: json["imageUrl"],
        styleName: json["styleName"],
        startPrice: json["startPrice"].toDouble(),
        promotionTextLine1: json["promotionText_line1"],
        promotionTextLine2: json["promotionText_line2"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "locationName": locationName,
        "cityId": cityId,
        "cityName": cityName,
        "countryId": countryId,
        "capsulePromotion": capsulePromotion == null
            ? null
            : List<dynamic>.from(capsulePromotion!.map((x) => x)),
        "rating": rating,
        "infopromotion": infoPromotion == null
            ? null
            : List<dynamic>.from(infoPromotion!.map((x) => x)),
        "imageUrl": imageUrl,
        "styleName": styleName,
        "startPrice": startPrice,
        "promotionText_line1": promotionTextLine1,
        "promotionText_line2": promotionTextLine2,
      };
}

class CardCapsulePromotion {
  CardCapsulePromotion({
    this.name,
    this.code,
  });

  final String? name;
  final String? code;

  factory CardCapsulePromotion.fromJson(String str) =>
      CardCapsulePromotion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CardCapsulePromotion.fromMap(Map<String, dynamic> json) =>
      CardCapsulePromotion(
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "code": code,
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
