import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/view_model/promo_widget_view_model.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/car_rental/car_reservation/bloc/car_reservation_update.dart';
import 'package:ota/modules/favourites/bloc/favourite_update.dart';
import 'package:ota/modules/hotel/hotel_detail/model/hotel_update.dart';
import 'package:ota/modules/hotel/hotel_success_payment/view_model/hotel_success_payment_argument_model.dart';
import 'package:ota/modules/landing/view_model/landing_page_view_model.dart';
import 'package:ota/modules/ota_reservation_success/view_model/ota_reservation_success_argument_model.dart';
import 'package:provider/provider.dart';
import '../../car_rental/car_rental_search_result/view_model/car_dates_location_update_view_model.dart';
import '../../car_rental/car_reservation/view_model/car_reservation_add_on_view_model.dart';

LoginModel getLoginProvider() {
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    return LoginModel(env: Environment.dev);
  }
  return Provider.of<LoginModel>(GlobalKeys.navigatorKey.currentContext!,
      listen: false);
}

class ProviderInitializer extends StatelessWidget {
  final Widget materialApp;
  const ProviderInitializer(this.materialApp, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return LoginModel();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return HotelDetailStatus();
          },
        ),
        Provider(
          create: (BuildContext context) {
            return LandingPageViewModel();
          },
        ),
        Provider(
          create: (BuildContext context) {
            return HotelSuccessPaymentArgumentModel();
          },
        ),
        Provider(
          create: (BuildContext context) {
            return OtaReservationSuccessArgumentModel();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return FavouriteUpdate();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return CarReservationAddOnViewModel();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return CarDatesLocationUpdateViewModel();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return CarReservationUpdate();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return PromoWidgetViewModel();
          },
        ),
      ],
      child: materialApp,
    );
  }
}
