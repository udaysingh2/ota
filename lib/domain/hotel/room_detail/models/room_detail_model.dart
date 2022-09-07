import 'dart:convert';

import 'package:ota/core/query_names.dart';

class RoomDetail {
  RoomDetail({
    this.data,
  });

  final RoomDetailData? data;

  factory RoomDetail.fromJson(String str) =>
      RoomDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomDetail.fromMap(Map<String, dynamic> json) => RoomDetail(
        data:
            json["data"] == null ? null : RoomDetailData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class RoomDetailData {
  RoomDetailData({
    this.getRoomDetails,
  });

  final GetRoomDetails? getRoomDetails;

  factory RoomDetailData.fromJson(String str) =>
      RoomDetailData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomDetailData.fromMap(Map<String, dynamic> json) => RoomDetailData(
        getRoomDetails: json[QueryNames.shared.getRoomDetails] == null
            ? null
            : GetRoomDetails.fromMap(json[QueryNames.shared.getRoomDetails]),
      );

  Map<String, dynamic> toMap() => {
        QueryNames.shared.getRoomDetails: getRoomDetails?.toMap(),
      };
}

class GetRoomDetails {
  GetRoomDetails({
    this.data,
    this.status,
  });

  final GetRoomDetailsData? data;
  final Status? status;

  factory GetRoomDetails.fromJson(String str) =>
      GetRoomDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetRoomDetails.fromMap(Map<String, dynamic> json) => GetRoomDetails(
        data: json["data"] == null
            ? null
            : GetRoomDetailsData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class GetRoomDetailsData {
  GetRoomDetailsData({
    this.mealType,
    this.roomImage,
    this.roomInfo,
    this.roomCategories,
    this.facilities,
    this.cancellationPolicy,
    this.roomFacilities,
    this.supplier,
    this.supplierId,
    this.supplierName,
    this.totalPrice,
    this.perNightPrice,
    this.discountPercent,
    this.nightPriceBeforeDiscount,
    this.specialPromotions,
  });

  final String? mealType;
  final String? roomImage;
  final RoomInfo? roomInfo;
  final List<RoomCategory>? roomCategories;
  final List<Facility>? facilities;
  final List<CancellationPolicy>? cancellationPolicy;
  final List<String>? roomFacilities;
  final String? supplier;
  final String? supplierId;
  final String? supplierName;
  final double? totalPrice;
  final double? perNightPrice;
  final double? discountPercent;
  final double? nightPriceBeforeDiscount;
  final List<HotelBenefit>? specialPromotions;

  factory GetRoomDetailsData.fromJson(String str) =>
      GetRoomDetailsData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetRoomDetailsData.fromMap(Map<String, dynamic> json) =>
      GetRoomDetailsData(
        mealType: json["mealType"],
        roomImage: json["roomImage"],
        roomInfo: json["roomInfo"] == null
            ? null
            : RoomInfo.fromMap(json["roomInfo"]),
        roomCategories: json["roomCategories"] == null
            ? null
            : List<RoomCategory>.from(
                json["roomCategories"].map((x) => RoomCategory.fromMap(x))),
        facilities: json["facilities"] == null
            ? null
            : List<Facility>.from(
                json["facilities"].map((x) => Facility.fromMap(x))),
        cancellationPolicy: json["cancellationPolicy"] == null
            ? null
            : List<CancellationPolicy>.from(json["cancellationPolicy"]
                .map((x) => CancellationPolicy.fromMap(x))),
        roomFacilities: json["roomFacilities"] == null
            ? null
            : List<String>.from(json["roomFacilities"].map((x) => x)),
        supplier: json["supplier"],
        supplierId: json["supplierId"],
        supplierName: json["supplierName"],
        totalPrice: json["totalPrice"]?.toDouble(),
        perNightPrice: json["perNightPrice"]?.toDouble(),
        discountPercent: json["discountPercent"]?.toDouble(),
        nightPriceBeforeDiscount: json["nightPriceBeforeDiscount"]?.toDouble(),
        specialPromotions: json["hotelBenefits"] == null
            ? null
            : List<HotelBenefit>.from(
                json["hotelBenefits"].map((x) => HotelBenefit.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "mealType": mealType,
        "roomImage": roomImage,
        "roomInfo": roomInfo == null ? null : roomInfo!.toMap(),
        "roomCategories": roomCategories == null
            ? null
            : List<dynamic>.from(roomCategories!.map((x) => x.toMap())),
        "facilities": facilities == null
            ? null
            : List<dynamic>.from(facilities!.map((x) => x.toMap())),
        "cancellationPolicy": cancellationPolicy == null
            ? null
            : List<dynamic>.from(cancellationPolicy!.map((x) => x.toMap())),
        "roomFacilities": roomFacilities == null
            ? null
            : List<dynamic>.from(roomFacilities!.map((x) => x)),
        "supplier": supplier,
        "supplierId": supplierId,
        "supplierName": supplierName,
        "totalPrice": totalPrice,
        "perNightPrice": perNightPrice,
        "discountPercent": discountPercent,
        "nightPriceBeforeDiscount": nightPriceBeforeDiscount,
        "hotelBenefits": specialPromotions == null
            ? null
            : List<dynamic>.from(specialPromotions!.map((x) => x.toMap())),
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
  });

  int? roomImageCount;
  String? coverImage;
  String? roomFacilityInfo;
  String? description;
  String? promoteFlag;
  String? dimension;
  String? totalRoom;
  String? doubleBedFlag;
  String? twinBedFlag;
  String? queenBedflag;
  String? smorkingFlag;
  String? nonSmorkingFlag;
  String? noWindowFlag;
  String? balconyFlag;
  String? wifiFlag;
  String? maxPaxNbr;

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
      };
}

class RoomCategory {
  RoomCategory({
    this.noOfRoomsAndName,
    this.roomName,
    this.roomType,
    this.noOfRooms,
  });

  final String? noOfRoomsAndName;
  final String? roomName;
  final String? roomType;
  final int? noOfRooms;

  factory RoomCategory.fromJson(String str) =>
      RoomCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoomCategory.fromMap(Map<String, dynamic> json) => RoomCategory(
        noOfRoomsAndName: json["noOfRoomsAndName"],
        roomName: json["roomName"],
        roomType: json["roomType"],
        noOfRooms: json["noOfRooms"],
      );

  Map<String, dynamic> toMap() => {
        "noOfRoomsAndName": noOfRoomsAndName,
        "roomName": roomName,
        "roomType": roomType,
        "noOfRooms": noOfRooms,
      };
}

class CancellationPolicy {
  CancellationPolicy({
    this.days,
    this.cancellationDaysDescription,
    this.cancellationChargeDescription,
    this.cancellationStatus,
  });

  final int? days;
  final String? cancellationDaysDescription;
  final String? cancellationChargeDescription;
  final String? cancellationStatus;

  factory CancellationPolicy.fromJson(String str) =>
      CancellationPolicy.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CancellationPolicy.fromMap(Map<String, dynamic> json) =>
      CancellationPolicy(
        days: json["days"],
        cancellationDaysDescription: json["cancellationDaysDescription"],
        cancellationChargeDescription: json["cancellationChargeDescription"],
        cancellationStatus: json["cancellationStatus"],
      );

  Map<String, dynamic> toMap() => {
        "days": days,
        "cancellationDaysDescription": cancellationDaysDescription,
        "cancellationChargeDescription": cancellationChargeDescription,
        "cancellationStatus": cancellationStatus,
      };
}

class HotelBenefit {
  HotelBenefit({
    this.longDescription,
    this.shortDescription,
  });

  final String? longDescription;
  final String? shortDescription;

  factory HotelBenefit.fromJson(String str) =>
      HotelBenefit.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HotelBenefit.fromMap(Map<String, dynamic> json) => HotelBenefit(
        longDescription: json["longDescription"],
        shortDescription: json["shortDescription"],
      );

  Map<String, dynamic> toMap() => {
        "longDescription": longDescription,
        "shortDescription": shortDescription,
      };
}

class Facility {
  Facility({
    this.key,
    this.value,
  });

  final String? key;
  final String? value;

  factory Facility.fromJson(String str) => Facility.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Facility.fromMap(Map<String, dynamic> json) => Facility(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "key": key,
        "value": value,
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
