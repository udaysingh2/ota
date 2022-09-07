import 'dart:convert';

import 'package:ota/core/query_names.dart';

class HotelDetailModelDomain {
  HotelDetailModelDomain({
    this.getHotelDetails,
  });

  final GetHotelDetails? getHotelDetails;

  factory HotelDetailModelDomain.fromJson(String str) =>
      HotelDetailModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelDetailModelDomain.fromMap(Map<String, dynamic> json) =>
      HotelDetailModelDomain(
        getHotelDetails: json[QueryNames.shared.getHotelDetails] == null
            ? null
            : GetHotelDetails.fromMap(json[QueryNames.shared.getHotelDetails]),
      );

  Map<String, dynamic> toMap() => {
        QueryNames.shared.getHotelDetails: getHotelDetails?.toMap(),
      };
}

class GetHotelDetails {
  GetHotelDetails({
    this.data,
    this.status,
    this.metadata,
  });

  final Data? data;
  final Status? status;
  final Metadata? metadata;

  factory GetHotelDetails.fromJson(String str) =>
      GetHotelDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetHotelDetails.fromMap(Map<String, dynamic> json) => GetHotelDetails(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromMap(json["metadata"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
        "metadata": metadata?.toMap(),
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.rating,
    this.freefoodDelivery,
    this.ratingCount,
    this.ratingText,
    this.location,
    this.address,
    this.isFavourite,
    this.images,
    this.facilities,
    this.rooms,
    this.promotions,
  });

  final String? id;
  final String? name;
  final String? rating;
  final bool? freefoodDelivery;
  final double? ratingCount;
  final String? ratingText;
  final String? location;
  final String? address;
  final int? isFavourite;
  final Images? images;
  final Facilities? facilities;
  final List<Room>? rooms;
  final List<Promotions>? promotions;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        rating: json["rating"],
        freefoodDelivery: json["freefoodDelivery"],
        ratingCount: json["ratingCount"],
        ratingText: json["ratingText"],
        location: json["location"],
        address: json["address"],
        isFavourite: json["isFavourite"],
        images: json["images"] == null ? null : Images.fromMap(json["images"]),
        facilities: json["facilities"] == null
            ? null
            : Facilities.fromMap(json["facilities"]),
        rooms: json["rooms"] == null
            ? null
            : List<Room>.from(json["rooms"].map((x) => Room.fromMap(x))),
        promotions: json["promotionList"] == null
            ? null
            : List<Promotions>.from(
                json["promotionList"].map((x) => Promotions.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "rating": rating,
        "freefoodDelivery": freefoodDelivery,
        "ratingCount": ratingCount,
        "ratingText": ratingText,
        "location": location,
        "address": address,
        "isFavourite": isFavourite,
        "images": images?.toMap(),
        "facilities": facilities?.toMap(),
        "rooms": rooms == null
            ? null
            : List<dynamic>.from(rooms!.map((x) => x.toMap())),
        "promotionList": promotions == null
            ? null
            : List<dynamic>.from(promotions!.map((x) => x.toMap())),
      };
}

class Facilities {
  Facilities({
    this.list,
    this.main,
  });

  final List<ListElement>? list;
  final List<ListElement>? main;

  factory Facilities.fromJson(String str) =>
      Facilities.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Facilities.fromMap(Map<String, dynamic> json) => Facilities(
        list: json["list"] == null
            ? null
            : List<ListElement>.from(
                json["list"].map((x) => ListElement.fromMap(x))),
        main: json["main"] == null
            ? null
            : List<ListElement>.from(
                json["main"].map((x) => ListElement.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "list": list == null
            ? null
            : List<dynamic>.from(list!.map((x) => x.toMap())),
        "main": main == null
            ? null
            : List<dynamic>.from(main!.map((x) => x.toMap())),
      };
}

class ListElement {
  ListElement({
    this.key,
    this.value,
  });

  final String? key;
  final String? value;

  factory ListElement.fromJson(String str) =>
      ListElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListElement.fromMap(Map<String, dynamic> json) => ListElement(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "key": key,
        "value": value,
      };
}

class Images {
  Images({
    this.baseUri,
    this.cover,
    this.galleryCount,
    this.gallery,
  });

  final String? baseUri;
  final String? cover;
  final int? galleryCount;
  final List<String>? gallery;

  factory Images.fromJson(String str) => Images.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Images.fromMap(Map<String, dynamic> json) => Images(
        baseUri: json["baseUri"],
        cover: json["cover"],
        galleryCount: json["galleryCount"],
        gallery: json["gallery"] == null
            ? null
            : List<String>.from(json["gallery"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "baseUri": baseUri,
        "cover": cover,
        "galleryCount": galleryCount,
        "gallery":
            gallery == null ? null : List<dynamic>.from(gallery!.map((x) => x)),
      };
}

class Room {
  Room({
    this.roomName,
    this.roomInfo,
    this.facility,
    this.details,
  });

  final String? roomName;
  final RoomInfo? roomInfo;
  final List<ListElement>? facility;
  final List<Detail>? details;

  factory Room.fromJson(String str) => Room.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Room.fromMap(Map<String, dynamic> json) => Room(
        roomName: json["roomName"],
        roomInfo: json["roomInfo"] == null
            ? null
            : RoomInfo.fromMap(json["roomInfo"]),
        facility: json["facility"] == null
            ? null
            : List<ListElement>.from(
                json["facility"].map((x) => ListElement.fromMap(x))),
        details: json["details"] == null
            ? null
            : List<Detail>.from(json["details"].map((x) => Detail.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "roomName": roomName,
        "roomInfo": roomInfo?.toMap(),
        "facility": facility == null
            ? null
            : List<dynamic>.from(facility!.map((x) => x.toMap())),
        "details": details == null
            ? null
            : List<dynamic>.from(details!.map((x) => x.toMap())),
      };
}

class Detail {
  Detail({
    this.roomCode,
    this.roomCatName,
    this.roomOfferName,
    this.roomType,
    this.nightPrice,
    this.noOfRoomsAndName,
    this.nightPriceBeforeDiscount,
    this.discountPercent,
    this.totalPrice,
    this.roomOffer,
    this.supplier,
    this.supplierId,
    this.supplierName,
    this.hotelBenefits,
  });

  final String? roomCode;
  final String? roomCatName;
  final String? roomOfferName;
  final String? roomType;
  final double? nightPrice;
  final String? noOfRoomsAndName;
  final double? nightPriceBeforeDiscount;
  final int? discountPercent;
  final double? totalPrice;
  final RoomOffer? roomOffer;
  final String? supplier;
  final String? supplierId;
  final String? supplierName;
  final List<HotelBenefits>? hotelBenefits;

  factory Detail.fromJson(String str) => Detail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Detail.fromMap(Map<String, dynamic> json) => Detail(
        roomCode: json["roomCode"],
        roomCatName: json["roomCatName"],
        roomOfferName: json["roomOfferName"],
        roomType: json["roomType"],
        nightPrice: json["nightPrice"]?.toDouble(),
        noOfRoomsAndName: json["noOfRoomsAndName"],
        nightPriceBeforeDiscount: json["nightPriceBeforeDiscount"]?.toDouble(),
        discountPercent: json["discountPercent"],
        totalPrice: json["totalPrice"]?.toDouble(),
        roomOffer: json["roomOffer"] == null
            ? null
            : RoomOffer.fromMap(json["roomOffer"]),
        supplier: json["supplier"],
        supplierId: json["supplierId"],
        supplierName: json["supplierName"],
        hotelBenefits: json["hotelBenefits"] == null
            ? null
            : List<HotelBenefits>.from(
                json["hotelBenefits"].map((x) => HotelBenefits.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "roomCode": roomCode,
        "roomCatName": roomCatName,
        "roomOfferName": roomOfferName,
        "roomType": roomType,
        "nightPrice": nightPrice,
        "noOfRoomsAndName": noOfRoomsAndName,
        "nightPriceBeforeDiscount": nightPriceBeforeDiscount,
        "discountPercent": discountPercent,
        "totalPrice": totalPrice,
        "roomOffer": roomOffer?.toMap(),
        "supplier": supplier,
        "supplierId": supplierId,
        "supplierName": supplierName,
        "hotelBenefits": hotelBenefits == null
            ? null
            : List<dynamic>.from(hotelBenefits!.map((x) => x.toMap())),
      };
}

class HotelBenefits {
  HotelBenefits({
    this.topic,
    this.shortDescription,
    this.longDescription,
    this.categoryId,
    this.categoryName,
  });
  final String? topic;
  final String? shortDescription;
  final String? longDescription;
  final String? categoryId;
  final String? categoryName;

  factory HotelBenefits.fromJson(String str) =>
      HotelBenefits.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelBenefits.fromMap(Map<String, dynamic> json) => HotelBenefits(
        topic: json["topic"],
        shortDescription: json["shortDescription"],
        longDescription: json["longDescription"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
      );

  Map<String, dynamic> toMap() => {
        "topic": topic,
        "shortDescription": shortDescription,
        "longDescription": longDescription,
        "categoryId": categoryId,
        "categoryName": categoryName,
      };
}

class Promotions {
  Promotions({
    this.title,
    this.description,
    this.web,
    this.imageIconUrl,
    this.promotionCode,
    this.bannerDescDisplay,
    this.line1,
    this.line2,
    this.productId,
    this.productType,
    this.promotionType,
  });

  final String? title;
  final String? description;
  final String? web;
  final String? imageIconUrl;
  final String? promotionCode;
  final bool? bannerDescDisplay;
  final String? line1;
  final String? line2;
  final String? productId;
  final String? productType;
  final String? promotionType;

  factory Promotions.fromJson(String str) =>
      Promotions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Promotions.fromMap(Map<String, dynamic> json) => Promotions(
        title: json["title"],
        description: json["description"],
        web: json["web"],
        imageIconUrl: json["iconImage"],
        promotionCode: json["promotionCode"],
        bannerDescDisplay: json["bannerDescDisplay"],
        line1: json["line1"],
        line2: json["line2"],
        productId: json["productId"],
        productType: json["productType"],
        promotionType: json["promotionType"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "web": web,
        "iconImage": imageIconUrl,
        "promotionCode": promotionCode,
        "bannerDescDisplay": bannerDescDisplay,
        "line1": line1,
        "line2": line2,
        "productId": productId,
        "productType": productType,
        "promotionType": promotionType,
      };
}

class RoomOffer {
  RoomOffer({
    this.mealCode,
    this.breakfast,
    this.payNow,
    this.cancellationPolicy,
  });

  final String? mealCode;
  final int? breakfast;
  final String? payNow;
  final String? cancellationPolicy;

  factory RoomOffer.fromJson(String str) => RoomOffer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomOffer.fromMap(Map<String, dynamic> json) => RoomOffer(
        mealCode: json["mealCode"],
        breakfast: json["breakfast"],
        payNow: json["payNow"],
        cancellationPolicy: json["cancellationPolicy"],
      );

  Map<String, dynamic> toMap() => {
        "mealCode": mealCode,
        "breakfast": breakfast,
        "payNow": payNow,
        "cancellationPolicy": cancellationPolicy,
      };
}

class RoomInfo {
  RoomInfo({
    this.roomImageCount,
    this.coverImage,
    this.roomFacilityInfo,
    this.description,
    this.promoteFlag,
    this.dimension,
    this.totalRoom,
    this.doubleBedFlag,
    this.twinBedFlag,
    this.queenBedflag,
    this.smorkingFlag,
    this.nonSmorkingFlag,
    this.noWindowFlag,
    this.balconyFlag,
    this.wifiFlag,
    this.maxPaxNbr,
    this.roomFacilities,
  });

  final int? roomImageCount;
  final String? coverImage;
  final String? roomFacilityInfo;
  final String? description;
  final String? promoteFlag;
  final String? dimension;
  final String? totalRoom;
  final String? doubleBedFlag;
  final String? twinBedFlag;
  final String? queenBedflag;
  final String? smorkingFlag;
  final String? nonSmorkingFlag;
  final String? noWindowFlag;
  final String? balconyFlag;
  final String? wifiFlag;
  final String? maxPaxNbr;
  final List<RoomFacility>? roomFacilities;

  factory RoomInfo.fromJson(String str) => RoomInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomInfo.fromMap(Map<String, dynamic> json) => RoomInfo(
        roomImageCount: json["roomImageCount"],
        coverImage: json["coverImage"],
        roomFacilityInfo: json["roomFacilityInfo"],
        description: json["description"],
        promoteFlag: json["promoteFlag"],
        dimension: json["dimension"],
        totalRoom: json["totalRoom"],
        doubleBedFlag: json["doubleBedFlag"],
        twinBedFlag: json["twinBedFlag"],
        queenBedflag: json["queenBedflag"],
        smorkingFlag: json["smorkingFlag"],
        nonSmorkingFlag: json["nonSmorkingFlag"],
        noWindowFlag: json["noWindowFlag"],
        balconyFlag: json["balconyFlag"],
        wifiFlag: json["wifiFlag"],
        maxPaxNbr: json["maxPaxNbr"],
        roomFacilities: json["roomFacilities"] == null
            ? null
            : List<RoomFacility>.from(
                json["roomFacilities"].map((x) => RoomFacility.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "roomImageCount": roomImageCount,
        "coverImage": coverImage,
        "roomFacilityInfo": roomFacilityInfo,
        "description": description,
        "promoteFlag": promoteFlag,
        "dimension": dimension,
        "totalRoom": totalRoom,
        "doubleBedFlag": doubleBedFlag,
        "twinBedFlag": twinBedFlag,
        "queenBedflag": queenBedflag,
        "smorkingFlag": smorkingFlag,
        "nonSmorkingFlag": nonSmorkingFlag,
        "noWindowFlag": noWindowFlag,
        "balconyFlag": balconyFlag,
        "wifiFlag": wifiFlag,
        "maxPaxNbr": maxPaxNbr,
        "roomFacilities": roomFacilities == null
            ? null
            : List<dynamic>.from(roomFacilities!.map((x) => x.toMap())),
      };
}

class RoomFacility {
  RoomFacility({
    this.code,
    this.name,
  });

  final String? code;
  final String? name;

  factory RoomFacility.fromJson(String str) =>
      RoomFacility.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomFacility.fromMap(Map<String, dynamic> json) => RoomFacility(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "code": code,
        "name": name,
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

class Metadata {
  Metadata({
    this.source,
    this.timeStamp,
  });

  final String? source;
  final String? timeStamp;

  factory Metadata.fromJson(String str) => Metadata.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Metadata.fromMap(Map<String, dynamic> json) => Metadata(
        source: json["source"],
        timeStamp: json["timeStamp"],
      );

  Map<String, dynamic> toMap() => {
        "source": source,
        "timeStamp": timeStamp,
      };
}
