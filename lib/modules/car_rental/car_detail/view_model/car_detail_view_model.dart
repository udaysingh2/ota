import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_argument_model.dart';
import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_model.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_view_model.dart';

import '../helper/car_detail_helper.dart';
import 'car_detail_argument_model.dart';

class CarDetailViewModel {
  CarDetailInfoModel? carDetailInfo;
  CarDetailViewPageState pageState;
  CarDetailViewModel({
    required this.pageState,
    this.carDetailInfo,
  });
}

class CarDetailInfoModel {
  CarInfoModel? carInfo;
  CarDetailModel? carDetail;
  DateTime? fromDate;
  DateTime? toDate;

  CarDetailInfoModel({
    this.carInfo,
    this.carDetail,
    this.fromDate,
    this.toDate,
  });

  CarDetailInfoModel.mapFromCarDetailInfo(
      CarDetailInfo carDetailInfo,
      CarDetailArgumentModel? argument,
      DateTime? oldFromDate,
      DateTime? oldToDate) {
    carInfo = carDetailInfo.carInfo == null
        ? null
        : CarInfoModel.mapFromCarInfo(carDetailInfo.carInfo!);
    carDetail = carDetailInfo.carDeatil == null
        ? null
        : CarDetailModel.mapFromCarDetail(carDetailInfo.carDeatil!);
    fromDate = oldFromDate;
    toDate = oldToDate;
  }

  CarDetailDomainArgumentModel toCarDetailDomainArgumentModel(
      CarDetailArgumentModel? argument) {
    return CarDetailDomainArgumentModel(
      carId: argument?.carId ?? '',
      pickupLocationId: argument?.pickupLocationId ?? '',
      returnLocationId: argument?.returnLocationId ?? '',
      pickupDate: Helpers.getyyyyMMddTHHmmssFromDateTime(fromDate),
      returnDate: Helpers.getyyyyMMddTHHmmssFromDateTime(toDate),
      supplierId: argument?.supplierId ?? '',
      includeDriver: argument?.includeDriver ?? '',
      residenceCountry: argument?.residenceCountry ?? '',
      currency: argument?.currency ?? '',
      rentalType: argument?.rentalType ?? '',
      age: argument?.age ?? AppConfig().configModel.carDriverDefaultAge,
      pickupCounter: argument?.pickupCounter ?? '',
      returnCounter: argument?.returnCounter ?? '',
    );
  }
}

class CarDetailModel {
  CarDetailModel(
      {this.id,
      this.allowLateReturn,
      this.car,
      this.pickupCounter,
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
  CarModel? car;
  SuplierModel? supplier;
  CounterModel? pickupCounter;
  CounterModel? returnCounter;

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
  List<OtaFreeFoodPromotionModel>? promotions;
  CarRentalDetailHeartButtonType? hotelDetailHeartButtonType;
  double? returnExtraCharge;

  CarDetailModel.mapFromCarDetail(CarDetail carDetail) {
    id = carDetail.car?.id;
    allowLateReturn = carDetail.allowLateReturn ?? 0;
    car = carDetail.car == null ? null : CarModel.mapFromCar(carDetail.car!);
    supplier = carDetail.supplier == null
        ? null
        : SuplierModel.mapFromSuplier(carDetail.supplier!);

    pickupCounter = carDetail.pickupCounter == null
        ? null
        : CounterModel.mapFromCounter(carDetail.pickupCounter!);
    returnCounter = carDetail.returnCounter == null
        ? null
        : CounterModel.mapFromCounter(carDetail.returnCounter!);
    id = carDetail.car?.id;
    currency = carDetail.currency;
    currency = carDetail.currency;
    isIncludeDriver = carDetail.isIncludeDriver;
    isPromotion = carDetail.isPromotion;
    includesInfo = carDetail.includesInfo;
    carRentalConditionsInfo = carDetail.carRentalConditionsInfo;
    pickupConditionsInfo = carDetail.pickupConditionsInfo;
    description = carDetail.description;
    rateKey = carDetail.rateKey;
    refCode = carDetail.refCode;
    totalPrice = carDetail.totalPrice;
    pricePerDay = carDetail.pricePerDay;
    termsAndCondition = carDetail.termsAndCondition;
    promotions = CarDetailHelper.generatePromotion(carDetail.promotions);
    returnExtraCharge = carDetail.returnExtraCharge;
  }
}

class PromotionModelData {
  String? productId;
  String? productType;
  String? promotionType;
  String? promotionCode;
  String? line1;
  String? line2;
  DateTime? startDate;
  DateTime? endDate;
  String? type;
  String? message;
  String? description;
  String? rateCode;
  String? web;
  String? title;

  PromotionModelData({
    this.productId,
    this.productType,
    this.promotionType,
    this.promotionCode,
    this.line1,
    this.line2,
    this.startDate,
    this.endDate,
    this.type,
    this.message,
    this.description,
    this.rateCode,
    this.web,
    this.title,
  });
}

class CarInfoModel {
  CarInfoModel({
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
  ImagesModel? images;

  CarInfoModel.mapFromCarInfo(CarInfo carInfo) {
    id = carInfo.id;
    name = carInfo.name;
    brand = carInfo.brand;
    crafttype = carInfo.crafttype;
    images = carInfo.images == null
        ? null
        : ImagesModel.mapFromImages(carInfo.images!);
  }
}

class CarModel {
  CarModel({
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
  ImagesModel? images;
  String? year;
  String? color;
  String? fuelType;
  String? description;
  String? generalInfo;
  String? conditionInfo;

  CarModel.mapFromCar(Car car) {
    id = car.id;
    name = car.name;
    brand = car.brand;
    crafttype = car.crafttype;
    seatNbr = car.seatNbr;
    doorNbr = car.doorNbr;
    bagLargeNbr = car.bagLargeNbr;
    bagSmallNbr = car.bagSmallNbr;
    engine = car.engine;
    gear = car.gear;
    facilities = car.facilities;
    images = car.images == null ? null : ImagesModel.mapFromImages(car.images!);
    year = car.year;
    color = car.color;
    fuelType = car.fuelType;
    description = car.description;
    generalInfo = car.generalInfo;
    conditionInfo = car.conditionInfo;
  }
}

class SuplierModel {
  SuplierModel({
    this.id,
    this.name,
    this.logo,
  });

  String? id;
  String? name;
  String? logo;

  SuplierModel.mapFromSuplier(Supplier supplier) {
    id = supplier.id;
    name = supplier.name;
    logo = supplier.logo?.url;
  }
}

class ImagesModel {
  ImagesModel({
    this.thumb,
    this.full,
  });

  String? thumb;
  String? full;

  ImagesModel.mapFromImages(Images images) {
    thumb = images.thumb;
    full = images.full;
  }
}

class CounterModel {
  CounterModel({
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

  CounterModel.mapFromCounter(Counter counter) {
    id = counter.id;
    name = counter.name;
    address = counter.address;
    cityName = counter.cityName;
    locationId = counter.locationId;
    locationName = counter.locationName;
    opentime = counter.opentime;
    closetime = counter.closetime;
    description = counter.description;
    latitude = counter.latitude;
    longitude = counter.longitude;
  }
}

enum CarDetailViewPageState {
  loading,
  noData,
  success,
  failure,
  failureNetwork,
}
enum CarRentalDetailHeartButtonType {
  disabled,
  selected,
  unselected,
}

class CarDetailsInfoDataViewModel {
  List<CarDetailInfoCell> carDetailsPickUp;
  List<CarDetailInfoCell> carDetailsDropOff;
  List<CarDetailInfoCell> carDetails;
  CarDetailInfoCarMainData carInfo;
  CarDetailInfoPricing pricing;

  CarDetailsInfoDataViewModel(
      {required this.carDetailsPickUp,
      required this.carDetailsDropOff,
      required this.carDetails,
      required this.carInfo,
      required this.pricing});
}
