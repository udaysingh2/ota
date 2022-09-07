import 'package:ota/domain/search/models/ota_search_model.dart';

class CarVerticalListViewModel {
  CarRentalVerticalData? carRentalVerticalData;
  CarVerticalListPageState pageState;
  bool isInternetFailurePopUpShown = false;
  CarVerticalListViewModel({
    required this.pageState,
    this.carRentalVerticalData,
  });
}

enum CarVerticalListPageState { preLoaded, success, internetFailure }

class CarRentalVerticalData {
  CarRentalVerticalData({
    this.carModelList,
    this.pickupLocationId,
    this.returnLocationId,
  });

  final List<CarVerticalList>? carModelList;
  final String? pickupLocationId;
  final String? returnLocationId;

  factory CarRentalVerticalData.fromCarRentalModel(CarRental? argument) {
    return CarRentalVerticalData(
      carModelList: (argument?.carModelList ?? [])
          .map((e) => CarVerticalList.fromCarVerticalList(e))
          .toList(),
      pickupLocationId: argument?.pickupLocationId,
      returnLocationId: argument?.returnLocationId,
    );
  }
}

class CarVerticalList {
  CarVerticalList({
    this.carId,
    this.brandId,
    this.brandName,
    this.suppliers,
    this.overlayPromotion,
    this.modelName,
    this.images,
    this.carInfo,
    this.capsulePromotion,
  });

  final int? carId;
  final int? brandId;
  final String? brandName;
  final List<SupplierModel>? suppliers;
  final OverlayPromotionModel? overlayPromotion;
  final String? modelName;
  final ImagesModel? images;
  final CarVerticalInfo? carInfo;
  List<CapsulePromotionModel>? capsulePromotion;

  factory CarVerticalList.fromCarVerticalList(CarModelList? argument) {
    return CarVerticalList(
      carId: argument?.carId,
      brandId: argument?.brandId,
      suppliers: (argument?.suppliers ?? [])
          .map((e) => SupplierModel.fromSupplier(e))
          .toList(),
      overlayPromotion: OverlayPromotionModel.fromOverlayPromotion(
          argument?.overlayPromotion),
      brandName: argument?.brandName,
      modelName: argument?.modelName,
      images: ImagesModel.fromImagesModel(argument?.images),
      carInfo: CarVerticalInfo.fromCarInfo(argument?.carInfo),
      capsulePromotion: (argument?.capsulePromotion ?? [])
          .map((e) => CapsulePromotionModel.fromCapsulePromotionModel(e))
          .toList(),
    );
  }
}

class CarVerticalInfo {
  CarVerticalInfo({
    this.carTypeName,
    this.carTypeId,
  });

  final String? carTypeName;
  final int? carTypeId;

  factory CarVerticalInfo.fromCarInfo(CarInfo? argument) {
    return CarVerticalInfo(
      carTypeName: argument?.carTypeName,
      carTypeId: argument?.carTypeId,
    );
  }
}

class OverlayPromotionModel {
  OverlayPromotionModel({
    this.adminPromotionLine1,
    this.adminPromotionLine2,
  });
  final String? adminPromotionLine1;
  final String? adminPromotionLine2;

  factory OverlayPromotionModel.fromOverlayPromotion(
      OverlayPromotion? argument) {
    return OverlayPromotionModel(
      adminPromotionLine1: argument?.adminPromotionLine1,
      adminPromotionLine2: argument?.adminPromotionLine2,
    );
  }
}

class CapsulePromotionModel {
  CapsulePromotionModel({
    this.name,
    this.code,
  });

  final String? name;
  final String? code;

  factory CapsulePromotionModel.fromCapsulePromotionModel(
      CapsulePromotion? argument) {
    return CapsulePromotionModel(
      name: argument?.name,
      code: argument?.code,
    );
  }
}

class ImagesModel {
  ImagesModel({
    this.full,
    this.thumb,
  });

  final String? full;
  final String? thumb;

  factory ImagesModel.fromImagesModel(Images? argument) {
    return ImagesModel(
      full: argument?.full,
      thumb: argument?.thumb,
    );
  }
}

class SupplierModel {
  SupplierModel({
    this.pickupCounter,
    this.returnCounter,
  });

  final CounterModel? pickupCounter;
  final CounterModel? returnCounter;

  factory SupplierModel.fromSupplier(Supplier? argument) {
    return SupplierModel(
      pickupCounter: CounterModel.fromCounter(argument?.pickupCounter),
      returnCounter: CounterModel.fromCounter(argument?.returnCounter),
    );
  }
}

class CounterModel {
  CounterModel({
    this.locationId,
    this.address,
    this.name,
    this.description,
  });

  final String? locationId;
  final String? address;
  final String? name;
  final String? description;

  factory CounterModel.fromCounter(Counter? argument) {
    return CounterModel(
      locationId: argument?.locationId,
      address: argument?.address,
      name: argument?.name,
      description: argument?.description,
    );
  }
}
