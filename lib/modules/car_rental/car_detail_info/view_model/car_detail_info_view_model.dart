import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_argument_model.dart';

class CarDetailInfoViewModel {
  CarDetailInfoViewModelType carDetailInfoViewModelType;
  CarDetailInfoPickType carDetailInfoPickType;
  CarDetailInfoPickup carDetailInfoPickup;
  CarDetailInfoDropOff carDetailInfoDropOff;
  CarDetailInfoCarInfo carDetailInfoCarInfo;
  LocationDataModel? pickupLocation;
  LocationDataModel? dropOffLocation;

  CarDetailInfoViewModel({
    required this.carDetailInfoCarInfo,
    required this.carDetailInfoDropOff,
    required this.carDetailInfoPickType,
    required this.carDetailInfoPickup,
    required this.carDetailInfoViewModelType,
    this.pickupLocation,
    this.dropOffLocation,
  });
  factory CarDetailInfoViewModel.empty() {
    return CarDetailInfoViewModel(
      carDetailInfoViewModelType: CarDetailInfoViewModelType.initial,
      carDetailInfoPickType: CarDetailInfoPickType.carDetailInfoPickup,
      carDetailInfoCarInfo: CarDetailInfoCarInfo(
          carDetails: [],
          facilityList: [],
          pricing: CarDetailInfoPricing(costPerDay: "0", totalCost: "0")),
      carDetailInfoDropOff: CarDetailInfoDropOff(
          carDetails: [],
          carInfo: CarDetailInfoCarMainData(
            title: "",
            imagePath: "",
          ),
          pricing: CarDetailInfoPricing(costPerDay: "0", totalCost: "0")),
      carDetailInfoPickup: CarDetailInfoPickup(
        carDetails: [],
        carInfo: CarDetailInfoCarMainData(
          title: "",
          imagePath: "",
        ),
        pricing: CarDetailInfoPricing(costPerDay: "0", totalCost: "0"),
      ),
    );
  }
}

enum CarDetailInfoViewModelType {
  initial,
  loading,
  loaded,
}
enum CarDetailInfoPickType {
  carDetailInfoPickup,
  carDetailInfoDropOff,
  carDetailInfoCarInfo,
}

class CarDetailInfoPickup {
  List<CarDetailInfoCell> carDetails;
  CarDetailInfoPricing pricing;
  CarDetailInfoCarMainData carInfo;
  CarDetailInfoPickup({
    required this.carDetails,
    required this.carInfo,
    required this.pricing,
  });
}

class CarDetailInfoDropOff {
  List<CarDetailInfoCell> carDetails;
  CarDetailInfoPricing pricing;
  CarDetailInfoCarMainData carInfo;
  CarDetailInfoDropOff({
    required this.carDetails,
    required this.carInfo,
    required this.pricing,
  });
}

class CarDetailInfoCarInfo {
  List<CarDetailInfoCell> carDetails;
  List<String> facilityList;
  CarDetailInfoPricing pricing;
  CarDetailInfoCarInfo(
      {required this.carDetails,
      required this.facilityList,
      required this.pricing});
}

class CarDetailInfoCarMainData {
  String imagePath;
  String title;
  CarDetailInfoCarMainData({
    required this.imagePath,
    required this.title,
  });
}

class CarDetailInfoPricing {
  String costPerDay;
  String totalCost;
  CarDetailInfoPricing({
    required this.costPerDay,
    required this.totalCost,
  });
}

class CarDetailInfoCell {
  String imagePath;
  String title;
  String subTitle;
  bool isHtmlField;
  CarDetailInfoCell({
    required this.imagePath,
    required this.subTitle,
    required this.title,
    this.isHtmlField = false,
  });
}
