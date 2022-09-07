import 'dart:convert';

class CarSupplierModelDomain {
  CarSupplierModelDomain({
    this.data,
  });

  final CarSupplierModelDomainData? data;

  factory CarSupplierModelDomain.fromJson(String str) =>
      CarSupplierModelDomain.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarSupplierModelDomain.fromMap(Map<String, dynamic> json) =>
      CarSupplierModelDomain(
        data: json["data"] == null
            ? null
            : CarSupplierModelDomainData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class CarSupplierModelDomainData {
  CarSupplierModelDomainData({
    this.getCarRentalSupplier,
  });

  final GetCarRentalSupplier? getCarRentalSupplier;

  factory CarSupplierModelDomainData.fromJson(String str) =>
      CarSupplierModelDomainData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarSupplierModelDomainData.fromMap(Map<String, dynamic> json) =>
      CarSupplierModelDomainData(
        getCarRentalSupplier: json["getCarRentalSupplier"] == null
            ? null
            : GetCarRentalSupplier.fromMap(json["getCarRentalSupplier"]),
      );

  Map<String, dynamic> toMap() => {
        "getCarRentalSupplier": getCarRentalSupplier?.toMap(),
      };
}

class GetCarRentalSupplier {
  GetCarRentalSupplier({
    this.status,
    this.data,
  });

  final Status? status;
  final GetCarRentalSupplierData? data;

  factory GetCarRentalSupplier.fromJson(String str) =>
      GetCarRentalSupplier.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetCarRentalSupplier.fromMap(Map<String, dynamic> json) =>
      GetCarRentalSupplier(
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
        data: json["data"] == null
            ? null
            : GetCarRentalSupplierData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status?.toMap(),
        "data": data?.toMap(),
      };
}

class GetCarRentalSupplierData {
  GetCarRentalSupplierData(
      {this.supplierData, this.promotionList, this.freeFoodDelivery});

  final List<SupplierDatum>? supplierData;
  final List<PromotionList>? promotionList;
  final bool? freeFoodDelivery;

  factory GetCarRentalSupplierData.fromJson(String str) =>
      GetCarRentalSupplierData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GetCarRentalSupplierData.fromMap(Map<String, dynamic> json) =>
      GetCarRentalSupplierData(
        supplierData: json["supplierData"] == null
            ? null
            : List<SupplierDatum>.from(
                json["supplierData"].map((x) => SupplierDatum.fromMap(x))),
        promotionList: json["promotionList"] == null
            ? null
            : List<PromotionList>.from(
                json["promotionList"].map((x) => PromotionList.fromMap(x))),
        freeFoodDelivery: json["freeFoodDelivery"],
      );

  Map<String, dynamic> toMap() => {
        "supplierData": supplierData == null
            ? null
            : List<dynamic>.from(supplierData!.map((x) => x.toMap())),
        "promotionList": promotionList == null
            ? null
            : List<dynamic>.from(promotionList!.map((x) => x.toMap())),
        "freeFoodDelivery": freeFoodDelivery
      };
}

class PromotionList {
  PromotionList({
    this.productType,
    this.promotionCode,
    this.title,
    this.line1,
    this.line2,
    this.description,
    this.web,
  });

  final String? productType;
  final String? promotionCode;
  final String? title;
  final String? line1;
  final String? line2;
  final String? description;
  final String? web;

  factory PromotionList.fromJson(String str) =>
      PromotionList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PromotionList.fromMap(Map<String, dynamic> json) => PromotionList(
        productType: json["productType"],
        promotionCode: json["promotionCode"],
        title: json["title"],
        line1: json["line1"],
        line2: json["line2"],
        description: json["description"],
        web: json["web"],
      );

  Map<String, dynamic> toMap() => {
        "productType": productType,
        "promotionCode": promotionCode,
        "title": title,
        "line1": line1,
        "line2": line2,
        "description": description,
        "web": web,
      };
}

class SupplierDatum {
  SupplierDatum({
    this.id,
    this.allowLateReturn,
    this.supplier,
    this.car,
    this.fromDate,
    this.toDate,
    this.currency,
    this.totalPrice,
    this.pricePerDay,
    this.returnExtraCharge,
    this.pickupCounterId,
    this.returnCounterId,
    this.rateKey,
    this.refCode,
  });

  final String? id;
  final int? allowLateReturn;
  final Supplier? supplier;
  final Car? car;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? currency;
  final double? totalPrice;
  final double? pricePerDay;
  final String? returnExtraCharge;
  final String? pickupCounterId;
  final String? returnCounterId;
  final String? rateKey;
  final String? refCode;

  factory SupplierDatum.fromJson(String str) =>
      SupplierDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SupplierDatum.fromMap(Map<String, dynamic> json) => SupplierDatum(
      id: json["id"],
      allowLateReturn: json["allowLateReturn"],
      supplier: Supplier.fromMap(json["supplier"]),
      car: Car.fromMap(json["car"]),
      fromDate: DateTime.parse(json["fromDate"]),
      toDate: DateTime.parse(json["toDate"]),
      currency: json["currency"],
      totalPrice: json["totalPrice"] == null
          ? null
          : double.tryParse("${json["totalPrice"]}"),
      pricePerDay: json["pricePerDay"] == null
          ? null
          : double.tryParse("${json["pricePerDay"]}"),
      pickupCounterId: json["pickupCounterId"],
      returnCounterId: json["returnCounterId"],
      rateKey: json["rateKey"],
      refCode: json["refCode"],
      returnExtraCharge: json["returnExtraCharge"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "allowLateReturn": allowLateReturn,
        "supplier": supplier?.toMap(),
        "car": car?.toMap(),
        "fromDate": fromDate == null
            ? null
            : "${fromDate?.year.toString().padLeft(4, '0')}-${fromDate?.month.toString().padLeft(2, '0')}-${fromDate?.day.toString().padLeft(2, '0')}",
        "toDate": toDate == null
            ? null
            : "${toDate?.year.toString().padLeft(4, '0')}-${toDate?.month.toString().padLeft(2, '0')}-${toDate?.day.toString().padLeft(2, '0')}",
        "currency": currency,
        "totalPrice": totalPrice,
        "pricePerDay": pricePerDay,
        "pickupCounterId": pickupCounterId,
        "returnCounterId": returnCounterId,
        "rateKey": rateKey,
        "refCode": refCode,
      };
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
    this.images,
  });

  final String? id;
  final String? name;
  final String? brand;
  final String? crafttype;
  final String? seatNbr;
  final String? doorNbr;
  final String? bagLargeNbr;
  final String? bagSmallNbr;
  final String? engine;
  final String? gear;
  final Images? images;

  factory Car.fromJson(String str) => Car.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

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
        images: json["images"] == null ? null : Images.fromMap(json["images"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "brand": brand,
        "crafttype": crafttype,
        "seatNbr": seatNbr,
        "doorNbr": doorNbr,
        "bagLargeNbr": bagLargeNbr,
        "bagSmallNbr": bagSmallNbr,
        "engine": engine,
        "gear": gear,
        "images": images?.toMap(),
      };
}

class Images {
  Images({
    this.thumb,
    this.full,
  });

  final String? thumb;
  final String? full;

  factory Images.fromJson(String str) => Images.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Images.fromMap(Map<String, dynamic> json) => Images(
        thumb: json["thumb"],
        full: json["full"],
      );

  Map<String, dynamic> toMap() => {
        "thumb": thumb,
        "full": full,
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
        logo: Logo.fromMap(json["logo"]),
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
  });

  final String? url;

  factory Logo.fromJson(String str) => Logo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Logo.fromMap(Map<String, dynamic> json) => Logo(
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "url": url,
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
