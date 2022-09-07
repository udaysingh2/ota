import 'dart:convert';

class CarDetailDomainModel {
  CarDetailDomainModel({
    this.carDetailInfo,
    this.carStatus,
  });

  CarDetailInfo? carDetailInfo;
  CarDetailStatus? carStatus;

  factory CarDetailDomainModel.fromJson(String str) =>
      CarDetailDomainModel.fromMap(json.decode(str));

  factory CarDetailDomainModel.fromMap(Map<String, dynamic> json) =>
      CarDetailDomainModel(
        carDetailInfo:
            json["data"] == null ? null : CarDetailInfo.fromMap(json["data"]),
        carStatus: json["status"] == null
            ? null
            : CarDetailStatus.fromMap(json["status"]),
      );
}

class CarDetailStatus {
  CarDetailStatus({
    required this.statusCode,
    required this.statusMsg,
  });

  final String statusCode;
  final String statusMsg;

  factory CarDetailStatus.fromMap(Map<String, dynamic> json) => CarDetailStatus(
        statusMsg: json["header"],
        statusCode: json["code"],
      );
}

class CarDetailInfo {
  CarInfo? carInfo;
  CarDetail? carDeatil;

  CarDetailInfo({
    this.carInfo,
    this.carDeatil,
  });

  factory CarDetailInfo.fromMap(Map<String, dynamic> json) => CarDetailInfo(
        carInfo:
            json["carInfo"] == null ? null : CarInfo.fromMap(json["carInfo"]),
        carDeatil: json["carDetail"] == null
            ? null
            : CarDetail.fromMap(json["carDetail"]),
      );
}

class CarDetail {
  CarDetail(
      {this.id,
      this.allowLateReturn,
      this.car,
      this.supplier,
      this.pickupCounter,
      this.fromDate,
      this.toDate,
      this.currency,
      this.isIncludeDriver,
      this.isPromotion,
      this.includesInfo,
      this.carRentalConditionsInfo,
      this.pickupConditionsInfo,
      this.description,
      this.rateKey,
      this.refCode,
      this.totalPrice,
      this.pricePerDay,
      this.termsAndCondition,
      this.returnCounter,
      this.promotions,
      this.returnExtraCharge});

  String? id;
  int? allowLateReturn;
  Car? car;
  Supplier? supplier;
  Counter? pickupCounter;
  DateTime? fromDate;
  DateTime? toDate;
  String? currency;
  String? isIncludeDriver;
  String? isPromotion;
  String? includesInfo;
  String? carRentalConditionsInfo;
  String? pickupConditionsInfo;
  String? description;
  String? rateKey;
  String? refCode;
  double? totalPrice;
  double? pricePerDay;
  String? termsAndCondition;
  Counter? returnCounter;
  List<Promotion>? promotions;
  double? returnExtraCharge;

  factory CarDetail.fromMap(Map<String, dynamic> json) => CarDetail(
      id: json["id"],
      allowLateReturn: json["allowLateReturn"],
      car: json["car"] == null ? null : Car.fromMap(json["car"]),
      supplier:
          json["supplier"] == null ? null : Supplier.fromMap(json["supplier"]),
      pickupCounter: json["pickupCounter"] == null
          ? null
          : Counter.fromMap(json["pickupCounter"]),
      fromDate:
          json["fromDate"] == null ? null : DateTime.parse(json["fromDate"]),
      toDate: json["toDate"] == null ? null : DateTime.parse(json["toDate"]),
      currency: json["currency"],
      isIncludeDriver: json["isIncludeDriver"].toString(),
      isPromotion: json["isPromotion"].toString(),
      includesInfo: json["includesInfo"],
      carRentalConditionsInfo: json["carRentalConditionsInfo"],
      pickupConditionsInfo: json["pickupConditionsInfo"],
      description: json["description"],
      rateKey: json["rateKey"],
      refCode: json["refCode"],
      totalPrice: json["totalPrice"] == null
          ? null
          : double.tryParse("${json["totalPrice"]}"),
      pricePerDay: json["pricePerDay"] == null
          ? null
          : double.tryParse("${json["pricePerDay"]}"),
      termsAndCondition: json["termsAndCondition"],
      returnCounter: json["returnCounter"] == null
          ? null
          : Counter.fromMap(json["returnCounter"]),
      promotions: json["promotionList"] == null
          ? null
          : List<Promotion>.from(
              json["promotionList"].map((x) => Promotion.fromMap(x))),
      returnExtraCharge: json["returnExtraCharge"] == null
          ? null
          : double.tryParse("${json["returnExtraCharge"]}"));
}

class Promotion {
  Promotion({
    this.productId,
    this.productType,
    this.promotionType,
    this.promotionCode,
    this.line1,
    this.line2,
    this.title,
    this.description,
    this.web,
    this.iconImage,
    this.bannerDescDisplay,
  });

  final String? productId;
  final String? productType;
  final String? promotionType;
  final String? promotionCode;
  final String? line1;
  final String? line2;
  final String? title;
  final String? description;
  final String? web;
  final String? iconImage;
  final bool? bannerDescDisplay;

  factory Promotion.fromJson(String str) => Promotion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Promotion.fromMap(Map<String, dynamic> json) => Promotion(
        productId: json["productId"],
        productType: json["productType"],
        promotionType: json["promotionType"],
        promotionCode: json["promotionCode"],
        line1: json["line1"],
        line2: json["line2"],
        title: json["title"],
        description: json["description"],
        web: json["web"],
        iconImage: json["iconImage"],
        bannerDescDisplay: json["bannerDescDisplay"],
      );

  Map<String, dynamic> toMap() => {
        "productId": productId,
        "productType": productType,
        "promotionType": promotionType,
        "promotionCode": promotionCode,
        "line1": line1,
        "line2": line2,
        "title": title,
        "description": description,
        "web": web,
        "iconImage": iconImage,
        "bannerDescDisplay": bannerDescDisplay,
      };
}

class CarInfo {
  CarInfo({
    this.id,
    this.name,
    this.brand,
    this.crafttype,
    this.images,
  });

  String? id;
  String? name;
  String? brand;
  String? crafttype;
  Images? images;

  factory CarInfo.fromMap(Map<String, dynamic> json) => CarInfo(
        id: json["id"],
        name: json["name"],
        brand: json["brand"],
        crafttype: json["crafttype"],
        images: Images.fromJson(json["images"]),
      );
}

class Car {
  Car({
    this.id,
    this.name,
    this.brand,
    this.crafttype,
    this.seatNbr,
    this.doorNbr,
    this.bagLargeNbr,
    this.bagSmallNbr,
    this.engine,
    this.gear,
    this.facilities,
    this.images,
    this.year,
    this.color,
    this.fuelType,
    this.description,
    this.generalInfo,
    this.conditionInfo,
  });

  String? id;
  String? name;
  String? brand;
  String? crafttype;
  String? seatNbr;
  String? doorNbr;
  String? bagLargeNbr;
  String? bagSmallNbr;
  String? engine;
  String? gear;
  List<String>? facilities;
  Images? images;
  String? year;
  String? color;
  String? fuelType;
  String? description;
  String? generalInfo;
  String? conditionInfo;

  factory Car.fromMap(Map<String, dynamic> json) => Car(
        id: json["id"],
        name: json["name"],
        brand: json["brand"],
        crafttype: json["crafttype"],
        seatNbr: json["seatNbr"],
        doorNbr: json["doorNbr"],
        bagLargeNbr: json["bagLargeNbr"],
        bagSmallNbr: json["bagSmallNbr"],
        engine: json["engine"],
        gear: json["gear"],
        facilities: json["facilities"] == null
            ? null
            : List<String>.from(json["facilities"].map((x) => x)),
        images: Images.fromJson(json["images"]),
        year: json["year"],
        color: json["color"],
        fuelType: json["fuelType"],
        description: json["description"],
        generalInfo: json["generalInfo"],
        conditionInfo: json["conditionInfo"],
      );
}

class Images {
  Images({
    this.thumb,
    this.full,
  });

  String? thumb;
  String? full;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        thumb: json["thumb"],
        full: json["full"],
      );
}

class Counter {
  Counter({
    this.id,
    this.name,
    this.address,
    this.cityName,
    this.locationId,
    this.locationName,
    this.opentime,
    this.closetime,
    this.description,
    this.latitude,
    this.longitude,
  });

  String? id;
  String? name;
  String? address;
  String? cityName;
  String? locationId;
  String? locationName;
  String? opentime;
  String? closetime;
  String? description;
  String? latitude;
  String? longitude;

  factory Counter.fromMap(Map<String, dynamic> json) => Counter(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        cityName: json["cityName"],
        locationId: json["locationId"],
        locationName: json["locationName"],
        opentime: json["opentime"],
        closetime: json["closetime"],
        description: json["description"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );
}

class Supplier {
  Supplier({
    this.id,
    this.name,
    this.logo,
  });

  String? id;
  String? name;
  Logo? logo;

  factory Supplier.fromMap(Map<String, dynamic> json) => Supplier(
        id: json["id"],
        name: json["name"],
        logo: json["logo"] == null ? null : Logo.fromMap(json["logo"]),
      );
}

class Logo {
  Logo({
    this.url,
  });

  String? url;

  factory Logo.fromMap(Map<String, dynamic> json) => Logo(
        url: json["url"],
      );
}
