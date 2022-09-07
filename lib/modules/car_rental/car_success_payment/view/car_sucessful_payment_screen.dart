import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_reservation_service_card_list_view.dart';
import 'package:ota/modules/car_rental/car_payment/view/widgets/car_payment_mandatory_addon_service.dart';
import 'package:ota/modules/car_rental/car_payment/view_model/car_payment_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_add_on_view_model.dart';
import 'package:ota/modules/car_rental/car_success_payment/view/widgets/car_payment_success_detail_list.dart';
import 'package:ota/modules/car_rental/car_success_payment/view/widgets/car_success_car_info.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:provider/provider.dart';

import '../../../../common/utils/app_colors.dart';
import '../../../../common/utils/app_localization_strings.dart';
import '../../../../common/utils/app_theme.dart';
import '../../../../common/utils/consts.dart';
import '../../../../common/utils/currency_code.dart';
import '../../../../common/utils/helper.dart';
import '../../../../core/app_routes.dart';
import '../../../../core_pack/custom_widgets/ota_button_bottom_bar.dart';
import '../../../../core_pack/custom_widgets/ota_gradient_text_widget.dart';
import '../../../../core_pack/custom_widgets/ota_horizontal_divider.dart';
import '../../../../core_pack/custom_widgets/ota_icon_button.dart';
import '../../../../core_pack/i18n/language_constants.dart';
import '../../car_detail_info/view_model/car_detail_info_argument_model.dart';
import '../../car_detail_info/view_model/car_detail_info_view_model.dart';
import '../../car_payment/view/widgets/car_payment_additional_services.dart';
import '../../car_rental_search_result/view_model/car_dates_location_update_view_model.dart';
import '../helper/car_success_payment_service_card_helper.dart';
import '../view_model/car_success_payment_service_card_view_model.dart';

const String _kCongatulationAssetName =
    "assets/images/icons/congratulation_image.svg";
const String _kCheckBoxAssetName = "assets/images/icons/yellow_check_box.svg";
const double _kSize91 = 91;
const int _maxLines = 1;
const int _kMaxLine = 1;
const double _kSize = kSize34;

const String _arrowRight = "assets/images/icons/arrow_right.svg";
const double _kDividerHeight = 1;
const String _kCarKey = "car_key";

class CarSuccessfulPaymentScreen extends StatelessWidget {
  const CarSuccessfulPaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.kLight100,
        appBar: AppBar(
          elevation: kSize0,
          toolbarHeight: kSize0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: AppColors.kPurpleOutline),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
        ),
        body: _body(context),
      ),
    );
  }

  Widget _getTopBar(BuildContext context) => Container(
        padding: const EdgeInsets.only(
            right: kSize14, bottom: kSize8, top: kSize8, left: kSize24),
        color: AppColors.kPurpleOutline,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: kSize15),
              child: SvgPicture.asset(
                _kCongatulationAssetName,
                fit: BoxFit.cover,
                width: kSize100,
                height: kSize84,
              ),
            ),
            const SizedBox(
              width: kSize16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        _kCheckBoxAssetName,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: kSize4),
                      Expanded(
                        child: Text(
                          getTranslated(context,
                              AppLocalizationsStrings.paymentSuccessTitle),
                          style: AppTheme.kHeading1Medium
                              .copyWith(color: AppColors.kTertiary),
                          maxLines: _maxLines,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    getTranslated(context,
                        AppLocalizationsStrings.carPaymentSuccessMessage),
                    style: AppTheme.kSmallRegular
                        .copyWith(color: AppColors.kLight100),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  _body(BuildContext context) {
    List<CarSuccessPaymentServiceCardViewModel>? serviceCardList =
        CarSuccessPaymentServiceCardHelper.getServiceCardList(context);
    CarPaymentArgumentModel argument =
        ModalRoute.of(context)?.settings.arguments as CarPaymentArgumentModel;
    return Stack(
      children: [
        SafeArea(
          minimum: EdgeInsets.only(
              bottom: _kSize91 + MediaQuery.of(context).padding.bottom),
          child: ListView(
            children: [
              _getTopBar(context),
              if (serviceCardList.isNotEmpty)
                _getServiceCards(serviceCardList, context),
              getCarReservationInfo(context, argument),
              _getCarReservationDetailList(context, argument),
              _getCardBottomBar(context, argument),
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: kSize24, vertical: kSize16),
                child: OtaHorizontalDivider(
                  dividerColor: AppColors.kBorderGrey,
                  height: _kDividerHeight,
                ),
              ),
              _getPickUpReturnDetails(context, argument),
              const SizedBox(height: kSize16),
              _showMandatoryService(argument),
              _showAdditionalService(argument),
            ],
          ),
        ),
        _getBottomBar(context),
      ],
    );
  }

  Widget _getServiceCards(
      List<CarSuccessPaymentServiceCardViewModel> serviceCardList,
      BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: kSize4),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSize24),
        child: Text(
          getTranslated(context, AppLocalizationsStrings.extraServices),
          style: AppTheme.kHeading1Medium,
          maxLines: _maxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      const SizedBox(height: kSize16),
      OtaServiceCardListView(
        serviceCardList: List.generate(
          serviceCardList.length,
          (index) =>
              serviceCardList[index].toOtaResrvationServiceCardViewModel(),
        ),
        serviceType: OtaServiceType.carRental,
      ),
      const SizedBox(height: kSize16),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: kSize24),
        child: OtaHorizontalDivider(
          dividerColor: AppColors.kBorderGrey,
          height: _kDividerHeight,
        ),
      ),
    ]);
  }

  Widget _getCarReservationDetailList(
      BuildContext context, CarPaymentArgumentModel argument) {
    return Padding(
      padding: const EdgeInsets.only(
          left: kSize24, right: kSize24, bottom: kSize10, top: kSize8),
      child: CarPaymentSuccessDetailList(
        noOfSmallBag: argument.bagSmallNbr,
        noOfDoors: argument.doorNbr,
        gear: argument.gear,
        noOfSeats: argument.seatNbr,
        noOfLargeBag: argument.bagLargeNbr,
      ),
    );
  }

  Widget getCarReservationInfo(
      BuildContext context, CarPaymentArgumentModel? argument) {
    String? brandName = argument?.brandName;
    String? carName = argument?.carName;
    return Padding(
      padding:
          const EdgeInsets.only(left: kSize24, right: kSize24, top: kSize16),
      child: CarSuccessCarInfo(
        headerText: '$brandName' '${' '}$carName',
        imageUrl: argument?.imageUrl,
        logo: argument?.logoUrl,
        subHeaderText: '${argument?.craftType}'
            '${" "}${getTranslated(context, AppLocalizationsStrings.orSimilar)}',
        bookingUrn: argument?.bookingUrn,
      ),
    );
  }

  Widget _getCardBottomBar(
      BuildContext context, CarPaymentArgumentModel argument) {
    final CurrencyUtil currencyUtil = CurrencyUtil();

    return Padding(
      padding: const EdgeInsets.only(right: kSize24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: currencyUtil.getFormattedPrice(
                            argument.pricePerDay!.toDouble()),
                        style: AppTheme.kBodyMedium,
                      ),
                      TextSpan(
                        text: (getTranslated(
                          context,
                          AppLocalizationsStrings.day,
                        ).addLeadingSlash())
                            .addLeadingSpace(),
                        style: AppTheme.kBodyRegular
                            .copyWith(color: AppColors.kGrey50),
                      ),
                    ],
                  ),
                  maxLines: _kMaxLine,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  getTranslated(
                        context,
                        AppLocalizationsStrings.totalPrice,
                      ).addTrailingSpace() +
                      currencyUtil
                          .getFormattedPrice(argument.totalPrice!.toDouble()),
                  style: AppTheme.kSmallerRegular
                      .copyWith(color: AppColors.kGrey50),
                  maxLines: _kMaxLine,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPickUpReturnDetails(
      BuildContext context, CarPaymentArgumentModel argument) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslated(context, AppLocalizationsStrings.infoAboutCar),
                style: AppTheme.kBodyMedium,
              ),
              OtaIconButton(
                icon: SvgPicture.asset(
                  _arrowRight,
                  width: kSize20,
                  height: kSize15,
                ),
                onTap: () {
                  _goToPickupDropOff(argument, context,
                      CarDetailInfoPickType.carDetailInfoPickup);
                },
              )
            ],
          ),
          const SizedBox(
            height: kSize16,
          ),
          Text(
            getTranslated(context, AppLocalizationsStrings.pickUp),
            style: AppTheme.kBodyMedium,
          ),
          const SizedBox(
            height: kSize8,
          ),
          Row(
            children: [
              Text(
                getTranslated(context, AppLocalizationsStrings.pickUpDate),
                style: AppTheme.kBodyRegular,
              ),
              const Spacer(),
              _pickUpdate(argument),
            ],
          ),
          const SizedBox(
            height: kSize8,
          ),
          Row(
            children: [
              Text(
                getTranslated(context, AppLocalizationsStrings.carPickupPoint),
                style: AppTheme.kBodyRegular,
              ),
              const SizedBox(width: _kSize),
              Expanded(
                child: Text('${argument.pickUpPoint}',
                    style: AppTheme.kBodyMedium,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: kSize16),
            child: OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          ),
          Text(
            getTranslated(context, AppLocalizationsStrings.dropOff),
            style: AppTheme.kBodyMedium,
          ),
          const SizedBox(height: kSize8),
          Row(
            children: [
              Text(
                getTranslated(context, AppLocalizationsStrings.dropOffDate),
                style: AppTheme.kBodyRegular,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              _returnDate(argument)
            ],
          ),
          const SizedBox(height: kSize8),
          Row(
            children: [
              Text(getTranslated(context, AppLocalizationsStrings.dropOffPoint),
                  style: AppTheme.kBodyRegular,
                  overflow: TextOverflow.ellipsis),
              const SizedBox(width: _kSize),
              Expanded(
                child: Text(
                  '${argument.droffPoint}',
                  style: AppTheme.kBodyMedium,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: kSize16),
            child: OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          ),
          _getRentalPeriod(context, argument),
          const SizedBox(height: kSize8),
          _getServiceProvider(context, argument),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: kSize16),
            child: OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          ),
          _getDriversName(context, argument),
        ],
      ),
    );
  }

  Widget _pickUpdate(CarPaymentArgumentModel argument) {
    return Text(
      "${Helpers.getwwddMMMyy(argument.pickupDate ?? DateTime.now())},${Helpers.gethhmm(argument.pickupDate ?? DateTime.now()).addLeadingSpace()}",
      style: AppTheme.kBodyMedium,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _returnDate(CarPaymentArgumentModel argument) {
    return Text(
      "${Helpers.getwwddMMMyy(argument.returnDate ?? DateTime.now())},${Helpers.gethhmm(argument.returnDate ?? DateTime.now()).addLeadingSpace()}",
      style: AppTheme.kBodyMedium,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getRentalPeriod(
      BuildContext context, CarPaymentArgumentModel argument) {
    return Row(
      children: [
        Text(
          getTranslated(context, AppLocalizationsStrings.rentalPeriod),
          style: AppTheme.kBodyRegular,
        ),
        const Spacer(),
        Text(
            '${argument.duration} ${getTranslated(context, AppLocalizationsStrings.days)}',
            style: AppTheme.kBodyMedium),
      ],
    );
  }

  Widget _getServiceProvider(
      BuildContext context, CarPaymentArgumentModel argument) {
    return Row(
      children: [
        Text(
          getTranslated(context, AppLocalizationsStrings.carSupplier),
          style: AppTheme.kBodyRegular,
        ),
        const SizedBox(width: _kSize),
        Expanded(
          child: Text('${argument.serviceProvider}',
              style: AppTheme.kBodyMedium,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right),
        ),
      ],
    );
  }

  Widget _getDriversName(
      BuildContext context, CarPaymentArgumentModel argument) {
    String driverFirstName = argument.driverFirstName ?? '';
    String driverLastName = argument.driverLastName ?? '';
    if (driverFirstName.isEmpty && driverLastName.isEmpty) {
      return const SizedBox.shrink();
    }
    return Row(
      children: [
        Text(
          getTranslated(context, AppLocalizationsStrings.driversName),
          style: AppTheme.kBodyRegular,
        ),
        const Spacer(),
        Text('$driverFirstName $driverLastName', style: AppTheme.kBodyMedium),
      ],
    );
  }

  Widget _getMandatoryServices(CarPaymentArgumentModel argument) {
    return CarPaymentMandatoryAddonService(
      extraCharge: argument.extraCharge,
      numberOfDays: argument.duration,
    );
  }

  Widget _getAdditionalServices(CarPaymentArgumentModel argument) {
    return CarPaymentAdditionalServices(
      extraCharge: argument.extraCharge,
      numberOfDays: argument.duration,
    );
  }

  Widget _getBottomBar(BuildContext context) {
    return OtaBottomButtonBar(
      isExpandedRightButton: true,
      spaceBetweenButton: kSize16,
      containerHeight: kSize74,
      padding: const EdgeInsets.fromLTRB(kSize24, kSize16, kSize24, kSize9),
      button1: InkWell(
        key: const Key("NavigateToLandingPage"),
        borderRadius: AppTheme.kBorderRadiusAll24,
        splashColor: AppColors.kGradientEnd,
        hoverColor: AppColors.kGradientEnd,
        highlightColor: AppColors.kGradientEnd,
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.kLight100.withOpacity(0.94),
            borderRadius: AppTheme.kBorderRadiusAll24,
          ),
          child: Center(
            child: OtaGradientText(
              gradientText:
                  getTranslated(context, AppLocalizationsStrings.backToHome),
              gradientTextStyle: AppTheme.kButton,
              textGradientStartColor: AppColors.kGradientStart,
              textGradientEndColor: AppColors.kGradientEnd,
              gradientTextBegin: Alignment.bottomCenter,
              gradientTextEnd: Alignment.topLeft,
              maxlines: _maxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        onTap: () {
          _resetProviderValues(context);
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.landingPage,
              (Route<dynamic> route) =>
                  route.settings.name == AppRoutes.splashScreen);
        },
      ),
      button2: Material(
        child: InkWell(
          key: const Key("NavigateToActivityPage"),
          borderRadius: AppTheme.kBorderRadiusAll24,
          splashColor: AppColors.kGradientEnd,
          hoverColor: AppColors.kGradientEnd,
          highlightColor: AppColors.kGradientEnd,
          child: Ink(
            decoration: const BoxDecoration(
              color: AppColors.kPurpleOutline,
              borderRadius: AppTheme.kBorderRadiusAll24,
              gradient: AppColors.kPurpleGradient,
            ),
            child: Center(
              child: Text(
                getTranslated(
                    context, AppLocalizationsStrings.viewActivityList),
                style: AppTheme.kButton.copyWith(color: AppColors.kTrueWhite),
                maxLines: _maxLines,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          onTap: () {
            _resetProviderValues(context);
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.otaBookingScreen,
                (Route<dynamic> route) =>
                    route.settings.name == AppRoutes.landingPage,
                arguments: _kCarKey);
          },
        ),
      ),
    );
  }

  void _goToPickupDropOff(CarPaymentArgumentModel argument,
      BuildContext context, CarDetailInfoPickType carDetailInfoPickup) {
    Navigator.pushNamed(
      context,
      AppRoutes.carDetailInfoScreen,
      arguments: CarDetailInfoArgumentModel(
        carDetailInfoCarInfo: CarDetailInfoCarInfo(
          carDetails: argument.carDetailInfoDataViewModel.carDetails,
          facilityList: argument.facilities ?? [],
          pricing: argument.carDetailInfoDataViewModel.pricing,
        ),
        carDetailInfoDropOff: CarDetailInfoDropOff(
          carDetails: argument.carDetailInfoDataViewModel.carDetailsDropOff,
          carInfo: argument.carDetailInfoDataViewModel.carInfo,
          pricing: argument.carDetailInfoDataViewModel.pricing,
        ),
        carDetailInfoPickup: CarDetailInfoPickup(
          carDetails: argument.carDetailInfoDataViewModel.carDetailsPickUp,
          carInfo: argument.carDetailInfoDataViewModel.carInfo,
          pricing: argument.carDetailInfoDataViewModel.pricing,
        ),
        carDetailInfoPickType: carDetailInfoPickup,
        carReservationViewArgumentModel:
            argument.carReservationViewArgumentModel,
        showMap: true,
        pickupLocation: LocationDataModel(
            lattitude:
                argument.carDetailInfoDataViewModel.pickupLocation?.lattitude,
            longitude:
                argument.carDetailInfoDataViewModel.pickupLocation?.longitude),
        dropOffLocation: LocationDataModel(
            lattitude:
                argument.carDetailInfoDataViewModel.dropOffLocation?.lattitude,
            longitude:
                argument.carDetailInfoDataViewModel.dropOffLocation?.longitude),
      ),
    );
  }

  ///TODO: Need to remove this after testing.
  // void _navigateToHotelLanding(BuildContext context) {
  //   Navigator.of(context).pushNamedAndRemoveUntil(
  //     AppRoutes.hotelLandingScreen,
  //     (Route<dynamic> route) => route.settings.name == AppRoutes.landingPage,
  //   );
  // }

  void _resetProviderValues(BuildContext context) {
    CarDatesLocationUpdateViewModel carDatesLocationUpdateViewModel =
        Provider.of<CarDatesLocationUpdateViewModel>(context, listen: false);
    CarReservationAddOnViewModel carReservationAddOnViewModel =
        Provider.of<CarReservationAddOnViewModel>(context, listen: false);
    carDatesLocationUpdateViewModel.resetValues();
    carReservationAddOnViewModel.resetValues();
  }

  _showMandatoryService(CarPaymentArgumentModel argument) {
    if (argument.extraCharge != null && argument.extraCharge!.isNotEmpty) {
      return _getMandatoryServices(argument);
    } else {
      return const SizedBox(height: kSize40);
    }
  }

  _showAdditionalService(CarPaymentArgumentModel argument) {
    if (argument.extraCharge != null && argument.extraCharge!.isNotEmpty) {
      return _getAdditionalServices(argument);
    } else {
      return const SizedBox(height: kSize40);
    }
  }
}
