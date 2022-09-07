import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_reservation/helpers/car_reservation_helper.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';
import '../../../../core/app_routes_test.dart';

void main(){
  BuildContext? context = MockBuildContext();
  CarDetailInfoModel? carDetailInfoModel = CarDetailInfoModel(isCarAvailable: false,bookingUrn: "URN123",);
  test("CarDetailHelper", (){
    CarDetailInfoDataViewModel carDetailInfoDataViewModel =  CarReservationHelper.getCarDetailInfo(carDetailInfoModel, context);
    expect(carDetailInfoDataViewModel.carInfo.title, "");
  });

}