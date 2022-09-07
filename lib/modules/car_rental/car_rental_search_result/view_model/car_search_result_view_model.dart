import 'package:ota/domain/car_rental/car_search_result/model/car_search_result_domain_model.dart';

class CarSearchResultViewModel {
  CarSearchResultModel? carSearchResult;
  CarSearchResultPageState pageState;
  bool isInternetFailurePopUpShown = false;
  CarSearchResultViewModel({
    required this.pageState,
    this.carSearchResult,
  });
}

enum CarSearchResultPageState {
  initial,
  loading,
  filterLoading,
  success,
  failure,
  failureNetwork
}

class CarSearchResultModel {
  List<CarSearchDetailModel>? carModelList;
  AvailableFilterViewModel? availableFilterViewModel;

  CarSearchResultModel({
    this.carModelList,
    this.availableFilterViewModel,
  });
}

class AvailableFilterViewModel {
  final List<FilterViewModel>? carBrand;
  final List<FilterViewModel>? carType;
  final List<FilterViewModel>? carSupplier;
  final List<FilterViewModel>? promotionList;
  final double? minPrice;
  final double? maxPrice;

  AvailableFilterViewModel({
    this.carBrand,
    this.carType,
    this.carSupplier,
    this.promotionList,
    this.minPrice,
    this.maxPrice,
  });

  factory AvailableFilterViewModel.fromAvailableFilterModel(
      AvailableFilterModel availableFilterModel) {
    return AvailableFilterViewModel(
      minPrice: availableFilterModel.minPrice,
      maxPrice: availableFilterModel.maxPrice,
      carBrand: availableFilterModel.carBrand == null
          ? null
          : List<FilterViewModel>.from(availableFilterModel.carBrand!
              .map((x) => FilterViewModel.fromCarBrandModel(x))),
      carType: availableFilterModel.carType == null
          ? null
          : List<FilterViewModel>.from(availableFilterModel.carType!
              .map((x) => FilterViewModel.fromCarTypeModel(x))),
      carSupplier: availableFilterModel.carSupplier == null
          ? null
          : List<FilterViewModel>.from(availableFilterModel.carSupplier!
              .map((x) => FilterViewModel.fromCarSupplierModel(x))),
      promotionList: availableFilterModel.promotionList == null
          ? null
          : List<FilterViewModel>.from(availableFilterModel.promotionList!
              .map((x) => FilterViewModel.fromPromotionModel(x))),
    );
  }
}

class FilterViewModel {
  FilterViewModel({
    this.id,
    this.name,
  });

  final String? id;
  final String? name;

  factory FilterViewModel.fromCarBrandModel(CarBrand filterModel) {
    return FilterViewModel(
      id: filterModel.carBrandId,
      name: filterModel.name,
    );
  }
  factory FilterViewModel.fromCarTypeModel(CarType filterModel) {
    return FilterViewModel(
      id: filterModel.carTypeId,
      name: filterModel.name,
    );
  }
  factory FilterViewModel.fromCarSupplierModel(CarSupplier filterModel) {
    return FilterViewModel(
      id: filterModel.carSupplierId,
      name: filterModel.name,
    );
  }
  factory FilterViewModel.fromPromotionModel(PromotionModel promotionModel) {
    return FilterViewModel(
      id: promotionModel.code,
      name: promotionModel.name,
    );
  }
}

class PromotionViewModel {
  PromotionViewModel({
    this.code,
    this.name,
  });

  final String? code;
  final String? name;

  factory PromotionViewModel.fromFilterModel(PromotionModel promotionModel) {
    return PromotionViewModel(
      code: promotionModel.code,
      name: promotionModel.name,
    );
  }
}

class CarSearchDetailModel {
  CarSearchDetailModel({
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
  final CarInfoModel? carInfo;
  final ImagesModel? images;
  final double? startingPrice;
  final int? numSuppliers;
  final OverlayPromotion? overlayPromotion;
  final List<PromotionModel>? capsulePromotion;

  factory CarSearchDetailModel.fromCarModelList(CarModelList carModelList) {
    return CarSearchDetailModel(
      sortSequence: carModelList.sortSequence,
      carId: carModelList.carId,
      brandId: carModelList.brandId,
      brandName: carModelList.brandName,
      modelName: carModelList.modelName,
      carInfo: carModelList.carInfo == null
          ? null
          : CarInfoModel.fromCarInfo(carModelList.carInfo!),
      images: carModelList.images == null
          ? null
          : ImagesModel.fromImages(carModelList.images!),
      startingPrice: carModelList.startingPrice,
      numSuppliers: carModelList.numSuppliers,
      overlayPromotion: carModelList.overlayPromotion,
      capsulePromotion: carModelList.capsulePromotion,
    );
  }
}

class CarInfoModel {
  CarInfoModel({
    this.carTypeId,
    this.carTypeName,
  });

  final String? carTypeId;
  final String? carTypeName;

  factory CarInfoModel.fromCarInfo(CarInfo? carInfo) {
    return CarInfoModel(
      carTypeId: carInfo?.carTypeId,
      carTypeName: carInfo?.carTypeName,
    );
  }
}

class ImagesModel {
  ImagesModel({
    this.thumb,
    this.full,
  });

  final String? thumb;
  final String? full;

  factory ImagesModel.fromImages(Images image) {
    return ImagesModel(
      thumb: image.thumb,
      full: image.full,
    );
  }
}
