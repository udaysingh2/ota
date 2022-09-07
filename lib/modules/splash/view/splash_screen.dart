import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ota/channels/hotel_detail_method_handler/models/hotel_detail_reponse_model_channel.dart';
import 'package:ota/channels/ota_booling_detail_handler/models/ota_booking_handler_model_channel.dart';
import 'package:ota/channels/ota_ereceipt_detail_handler/models/ota_ereceipt_handler_model_channel.dart';
import 'package:ota/channels/ota_landing_method_handler/models/ota_landing_handler_model_channel.dart';
import 'package:ota/channels/ota_landing_noti_method_handler/models/ota_landing_noti_handler_model_channel.dart';
import 'package:ota/channels/ota_property_method_handler/models/ota_property_reponse_model_channel.dart';
import 'package:ota/common/helpers/navigator_helper.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/car_rental/car_detail/view_model/car_detail_argument_model.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view_model/car_booking_detail_argument_model.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_detail_argument.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/ota_common/helper/ota_service_enabled_helper.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/splash/bloc/splash_bloc.dart';
import 'package:ota/modules/splash/channels/super_app_to_confirm_booking_details.dart';
import 'package:ota/modules/splash/channels/super_app_to_erecipt.dart';
import 'package:ota/modules/splash/channels/super_app_to_hotel_booking_detail.dart';
import 'package:ota/modules/splash/channels/super_app_to_landing.dart';
import 'package:ota/modules/splash/channels/super_app_to_landing_noti.dart';
import 'package:ota/modules/splash/channels/super_app_to_ota_property_detail.dart';
import 'package:ota/modules/splash/channels/super_app_to_property_detail.dart';
import 'package:ota/modules/splash/view_model/splash_model.dart';
import 'package:ota/modules/tickets/booking_details/view_model/ticket_booking_detail_argument.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_detail_argument.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';

///Initialise Screen specific dimensions or constant values here.
const _splashScreenAsset = 'assets/images/illustrations/default_bg_image.png';
const _kTourUrn = 'TR';
const _kTicketUrn = 'TT';
const _kCarUrn = 'C';
const String _kLandingKey = "LANDING";

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
  static bool isCalled = false;
}

class SplashScreenState extends State<SplashScreen> {
  final SplashBloc _splashBloc = SplashBloc();
  final SuperAppToLanding superAppToLanding = SuperAppToLanding();
  final SuperAppToPropertyDetail superAppToPropertyDetail =
      SuperAppToPropertyDetail();
  final SuperAppToOtaProperty superAppToOtaProperty = SuperAppToOtaProperty();
  final SuperAppToHotelBookingDetail superAppToHotelBookingDetail =
      SuperAppToHotelBookingDetail();
  final SuperAppToERecipt superAppToERecipt = SuperAppToERecipt();
  final SuperAppToLandingNoti superAppToLandingNoti = SuperAppToLandingNoti();
  final SuperAppToConfirmBookingDetails superAppToConfirmBookingDetails =
      SuperAppToConfirmBookingDetails();

  @override
  void initState() {
    /// [getSplashData] is an Event in the bloc.
    /// Where Api call will be made and Data will be updated
    /// in the Screen using bloc Builder.
    ///
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!SplashScreen.isCalled) {
        SplashScreen.isCalled = true;
        superAppToLanding.handle(
          onHandleSuccess: waitForSuperAppToPushLandingPage,
          context: context,
        );
        superAppToPropertyDetail.handle(
          context: context,
          onHandleSuccess: pushHotelDetailScreen,
        );
        superAppToOtaProperty.handle(
          context: context,
          onHandleSuccess: pushOtaPropertyDetailScreen,
        );
        superAppToHotelBookingDetail.handle(
          context: context,
          onHandleSuccess: waitForBookingDetails,
        );

        superAppToERecipt.handle(
          context: context,
          onHandleSuccess: waitForeRecipt,
        );
        superAppToLandingNoti.handle(
          context: context,
          onHandleSuccess: waitForOtiLandingNoti,
        );
        superAppToConfirmBookingDetails.handle(
          context: context,
        );
      }
    });

    super.initState();
  }

  void waitForOtiLandingNoti(OtaLandingNotiHandlerModelChannel data) async {
    _splashBloc.getSplashData();

    AppConfig.shared.updateConfigAndTranslation().then((value) {
      if (MyNavigatorObserver.routeStack.last.settings.name ==
          AppRoutes.landingPage) {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.landingPage,
        );
      } else {
        Navigator.pushNamed(
          context,
          AppRoutes.landingPage,
        );
      }
    });
  }

  void waitForeRecipt(OtaEReceiptHandlerModelChannel data) async {
    _splashBloc.getSplashData();
    String bookingType = OtaServiceType.hotel;
    if (data.orderId!.startsWith(_kTourUrn)) {
      bookingType = OtaServiceType.tour;
    } else if (data.orderId!.startsWith(_kTicketUrn)) {
      bookingType = OtaServiceType.ticket;
    } else if (data.orderId!.startsWith(_kCarUrn)) {
      bookingType = OtaServiceType.carRental;
    }
    switch (bookingType) {
      case OtaServiceType.tour:
        AppConfig.shared.updateConfigAndTranslation().then((value) {
          Navigator.pushNamed(
            context,
            AppRoutes.tourBookingDetailScreen,
            arguments: TourBookingDetailArgument(
              bookingId: data.confirmationNo!,
              bookingUrn: data.orderId!,
              bookingType: bookingType,
            ),
          );
        });
        return;
      case OtaServiceType.ticket:
        AppConfig.shared.updateConfigAndTranslation().then((value) {
          Navigator.pushNamed(
            context,
            AppRoutes.ticketBookingDetailScreen,
            arguments: TicketBookingDetailArgument(
              bookingId: data.confirmationNo!,
              bookingUrn: data.orderId!,
              bookingType: bookingType,
            ),
          );
        });
        return;
      case OtaServiceType.carRental:
        AppConfig.shared.updateConfigAndTranslation().then((value) {
          Navigator.pushNamed(
            context,
            AppRoutes.carBookingDetail,
            arguments: CarBookingDetailArgumentModel(
              bookingId: data.confirmationNo!,
              bookingUrn: data.orderId!,
              bookingType: bookingType,
            ),
          );
        });
        return;
      default:
        AppConfig.shared.updateConfigAndTranslation().then((value) {
          Navigator.pushNamed(context, AppRoutes.hotelBookingDetailScreen,
              arguments: HotelBookingDetailArgument(
                bookingUrn: data.orderId!,
                confirmationNo: data.confirmationNo!,
              ));
        });
    }
  }

  void pushHotelDetailScreen(PropertyDetailHandlerModelChannel data) {
    _splashBloc.getSplashData();
    LoginModel loginModel = getLoginProvider();
    AppConfig.shared.updateConfigAndTranslation().then((value) {
      Navigator.pushNamed(context, AppRoutes.hotelDetail,
          arguments: HotelDetailArgument.getDefaultArgumentForChannel(
              data.hotelId,
              data.cityId,
              data.countryId,
              loginModel.userType.getHotelDetailType()));
    });
  }

  void pushOtaPropertyDetailScreen(OtaPropertyHandlerModelChannel data) async {
    await Future.delayed(const Duration(seconds: 1));
    _splashBloc.getSplashData();
    AppConfig.shared.updateConfigAndTranslation().then((value) {
      Navigator.pushNamed(context, AppRoutes.landingPage);
      (data.productId == _kLandingKey)
          ? _pushServiceLandingScreen(data)
          : _pushServiceDetailScreen(data);
    });
  }

  void _pushServiceDetailScreen(OtaPropertyHandlerModelChannel data) {
    LoginModel loginModel = getLoginProvider();
    switch (data.serviceName) {
      case OtaServiceType.hotel:
        Navigator.pushNamed(
          context,
          AppRoutes.hotelDetail,
          arguments: HotelDetailArgument.getDefaultArgumentForChannel(
            data.productId,
            data.cityId,
            data.countryId,
            loginModel.userType.getHotelDetailType(),
          ),
        );
        break;
      case OtaServiceType.activity:
        if (OtaServiceEnabledHelper.isTourEnabled()) {
          Navigator.pushNamed(
            context,
            AppRoutes.tourDetailScreen,
            arguments: TourDetailArgument.fromOtaPropertyChannel(
              data.productId!,
              data.cityId!,
              data.countryId!,
              loginModel.userType,
            ),
          );
        } else {
          Navigator.pushNamed(context, AppRoutes.otaShareErrorScreen);
        }
        break;
      case OtaServiceType.ticket:
        if (OtaServiceEnabledHelper.isTourEnabled()) {
          Navigator.pushNamed(
            context,
            AppRoutes.ticketDetailScreen,
            arguments: TicketDetailArgument.fromOtaPropertyChannel(
              data.productId!,
              data.cityId!,
              data.countryId!,
              loginModel.userType,
            ),
          );
        } else {
          Navigator.pushNamed(context, AppRoutes.otaShareErrorScreen);
        }
        break;
      case OtaServiceType.carRental:
        if (OtaServiceEnabledHelper.isCarEnabled()) {
          final carIDSupplierID = data.productId?.split('-');
          Navigator.of(context).pushNamed(
            AppRoutes.carDetailScreen,
            arguments: CarDetailArgumentModel(
              carId: carIDSupplierID?[0] ?? "",
              pickupLocationId: data.pickupLocation ?? "",
              returnLocationId: data.returnLocation ?? "",
              pickupDate: Helpers.getOnlyDateFromDateTime(DateTime.now()).add(
                Duration(
                  days: AppConfig().configModel.pickUpDeltaCar,
                  hours: 10,
                ),
              ),
              returnDate: Helpers.getOnlyDateFromDateTime(DateTime.now()).add(
                Duration(
                  days: AppConfig().configModel.dropOffDeltaCar,
                  hours: 10,
                ),
              ),
              supplierId: carIDSupplierID?[1] ?? "",
              includeDriver: AppConfig().configModel.includeDriver,
              currency: AppConfig().currency,
              rentalType: AppConfig().rentalType,
              age: AppConfig().configModel.carDriverDefaultAge,
              pickupCounter: data.pickupCounter ?? "0",
              returnCounter: data.reuturnCounter ?? "0",
              userType: getLoginProvider().userType.getCarDetailType(),
            ),
          );
        } else {
          Navigator.pushNamed(context, AppRoutes.otaShareErrorScreen);
        }
        break;
      default:
        Navigator.pushNamed(context, AppRoutes.otaShareErrorScreen);
    }
  }

  void _pushServiceLandingScreen(OtaPropertyHandlerModelChannel data) {
    switch (data.serviceName) {
      case OtaServiceType.hotel:
        Navigator.pushNamed(
          context,
          AppRoutes.hotelLandingScreen,
        );
        break;
      case OtaServiceType.ticket:
      case OtaServiceType.activity:
        if (OtaServiceEnabledHelper.isTourEnabled()) {
          Navigator.pushNamed(
            context,
            AppRoutes.toursLandingScreen,
          );
        } else {
          Navigator.pushNamed(context, AppRoutes.otaLandingShareErrorScreen);
        }
        break;
      case OtaServiceType.carRental:
        if (OtaServiceEnabledHelper.isCarEnabled()) {
          Navigator.pushNamed(
            context,
            AppRoutes.carLandingScreen,
          );
        } else {
          Navigator.pushNamed(context, AppRoutes.otaLandingShareErrorScreen);
        }
        break;
      case (OtaServiceType.insurance):
        Navigator.pushNamed(
          context,
          AppRoutes.insuranceLandingScreen,
        );
        break;
      case (OtaServiceType.ota):
        break;
      default:
        Navigator.pushNamed(context, AppRoutes.otaLandingShareErrorScreen);
    }
  }

  void waitForBookingDetails(OtaBookingDetailHandlerModelChannel data) async {
    _splashBloc.getSplashData();
    String bookingType = OtaServiceType.hotel;
    if (data.orderId!.startsWith(_kTourUrn)) {
      bookingType = OtaServiceType.tour;
    } else if (data.orderId!.startsWith(_kTicketUrn)) {
      bookingType = OtaServiceType.ticket;
    } else if (data.orderId!.startsWith(_kCarUrn)) {
      bookingType = OtaServiceType.carRental;
    }
    switch (bookingType) {
      case OtaServiceType.tour:
        AppConfig.shared.updateConfigAndTranslation().then((value) {
          Navigator.pushNamed(
            context,
            AppRoutes.tourBookingDetailScreen,
            arguments: TourBookingDetailArgument(
              bookingId: data.confirmationNo!,
              bookingUrn: data.orderId!,
              bookingType: bookingType,
            ),
          );
        });
        return;
      case OtaServiceType.ticket:
        AppConfig.shared.updateConfigAndTranslation().then((value) {
          Navigator.pushNamed(
            context,
            AppRoutes.ticketBookingDetailScreen,
            arguments: TicketBookingDetailArgument(
              bookingId: data.confirmationNo!,
              bookingUrn: data.orderId!,
              bookingType: bookingType,
            ),
          );
        });
        return;
      case OtaServiceType.carRental:
        AppConfig.shared.updateConfigAndTranslation().then((value) {
          Navigator.pushNamed(
            context,
            AppRoutes.carBookingDetail,
            arguments: CarBookingDetailArgumentModel(
              bookingId: data.confirmationNo!,
              bookingUrn: data.orderId!,
              bookingType: bookingType,
            ),
          );
        });
        return;
      default:
        AppConfig.shared.updateConfigAndTranslation().then((value) {
          Navigator.pushNamed(context, AppRoutes.hotelBookingDetailScreen,
              arguments: HotelBookingDetailArgument(
                bookingUrn: data.orderId!,
                confirmationNo: data.confirmationNo!,
              ));
        });
    }
  }

  void waitForSuperAppToPushLandingPage(
      OtaLandingHandlerModelChannel data) async {
    _splashBloc.getSplashData();
    Timer(
      Duration(milliseconds: AppConfig().configModel.splashScreenDuration),
      () {
        AppConfig.shared.updateConfigAndTranslation().then((value) {
          if (MyNavigatorObserver.routeStack.last.settings.name ==
              AppRoutes.landingPage) {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.landingPage,
            );
          } else {
            Navigator.pushNamed(
              context,
              AppRoutes.landingPage,
            );
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _splashBloc,
        builder: () {
          return Stack(
            children: [
              _splashBloc.state.splashPageState ==
                      SplashPageState.splashImageLoaded
                  ? _buildImage()
                  : _defaultImage(),
              _buildText(),
            ],
          );
        },
      ),
    );
  }

  Container _buildText() {
    LoginModel loginModel = getLoginProvider();
    return Container(
      padding: const EdgeInsets.only(left: kSize24),
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: getTranslated(context, AppLocalizationsStrings.hello)
                  .addNextLine(),
              style: AppTheme.kHeadline2.copyWith(
                shadows: [kTextHardShadow],
                fontFamily: kFontFamily,
              ),
            ),
            TextSpan(
              text: loginModel.userName,
              style: AppTheme.kHeadline4.copyWith(
                shadows: [kTextHardShadow],
                fontFamily: kFontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _defaultImage() {
    return Image.asset(
      _splashScreenAsset,
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget _buildImage() {
    return CachedNetworkImage(
        imageUrl: _splashBloc.state.imgUrl!,
        fit: BoxFit.cover,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        errorWidget: (context, url, error) => _defaultImage(),
        placeholder: (context, url) => _defaultImage());
  }
}
