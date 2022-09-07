import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_argument_view_model.dart';

import 'car_detail_info_view_model.dart';

class CarDetailInfoArgumentModel {
  CarDetailInfoPickup carDetailInfoPickup;
  CarDetailInfoDropOff carDetailInfoDropOff;
  CarDetailInfoCarInfo carDetailInfoCarInfo;
  CarDetailInfoPickType carDetailInfoPickType;
  CarReservationViewArgumentModel? carReservationViewArgumentModel;
  bool isPriceWidgetVisible;
  LocationDataModel? pickupLocation;
  LocationDataModel? dropOffLocation;
  bool showMap;
  String? pickupLocationName;
  String? dropOffLocationName;
  double? returnExtraCharge;

  CarDetailInfoArgumentModel(
      {required this.carDetailInfoPickup,
      required this.carDetailInfoCarInfo,
      required this.carDetailInfoDropOff,
      required this.carDetailInfoPickType,
      this.carReservationViewArgumentModel,
      this.isPriceWidgetVisible = false,
      this.pickupLocation,
      this.dropOffLocation,
      this.showMap = false,
      this.pickupLocationName,
      this.dropOffLocationName,
      this.returnExtraCharge});
}

class LocationDataModel {
  String? lattitude;
  String? longitude;
  LocationDataModel({this.lattitude, this.longitude});
}
