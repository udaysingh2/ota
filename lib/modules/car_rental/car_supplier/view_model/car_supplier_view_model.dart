import 'package:ota/domain/car_rental/car_supplier/models/car_supplier_model_domain.dart';
import 'package:ota/modules/car_rental/car_supplier/helpers/car_supplier_helper.dart';

class CarSupplierViewModel {
  List<CarSupplierData> data;
  List<PromotionListData> promotionListData;
  CarSupplierViewModelState carSupplierViewModelState;
  bool freeFoodDelivery;
  CarSupplierViewModel({
    this.data = const [],
    this.promotionListData = const [],
    this.carSupplierViewModelState = CarSupplierViewModelState.none,
    this.freeFoodDelivery = false,
  });

  factory CarSupplierViewModel.fromList(CarSupplierModelDomainData list) {
    return CarSupplierViewModel(
        data: CarSupplierHelper.getCarSupplierList(
            list.getCarRentalSupplier?.data?.supplierData ?? []),
        promotionListData: CarSupplierHelper.getPromotionListData(
            list.getCarRentalSupplier?.data?.promotionList ?? []),
        carSupplierViewModelState: CarSupplierViewModelState.none,
        freeFoodDelivery: CarSupplierHelper.freeFoodFlag(list.getCarRentalSupplier?.data?.freeFoodDelivery));
  }
}

class CarSupplierData {
  SupplierData? supplier;
  int? allowLateReturn;
  CarData? car;
  DateTime? fromDate;
  DateTime? toDate;
  double? totalPrice;
  double? pricePerDay;
  String? pickupCounterId;
  String? returnCounterId;
  String? rateKey;
  String? refCode;
  String? returnExtraCharge;

  CarSupplierData(
      {this.supplier,
      this.car,
      this.fromDate,
      this.toDate,
      this.totalPrice,
      this.pricePerDay,
      this.pickupCounterId,
      this.returnCounterId,
      this.rateKey,
      this.refCode,
      this.allowLateReturn,
      this.returnExtraCharge});
}

class SupplierData {
  String? id;
  String? name;
  LogoData? logo;

  SupplierData({
    this.id = '',
    this.name = '',
    this.logo,
  });

  SupplierData.mapFromModel(Supplier? supplierData) {
    id = supplierData?.id ?? '';
    name = supplierData?.name ?? '';
    logo = LogoData.mapFromModel(supplierData?.logo);
  }
}

class PromotionListData {
  String? productType;
  String? promotionCode;
  String? title;
  String? line1;
  String? line2;
  String? description;
  String? web;

  PromotionListData({
    this.productType,
    this.promotionCode,
    this.title,
    this.line1,
    this.line2,
    this.description,
    this.web,
  });
}

class LogoData {
  String? logoUrl;
  LogoData({this.logoUrl = ''});
  LogoData.mapFromModel(Logo? logoData) {
    logoUrl = logoData?.url ?? '';
  }
}

class CarData {
  String brandName = '';
  String craftType = '';
  String seatNbr = '';
  String doorNbr = '';
  String bagLargeNbr = '';
  String bagSmallNbr = '';
  String gear = '';
  ImagesData? images;

  CarData.mapFromModel(Car? carData) {
    brandName = CarSupplierHelper.getCarBrandName(
        carData?.brand ?? '', carData?.name ?? ''); //carData?.brand ?? '';
    craftType = carData?.crafttype ?? '';
    seatNbr = carData?.seatNbr ?? '';
    doorNbr = carData?.doorNbr ?? '';
    bagLargeNbr = carData?.bagLargeNbr ?? '';
    bagSmallNbr = carData?.bagSmallNbr ?? '';
    gear = carData?.gear ?? '';
    images = ImagesData.mapFromModel(carData?.images);
  }
}

class ImagesData {
  String? thumbImageUrl;
  String? fullImageUrl;

  ImagesData({
    this.thumbImageUrl,
    this.fullImageUrl,
  });

  ImagesData.mapFromModel(Images? imagesData) {
    thumbImageUrl = imagesData?.thumb;
    fullImageUrl = imagesData?.full;
  }
}

enum CarSupplierViewModelState {
  none,
  loading,
  pullDownLoading,
  success,
  failure,
  failureNetwork
}
