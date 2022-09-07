import 'package:flutter/material.dart';
import 'package:ota/channels/booking_customer_register_invoke/models/booking_customer_register_argument_model_channel.dart';
import 'package:ota/channels/booking_customer_register_invoke/usecases/booking_customer_register_use_cases.dart';
import 'package:ota/channels/register_confirm_booking_handler/models/register_confirm_booking_model_channel.dart';
import 'package:ota/common/helpers/navigator_helper.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_bottom_sheet.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_banner/ota_banner.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_location_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_map_launcher.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/car_rental/car_detail/bloc/car_detail_bloc.dart';
import 'package:ota/modules/car_rental/car_detail/view/widget/car_detail_price_widget.dart';
import 'package:ota/modules/car_rental/car_detail_info/bloc/car_detail_info_bloc.dart';
import 'package:ota/modules/car_rental/car_detail_info/channels/super_app_to_confirm_register_booking.dart';
import 'package:ota/modules/car_rental/car_detail_info/view/widgets/car_detail_info_chip_list.dart';
import 'package:ota/modules/car_rental/car_detail_info/view/widgets/car_detail_info_listing_view.dart';
import 'package:ota/modules/car_rental/car_detail_info/view/widgets/car_detail_info_logo.dart';
import 'package:ota/modules/car_rental/car_detail_info/view/widgets/car_detail_info_title.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_listing_model.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_view_model.dart';
import 'package:ota/modules/car_rental/car_reservation/bloc/car_reservation_update.dart';
import 'package:provider/provider.dart';

const String _kExclamationIcon = "assets/images/icons/uil_info-circle.svg";
const String _kTickIcon = "assets/images/icons/uil_check-circle.svg";

const _kMapIcon = "assets/images/icons/gradient_map_icon.svg";

class CarDetailInfoScreen extends StatefulWidget {
  const CarDetailInfoScreen({Key? key}) : super(key: key);

  @override
  State<CarDetailInfoScreen> createState() => _CarDetailInfoScreenState();
}

class _CarDetailInfoScreenState extends State<CarDetailInfoScreen> {
  final CarDetailInfoBloc carDetailInfoBloc = CarDetailInfoBloc();
  final CarDetailViewBloc _carDetailViewBloc = CarDetailViewBloc();
  CarDetailInfoArgumentModel? argument;
  final SuperAppToCarRegisterConfirmBooking
      superAppToCarRegisterConfirmBooking =
      SuperAppToCarRegisterConfirmBooking();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      argument = ModalRoute.of(context)?.settings.arguments
          as CarDetailInfoArgumentModel;
      if (argument == null) return;
      carDetailInfoBloc.updateViewModelFromArgument(argument!);
      superAppToCarRegisterConfirmBooking.handle(
        context: context,
        onHandleSuccess: waitForReplyFromSuperApp,
      );
    });
  }

  @override
  void dispose() {
    superAppToCarRegisterConfirmBooking.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: _getBody(),
        appBar: _getAppBar(),
      ),
    );
  }

  Widget _getBody() {
    return BlocBuilder(
        bloc: _carDetailViewBloc,
        builder: () {
          return BlocBuilder(
            bloc: carDetailInfoBloc,
            builder: () {
              if (carDetailInfoBloc.state.carDetailInfoViewModelType !=
                  CarDetailInfoViewModelType.loaded) return const SizedBox();
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarDetailInfoChipList(
                        chipButtonList: [
                          getTranslated(
                              context, AppLocalizationsStrings.pickUpLocation),
                          getTranslated(
                              context, AppLocalizationsStrings.returnLocation),
                          getTranslated(
                              context, AppLocalizationsStrings.carDetails),
                        ],
                        selectedIndex: carDetailInfoBloc.getSelectedIndex(),
                        onTap: carDetailInfoBloc.onTappedByIndex,
                      ),
                      Expanded(
                        child: _getScrollableData(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom +
                            ((argument?.isPriceWidgetVisible ?? false)
                                ? kSize74
                                : 0),
                      ),
                    ],
                  ),
                  if (argument?.isPriceWidgetVisible == true)
                    CarDeatilPriceWidget(
                      pricePerDay: carDetailInfoBloc
                              .getPriceBasedOnState()
                              .costPerDay
                              .toDouble() ??
                          0,
                      totalPrice: carDetailInfoBloc
                              .getPriceBasedOnState()
                              .totalCost
                              .toDouble() ??
                          0,
                      onPressed: () async {
                        LoginModel loginModel = getLoginProvider();
                        if (loginModel.userType == UserType.loggedInUser) {
                          await Navigator.pushNamed(
                            context,
                            AppRoutes.carReservationScreen,
                            arguments:
                                argument?.carReservationViewArgumentModel,
                          );
                          CarReservationUpdate carReservationUpdate =
                              Provider.of<CarReservationUpdate>(context,
                                  listen: false);
                          if (carReservationUpdate.isCarDetailUpdated) {
                            Navigator.of(context).pop();
                          }
                        } else {
                          showModalBottomSheet<void>(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(kSize24),
                                  topRight: Radius.circular(kSize24),
                                ),
                              ),
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: AppColors.kLight100,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(kSize24),
                                              topRight:
                                                  Radius.circular(kSize24))),
                                      child: OtaAlertBottomSheet(
                                        leftButtonText: getTranslated(context,
                                            AppLocalizationsStrings.cancel),
                                        rightButtonText: getTranslated(
                                            context,
                                            AppLocalizationsStrings
                                                .registerPopupRegisterButton),
                                        alertText: getTranslated(
                                            context,
                                            AppLocalizationsStrings
                                                .accountProceedLabel),
                                        alertTitle: getTranslated(
                                            context,
                                            AppLocalizationsStrings
                                                .registerPopupHeader),
                                        onLeftButtonTap: () {
                                          Navigator.pop(context);
                                        },
                                        onRightButtonTap: () {
                                          waitForSuperAppToPushLandingPage();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                      returnLocation: argument?.dropOffLocationName ?? '',
                      pickupLocation: argument?.pickupLocationName ?? '',
                      returnExtraCharge: argument?.returnExtraCharge ?? 0.0,
                    ),
                ],
              );
            },
          );
        });
  }

  String _getTitleBasedOnState() {
    switch (carDetailInfoBloc.state.carDetailInfoPickType) {
      case CarDetailInfoPickType.carDetailInfoPickup:
        return getTranslated(context, AppLocalizationsStrings.pickUpLocation);
      case CarDetailInfoPickType.carDetailInfoDropOff:
        return getTranslated(context, AppLocalizationsStrings.returnLocation);
      case CarDetailInfoPickType.carDetailInfoCarInfo:
        return getTranslated(context, AppLocalizationsStrings.carDetails);
    }
  }

  Widget _getScrollableData() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: kSize16, horizontal: kSize24),
      child: ListView(
        padding: const EdgeInsets.only(bottom: kSize16),
        children: [
          CarDetailInfoTitle(
            title: _getTitleBasedOnState(),
          ),
          if (carDetailInfoBloc.canShowCarDetailInfo())
            CarDetailInfoLogo(
              imageUrl: carDetailInfoBloc.getCarInfoState()?.imagePath ?? "",
              text: carDetailInfoBloc.getCarInfoState()?.title ?? "",
            ),
          CarDetailInfoListingView(
            list: _getListOfItem(),
          ),
          if (carDetailInfoBloc.state.carDetailInfoPickType !=
                  CarDetailInfoPickType.carDetailInfoCarInfo &&
              argument != null &&
              argument!.showMap)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: OtaHorizontalDivider(
                dividerColor: AppColors.kGrey10,
              ),
            ),
          if (carDetailInfoBloc.state.carDetailInfoPickType !=
                  CarDetailInfoPickType.carDetailInfoCarInfo &&
              argument != null &&
              argument!.showMap)
            OtaLocationWidget(
              onTap: () async {
                String? latitude;
                String? longitude;
                if (carDetailInfoBloc.state.carDetailInfoPickType ==
                    CarDetailInfoPickType.carDetailInfoPickup) {
                  latitude = carDetailInfoBloc.state.pickupLocation?.lattitude;
                  longitude = carDetailInfoBloc.state.pickupLocation?.longitude;
                } else if (carDetailInfoBloc.state.carDetailInfoPickType ==
                    CarDetailInfoPickType.carDetailInfoDropOff) {
                  latitude = carDetailInfoBloc.state.dropOffLocation?.lattitude;
                  longitude =
                      carDetailInfoBloc.state.dropOffLocation?.longitude;
                }
                if (latitude != null && longitude != null) {
                  OtaMapLauncher.launchMap(
                      latitude: double.parse(latitude),
                      longitude: double.parse(longitude));
                }
              },
              locationText:
                  getTranslated(context, AppLocalizationsStrings.viewMap),
              style: AppTheme.kSmallRegular,
              leadingIcon: _kMapIcon,
              isGradientText: true,
              paddingWidth: kSize8,
            ),
        ],
      ),
    );
  }

  List<CarDetailInfoListingModel> _getListOfItem() {
    List<CarDetailInfoListingModel> data =
        List<CarDetailInfoListingModel>.generate(
      carDetailInfoBloc.getListBasedOnState().length,
      (index) {
        return CarDetailInfoListingModel.fromCarDetailInfoCell(
            carDetailInfoBloc.getListBasedOnState().elementAt(index));
      },
    );
    if (carDetailInfoBloc.state.carDetailInfoPickType ==
        CarDetailInfoPickType.carDetailInfoCarInfo) {
      data.add(
        CarDetailInfoListingModel(
            header: getTranslated(context, AppLocalizationsStrings.facilities),
            imageUrl: _kExclamationIcon,
            subHeaders:
                carDetailInfoBloc.state.carDetailInfoCarInfo.facilityList),
      );
    }
    return data;
  }

  PreferredSizeWidget _getAppBar() {
    return OtaAppBar(
      title: getTranslated(context, AppLocalizationsStrings.infoAboutCar),
      onLeftButtonPressed: onBackClicked,
    );
  }

  void onBackClicked() {
    NavigatorHelper.shouldSystemPop(context);
  }

  Future<bool> onWillPop() async {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    return true;
  }

  void waitForSuperAppToPushLandingPage() {
    BookingCustomerRegisterUseCases landingCustomerRegisterUseCases =
        BookingCustomerRegisterUseCasesImpl();
    LoginModel loginModel = getLoginProvider();
    landingCustomerRegisterUseCases.invokeExampleMethod(
        methodName: "bookingCustomerRegister",
        arguments: BookingCustomerRegisterArgumentModelChannel(
          userType: loginModel.userType.getSuperAppString(),
          env: loginModel.getEnv(),
          language: loginModel.getLanguage(),
          userId: loginModel.userId,
        ));
  }

  void waitForReplyFromSuperApp(RegisterConfirmBookingModelChannel data) async {
    LoginModel loginModel = getLoginProvider();
    if (loginModel.userType == UserType.loggedInUser) {
      if (data.existingCust.toString().toLowerCase() == "no") {
        OtaBanner().showMaterialBanner(
          context,
          getTranslated(
            context,
            AppLocalizationsStrings.successRegistration,
          ),
          AppColors.kBannerCSuccessColor,
          _kTickIcon,
        );
      }
    }
  }
}
