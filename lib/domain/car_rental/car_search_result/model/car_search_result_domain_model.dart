import 'dart:convert';

class CarSearchResultDomainModel {
  CarSearchResultDomainModel({
    this.status,
    this.data,
  });

  final Status? status;
  final CarRentalSearchResult? data;

  factory CarSearchResultDomainModel.fromString(String str) =>
      CarSearchResultDomainModel.fromMap(json.decode(str));

  factory CarSearchResultDomainModel.fromMap(Map<String, dynamic>? json) =>
      CarSearchResultDomainModel(
        status:
            json?["status"] == null ? null : Status.fromMap(json?["status"]),
        data: json?["data"] == null
            ? null
            : CarRentalSearchResult.fromMap(json?["data"]),
      );
}

class CarRentalSearchResult {
  CarRentalSearchResult({
    this.carRental,
  });

  final CarRental? carRental;

  factory CarRentalSearchResult.fromMap(Map<String, dynamic> json) =>
      CarRentalSearchResult(
        carRental: json["carRental"] == null
            ? null
            : CarRental.fromMap(json["carRental"]),
      );
}

class CarRental {
  CarRental({
    this.carModelList,
    this.availableFilter,
    this.pickupLocationId,
    this.returnLocationId,
  });

  final List<CarModelList>? carModelList;
  final AvailableFilterModel? availableFilter;
  final String? pickupLocationId;
  final String? returnLocationId;

  factory CarRental.fromMap(Map<String, dynamic> json) => CarRental(
        carModelList: json["carModelList"] == null
            ? null
            : List<CarModelList>.from(
                json["carModelList"].map((x) => CarModelList.fromMap(x))),
        availableFilter: json["availableFilter"] == null
            ? null
            : AvailableFilterModel.fromMap(json["availableFilter"]),
        pickupLocationId: json["pickupLocationId"],
        returnLocationId: json["returnLocationId"],
      );
}

class AvailableFilterModel {
  final List<CarBrand>? carBrand;
  final List<CarType>? carType;
  final List<CarSupplier>? carSupplier;
  final List<PromotionModel>? promotionList;
  final double? minPrice;
  final double? maxPrice;

  AvailableFilterModel({
    this.carBrand,
    this.carType,
    this.carSupplier,
    this.promotionList,
    this.minPrice,
    this.maxPrice,
  });

  factory AvailableFilterModel.fromMap(Map<String, dynamic> json) =>
      AvailableFilterModel(
        minPrice: json["minPrice"] == null
            ? null
            : double.tryParse("${json["minPrice"]}"),
        maxPrice: json["maxPrice"] == null
            ? null
            : double.tryParse("${json["maxPrice"]}"),
        carBrand: json["carBrand"] == null
            ? null
            : List<CarBrand>.from(
                json["carBrand"].map((x) => CarBrand.fromMap(x))),
        carType: json["carType"] == null
            ? null
            : List<CarType>.from(
                json["carType"].map((x) => CarType.fromMap(x))),
        carSupplier: json["carSupplier"] == null
            ? null
            : List<CarSupplier>.from(
                json["carSupplier"].map((x) => CarSupplier.fromMap(x))),
        promotionList: json["capsulePromotion"] == null
            ? null
            : List<PromotionModel>.from(
                json["capsulePromotion"].map((x) => PromotionModel.fromMap(x))),
      );
}

class CarBrand {
  CarBrand({
    this.carBrandId,
    this.name,
  });

  final String? carBrandId;
  final String? name;

  factory CarBrand.fromJson(String str) => CarBrand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarBrand.fromMap(Map<String, dynamic> json) => CarBrand(
    carBrandId: "${json["carBrandId"]}",
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "carBrandId": carBrandId,
    "name": name,
  };
}

class CarSupplier {
  CarSupplier({
    this.carSupplierId,
    this.name,
  });

  final String? carSupplierId;
  final String? name;

  factory CarSupplier.fromJson(String str) => CarSupplier.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarSupplier.fromMap(Map<String, dynamic> json) => CarSupplier(
    carSupplierId: "${json["carSupplierId"]}",
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "carSupplierId": carSupplierId,
    "name": name,
  };
}

class CarType {
  CarType({
    this.carTypeId,
    this.name,
  });

  final String? carTypeId;
  final String? name;

  factory CarType.fromJson(String str) => CarType.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarType.fromMap(Map<String, dynamic> json) => CarType(
    carTypeId: "${json["carTypeId"]}",
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "carTypeId": carTypeId,
    "name": name,
  };
}


class FilterModel {
  FilterModel({
    this.id,
    this.name,
  });

  final String? id;
  final String? name;

  factory FilterModel.fromMap(Map<String, dynamic> json) => FilterModel(
        id: "${json["id"]}",
        name: json["name"],
      );
}

class PromotionModel {
  PromotionModel({
    this.code,
    this.name,
  });

  final String? code;
  final String? name;

  factory PromotionModel.fromMap(Map<String, dynamic> json) => PromotionModel(
        code: json["code"],
        name: json["name"],
      );
}

class CarModelList {
  CarModelList({
    this.sortSequence,
    this.carId,
    this.brandId,
    this.brandName,
    this.modelName,
    this.carInfo,
    this.images,
    this.startingPrice,
    this.numSuppliers,
    this.overlayPromotion,
    this.capsulePromotion,
  });

  final int? sortSequence;
  final String? carId;
  final String? brandId;
  final String? brandName;
  final String? modelName;
  final CarInfo? carInfo;
  final Images? images;
  final double? startingPrice;
  final int? numSuppliers;
  final OverlayPromotion? overlayPromotion;
  final List<PromotionModel>? capsulePromotion;

  factory CarModelList.fromMap(Map<String, dynamic> json) => CarModelList(
        sortSequence: json["sortSequence"],
        carId: "${json["carId"]}",
        brandId: "${json["brandId"]}",
        brandName: json["brandName"],
        modelName: json["modelName"],
        carInfo:
            json["carInfo"] == null ? null : CarInfo.fromMap(json["carInfo"]),
        images: json["images"] == null ? null : Images.fromMap(json["images"]),
        startingPrice: json["startingPrice"] == null
            ? null
            : double.tryParse("${json["startingPrice"]}"),
        numSuppliers: json["numSuppliers"] == null
            ? null
            : int.tryParse("${json["numSuppliers"]}"),
      overlayPromotion: json["overlayPromotion"] == null ? null : OverlayPromotion.fromMap(json["overlayPromotion"]),
        capsulePromotion: json["capsulePromotion"] == null
            ? null
            : List<PromotionModel>.from(
                json["capsulePromotion"].map((x) => PromotionModel.fromMap(x))),
      );
}

class CarInfo {
  CarInfo({
    this.carTypeId,
    this.carTypeName,
  });

  final String? carTypeId;
  final String? carTypeName;

  factory CarInfo.fromMap(Map<String, dynamic> json) => CarInfo(
        carTypeId: "${json["carTypeId"]}",
        carTypeName: json["carTypeName"],
      );
}

class Images {
  Images({
    this.thumb,
    this.full,
  });

  final String? thumb;
  final String? full;

  factory Images.fromMap(Map<String, dynamic> json) => Images(
        thumb: json["thumb"],
        full: json["full"],
      );
}

class Status {
  Status({
    this.code,
    this.header,
  });

  final String? code;
  final String? header;

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        code: json["code"],
        header: json["header"],
      );
}

class OverlayPromotion {
  OverlayPromotion({
    this.adminPromotionLine1,
    this.adminPromotionLine2,
  });
  final String? adminPromotionLine1;
  final String? adminPromotionLine2;

  factory OverlayPromotion.fromJson(String str) =>
      OverlayPromotion.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OverlayPromotion.fromMap(Map<String, dynamic> json) =>
      OverlayPromotion(
        adminPromotionLine1: json["adminPromotionLine1"],
        adminPromotionLine2: json["adminPromotionLine2"],
      );

  Map<String, dynamic> toMap() => {
        "adminPromotionLine1": adminPromotionLine1,
        "adminPromotionLine2": adminPromotionLine2,
      };
}
