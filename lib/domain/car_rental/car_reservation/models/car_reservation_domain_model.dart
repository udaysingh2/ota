// To parse this JSON data, do
//
//     final carReservationScreenDomainData = carReservationScreenDomainDataFromMap(jsonString);

import 'dart:convert';

class CarReservationScreenDomain {
  CarReservationScreenDomain({
    this.data,
  });

  final CarReservationScreenDomain? data;

  factory CarReservationScreenDomain.fromJson(String str) =>
      CarReservationScreenDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarReservationScreenDomain.fromMap(Map<String, dynamic> json) =>
      CarReservationScreenDomain(
        data: json["data"] == null
            ? null
            : CarReservationScreenDomain.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class CarReservationScreenDomainData {
  CarReservationScreenDomainData({
    this.getCarInitiateBookingResponse,
  });

  final GetCarInitiateBookingResponse? getCarInitiateBookingResponse;

  factory CarReservationScreenDomainData.fromJson(String str) =>
      CarReservationScreenDomainData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarReservationScreenDomainData.fromMap(Map<String, dynamic> json) =>
      CarReservationScreenDomainData(
        getCarInitiateBookingResponse:
            json["getCarInitiateBookingResponse"] == null
                ? null
                : GetCarInitiateBookingResponse.fromMap(
                    json["getCarInitiateBookingResponse"]),
      );

  Map<String, dynamic> toMap() => {
        "getCarInitiateBookingResponse": getCarInitiateBookingResponse?.toMap(),
      };
}

class GetCarInitiateBookingResponse {
  GetCarInitiateBookingResponse({
    this.data,
    this.status,
  });

  final GetCarInitiateBookingResponseData? data;
  final Status? status;

  factory GetCarInitiateBookingResponse.fromJson(String str) =>
      GetCarInitiateBookingResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetCarInitiateBookingResponse.fromMap(Map<String, dynamic> json) =>
      GetCarInitiateBookingResponse(
        data: json["data"] == null
            ? null
            : GetCarInitiateBookingResponseData.fromMap(json["data"]),
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "status": status?.toMap(),
      };
}

class GetCarInitiateBookingResponseData {
  GetCarInitiateBookingResponseData({
    this.bookingUrn,
    this.id,
    this.allowLateReturn,
    this.rentalDays,
    this.image,
    this.fromDate,
    this.toDate,
    this.currency,
    this.isIncludeDriver,
    this.isPromotion,
    this.generalInfo,
    this.conditionInfo,
    this.description,
    this.includeDriver,
    this.promotion,
    this.promotionList,
    this.extraCharges,
    this.cancellationPolicy,
    this.returnCounter,
    this.ratePerDays,
    this.pickupCounter,
    this.supplier,
    this.car,
  });

  final String? bookingUrn;
  final int? id;
  final int? allowLateReturn;
  final int? rentalDays;
  final String? image;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? currency;
  final bool? isIncludeDriver;
  final bool? isPromotion;
  final String? generalInfo;
  final String? conditionInfo;
  final String? description;
  final bool? includeDriver;
  final bool? promotion;
  final List<PromotionList>? promotionList;
  final List<ExtraCharge>? extraCharges;
  final List<CancellationPolicy>? cancellationPolicy;
  final ReturnCounter? returnCounter;
  final RatePerDays? ratePerDays;
  final PickupCounter? pickupCounter;
  final Supplier? supplier;
  final Car? car;

  factory GetCarInitiateBookingResponseData.fromJson(String str) =>
      GetCarInitiateBookingResponseData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetCarInitiateBookingResponseData.fromMap(
          Map<String, dynamic> json) =>
      GetCarInitiateBookingResponseData(
        bookingUrn: json["bookingUrn"],
        id: json["id"],
        allowLateReturn: json["allowLateReturn"],
        rentalDays: json["rentalDays"],
        image: json["image"],
        fromDate: DateTime.parse(json["fromDate"]),
        toDate: DateTime.parse(json["toDate"]),
        currency: json["currency"],
        isIncludeDriver: json["isIncludeDriver"],
        isPromotion: json["isPromotion"],
        generalInfo: json["generalInfo"],
        conditionInfo: json["conditionInfo"],
        description: json["description"],
        includeDriver: json["includeDriver"],
        promotion: json["promotion"],
        promotionList: json["promotionList"] == null
            ? null
            : List<PromotionList>.from(
                json["promotionList"].map((x) => PromotionList.fromMap(x))),
        extraCharges: json["extraCharges"] == null
            ? null
            : List<ExtraCharge>.from(
                json["extraCharges"].map((x) => ExtraCharge.fromMap(x))),
        cancellationPolicy: json["cancellationPolicy"] == null
            ? null
            : List<CancellationPolicy>.from(json["cancellationPolicy"]
                .map((x) => CancellationPolicy.fromMap(x))),
        returnCounter: json["returnCounter"] == null
            ? null
            : ReturnCounter.fromMap(json["returnCounter"]),
        ratePerDays: json["ratePerDays"] == null
            ? null
            : RatePerDays.fromMap(json["ratePerDays"]),
        pickupCounter: json["pickupCounter"] == null
            ? null
            : PickupCounter.fromMap(json["pickupCounter"]),
        supplier: json["supplier"] == null
            ? null
            : Supplier.fromMap(json["supplier"]),
        car: json["car"] == null ? null : Car.fromMap(json["car"]),
      );

  Map<String, dynamic> toMap() => {
        "bookingUrn": bookingUrn,
        "id": id,
        "allowLateReturn": allowLateReturn,
        "rentalDays": rentalDays,
        "image": image,
        "fromDate": fromDate == null
            ? null
            : "${fromDate?.year.toString().padLeft(4, '0')}-${fromDate?.month.toString().padLeft(2, '0')}-${fromDate?.day.toString().padLeft(2, '0')}",
        "toDate": toDate == null
            ? null
            : "${toDate?.year.toString().padLeft(4, '0')}-${toDate?.month.toString().padLeft(2, '0')}-${toDate?.day.toString().padLeft(2, '0')}",
        "currency": currency,
        "isIncludeDriver": isIncludeDriver,
        "isPromotion": isPromotion,
        "generalInfo": generalInfo,
        "conditionInfo": conditionInfo,
        "description": description,
        "includeDriver": includeDriver,
        "promotion": promotion,
        "promotionList": promotionList == null
            ? null
            : List<dynamic>.from(promotionList!.map((x) => x.toMap())),
        "extraCharges": extraCharges == null
            ? null
            : List<dynamic>.from(extraCharges!.map((x) => x.toMap())),
        "cancellationPolicy": cancellationPolicy == null
            ? null
            : List<dynamic>.from(cancellationPolicy!.map((x) => x.toMap())),
        "returnCounter": returnCounter?.toMap(),
        "ratePerDays": ratePerDays?.toMap(),
        "pickupCounter": pickupCounter?.toMap(),
        "supplier": supplier?.toMap(),
        "car": car?.toMap(),
      };
}

class CancellationPolicy {
  CancellationPolicy({
    this.cancelDays,
    this.message,
  });

  final int? cancelDays;
  final String? message;

  factory CancellationPolicy.fromJson(String str) =>
      CancellationPolicy.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CancellationPolicy.fromMap(Map<String, dynamic> json) =>
      CancellationPolicy(
        cancelDays: json["cancelDays"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "cancelDays": cancelDays,
        "message": message,
      };
}

class Car {
  Car({
    this.id,
    this.name,
    this.nameBy,
    this.brand,
    this.crafttype,
    this.seatNbr,
    this.doorNbr,
    this.bagLargeNbr,
    this.bagSmallNbr,
    this.engine,
    this.gear,
    this.year,
    this.color,
    this.fuelType,
    this.licensePlateNbr,
    this.description,
    this.generalInfo,
    this.conditionInfo,
    this.facilities,
  });

  final int? id;
  final String? name;
  final String? nameBy;
  final String? brand;
  final String? crafttype;
  final int? seatNbr;
  final int? doorNbr;
  final int? bagLargeNbr;
  final int? bagSmallNbr;
  final String? engine;
  final String? gear;
  final int? year;
  final String? color;
  final String? fuelType;
  final String? licensePlateNbr;
  final String? description;
  final String? generalInfo;
  final String? conditionInfo;
  final List<String>? facilities;

  factory Car.fromJson(String str) => Car.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Car.fromMap(Map<String, dynamic> json) => Car(
        id: json["id"],
        name: json["name"],
        nameBy: json["nameBy"],
        brand: json["brand"],
        crafttype: json["crafttype"],
        seatNbr: json["seatNbr"],
        doorNbr: json["doorNbr"],
        bagLargeNbr: json["bagLargeNbr"],
        bagSmallNbr: json["bagSmallNbr"],
        engine: json["engine"],
        gear: json["gear"],
        year: json["year"],
        color: json["color"],
        fuelType: json["fuelType"],
        licensePlateNbr: json["licensePlateNbr"],
        description: json["description"],
        generalInfo: json["generalInfo"],
        conditionInfo: json["conditionInfo"],
        facilities: json["facilities"] == null
            ? null
            : List<String>.from(json["facilities"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "nameBy": nameBy,
        "brand": brand,
        "crafttype": crafttype,
        "seatNbr": seatNbr,
        "doorNbr": doorNbr,
        "bagLargeNbr": bagLargeNbr,
        "bagSmallNbr": bagSmallNbr,
        "engine": engine,
        "gear": gear,
        "year": year,
        "color": color,
        "fuelType": fuelType,
        "licensePlateNbr": licensePlateNbr,
        "description": description,
        "generalInfo": generalInfo,
        "conditionInfo": conditionInfo,
        "facilities": facilities == null
            ? null
            : List<dynamic>.from(facilities!.map((x) => x)),
      };
}

class ExtraCharge {
  ExtraCharge({
    this.id,
    this.carRateId,
    this.fromDate,
    this.toDate,
    this.price,
    this.isCompulsory,
    this.chargeType,
    this.description,
    this.extraChargeGroup,
  });

  final int? id;
  final int? carRateId;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int? price;
  final bool? isCompulsory;
  final int? chargeType;
  final String? description;
  final ExtraChargeGroup? extraChargeGroup;

  factory ExtraCharge.fromJson(String str) =>
      ExtraCharge.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExtraCharge.fromMap(Map<String, dynamic> json) => ExtraCharge(
        id: json["id"],
        carRateId: json["car_rate_id"],
        fromDate:
            json["fromDate"] == null ? null : DateTime.parse(json["fromDate"]),
        toDate: json["toDate"] == null ? null : DateTime.parse(json["toDate"]),
        price: json["price"],
        isCompulsory: json["isCompulsory"],
        chargeType: json["chargeType"],
        description: json["description"],
        extraChargeGroup: json["extraChargeGroup"] == null
            ? null
            : ExtraChargeGroup.fromMap(json["extraChargeGroup"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "car_rate_id": carRateId,
        "fromDate": fromDate == null
            ? null
            : "${fromDate?.year.toString().padLeft(4, '0')}-${fromDate?.month.toString().padLeft(2, '0')}-${fromDate?.day.toString().padLeft(2, '0')}",
        "toDate": toDate == null
            ? null
            : "${toDate?.year.toString().padLeft(4, '0')}-${toDate?.month.toString().padLeft(2, '0')}-${toDate?.day.toString().padLeft(2, '0')}",
        "price": price,
        "isCompulsory": isCompulsory,
        "chargeType": chargeType,
        "description": description,
        "extraChargeGroup": extraChargeGroup?.toMap(),
      };
}

class ExtraChargeGroup {
  ExtraChargeGroup({
    this.id,
    this.name,
    this.description,
  });

  final int? id;
  final String? name;
  final String? description;

  factory ExtraChargeGroup.fromJson(String str) =>
      ExtraChargeGroup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExtraChargeGroup.fromMap(Map<String, dynamic> json) =>
      ExtraChargeGroup(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
      };
}

class PickupCounter {
  PickupCounter({
    this.id,
    this.name,
    this.address,
    this.countryId,
    this.countryName,
    this.cityId,
    this.cityName,
    this.locationId,
    this.locationName,
    this.latitude,
    this.longitude,
    this.opentime,
    this.closetime,
    this.description,
  });

  final int? id;
  final String? name;
  final String? address;
  final String? countryId;
  final String? countryName;
  final String? cityId;
  final String? cityName;
  final String? locationId;
  final String? locationName;
  final String? latitude;
  final String? longitude;
  final String? opentime;
  final String? closetime;
  final String? description;

  factory PickupCounter.fromJson(String str) =>
      PickupCounter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PickupCounter.fromMap(Map<String, dynamic> json) => PickupCounter(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        countryId: json["countryId"],
        countryName: json["countryName"],
        cityId: json["cityId"],
        cityName: json["cityName"],
        locationId: json["locationId"],
        locationName: json["locationName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        opentime: json["opentime"],
        closetime: json["closetime"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "address": address,
        "countryId": countryId,
        "countryName": countryName,
        "cityId": cityId,
        "cityName": cityName,
        "locationId": locationId,
        "locationName": locationName,
        "latitude": latitude,
        "longitude": longitude,
        "opentime": opentime,
        "closetime": closetime,
        "description": description,
      };
}

class PromotionList {
  PromotionList({
    this.productType,
    this.promotionCode,
    this.title,
    this.description,
    this.web,
    this.image,
    this.bannerDescDisplay,
    this.line1,
    this.line2,
    this.productId,
    this.promotionType,
  });

  final String? productType;
  final String? promotionCode;
  final String? title;
  final String? description;
  final String? web;
  final String? image;
  final bool? bannerDescDisplay;
  final String? line1;
  final String? line2;
  final String? productId;
  final String? promotionType;

  factory PromotionList.fromJson(String str) =>
      PromotionList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PromotionList.fromMap(Map<String, dynamic> json) => PromotionList(
        productType: json["productType"],
        promotionCode: json["promotionCode"],
        title: json["title"],
        description: json["description"],
        web: json["web"],
        image: json["iconImage"],
        bannerDescDisplay: json["bannerDescDisplay"],
        line1: json["line1"],
        line2: json["line2"],
        productId: json["productId"],
        promotionType: json["promotionType"],
      );

  Map<String, dynamic> toMap() => {
        "productType": productType,
        "promotionCode": promotionCode,
        "title": title,
        "description": description,
        "web": web,
        "iconImage": image,
        "bannerDescDisplay": bannerDescDisplay,
        "line1": line1,
        "line2": line2,
        "productId": productId,
        "promotionType": promotionType,
      };
}

class RatePerDays {
  RatePerDays({
    this.ratePerDay,
    this.rateKey,
    this.refCode,
    this.minDay,
    this.minAge,
    this.maxAge,
    this.totalDays,
    this.isMileageLimit,
    this.mileageDescription,
    this.conditionInfo,
    this.returnCounter,
    this.returnExtraCharge,
    this.totalDaysExtraCharge,
    this.extraChargesCompulsory,
    this.total,
  });

  final double? ratePerDay;
  final String? rateKey;
  final String? refCode;
  final String? minDay;
  final String? minAge;
  final String? maxAge;
  final double? totalDays;
  final bool? isMileageLimit;
  final String? mileageDescription;
  final String? conditionInfo;
  final dynamic returnCounter;
  final int? returnExtraCharge;
  final double? totalDaysExtraCharge;
  final int? extraChargesCompulsory;
  final double? total;

  factory RatePerDays.fromJson(String str) =>
      RatePerDays.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RatePerDays.fromMap(Map<String, dynamic> json) => RatePerDays(
        ratePerDay: json["ratePerDay"].toDouble(),
        rateKey: json["rateKey"],
        refCode: json["refCode"],
        minDay: json["minDay"],
        minAge: json["minAge"],
        maxAge: json["maxAge"],
        totalDays: json["totalDays"].toDouble(),
        isMileageLimit: json["isMileageLimit"],
        mileageDescription: json["mileageDescription"],
        conditionInfo: json["conditionInfo"],
        returnCounter: json["returnCounter"],
        returnExtraCharge: json["returnExtraCharge"],
        totalDaysExtraCharge: json["totalDaysExtraCharge"].toDouble(),
        extraChargesCompulsory: json["extraChargesCompulsory"],
        total: json["total"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "ratePerDay": ratePerDay,
        "rateKey": rateKey,
        "refCode": refCode,
        "minDay": minDay,
        "minAge": minAge,
        "maxAge": maxAge,
        "totalDays": totalDays,
        "isMileageLimit": isMileageLimit,
        "mileageDescription": mileageDescription,
        "conditionInfo": conditionInfo,
        "returnCounter": returnCounter,
        "returnExtraCharge": returnExtraCharge,
        "totalDaysExtraCharge": totalDaysExtraCharge,
        "extraChargesCompulsory": extraChargesCompulsory,
        "total": total,
      };
}

class ReturnCounter {
  ReturnCounter({
    this.id,
    this.name,
    this.address,
    this.countryId,
    this.countryName,
    this.cityId,
    this.cityName,
    this.locationId,
    this.locationName,
    this.latitude,
    this.longitude,
    this.opentime,
    this.closetime,
    this.description,
  });

  final String? id;
  final String? name;
  final String? address;
  final String? countryId;
  final String? countryName;
  final String? cityId;
  final String? cityName;
  final String? locationId;
  final String? locationName;
  final String? latitude;
  final String? longitude;
  final String? opentime;
  final String? closetime;
  final String? description;

  factory ReturnCounter.fromJson(String str) =>
      ReturnCounter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReturnCounter.fromMap(Map<String, dynamic> json) => ReturnCounter(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        countryId: json["countryId"],
        countryName: json["countryName"],
        cityId: json["cityId"],
        cityName: json["cityName"],
        locationId: json["locationId"],
        locationName: json["locationName"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        opentime: json["opentime"],
        closetime: json["closetime"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "address": address,
        "countryId": countryId,
        "countryName": countryName,
        "cityId": cityId,
        "cityName": cityName,
        "locationId": locationId,
        "locationName": locationName,
        "latitude": latitude,
        "longitude": longitude,
        "opentime": opentime,
        "closetime": closetime,
        "description": description,
      };
}

class Supplier {
  Supplier({
    this.id,
    this.name,
    this.logo,
  });

  final String? id;
  final String? name;
  final Logo? logo;

  factory Supplier.fromJson(String str) => Supplier.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Supplier.fromMap(Map<String, dynamic> json) => Supplier(
        id: json["id"],
        name: json["name"],
        logo: json["logo"] == null ? null : Logo.fromMap(json["logo"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "logo": logo?.toMap(),
      };
}

class Logo {
  Logo({
    this.url,
    this.title,
    this.alt,
  });

  final String? url;
  final String? title;
  final String? alt;

  factory Logo.fromJson(String str) => Logo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Logo.fromMap(Map<String, dynamic> json) => Logo(
        url: json["url"],
        title: json["title"],
        alt: json["alt"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
        "title": title,
        "alt": alt,
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
