import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_logger.dart';
import 'package:ota/core_pack/appflyer/car_rental/car_click_review_reservation_parameters.dart';
import 'package:ota/core_pack/appflyer/car_rental/car_view_review_reservation_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_special_promotion_widget.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/view_model/promo_widget_view_model.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_click_payment_parameters.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_click_reservation_parameters.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_payment_promo_error_parameters.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_rental_payment_success_parameters.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/firebase_logger.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_argument_model.dart';
import 'package:ota/modules/car_rental/car_detail_info/view_model/car_detail_info_view_model.dart';
import 'package:ota/modules/car_rental/car_payment/view_model/car_payment_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_reservation/bloc/car_reservation_update.dart';
import 'package:ota/modules/car_rental/car_reservation/bloc/user_detail_bloc.dart';
import 'package:ota/modules/car_rental/car_reservation/helpers/car_app_flyer_helper.dart';
import 'package:ota/modules/car_rental/car_reservation/helpers/car_reservation_helper.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_addon_view.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_guest_information_widget.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_mandatory_addon_view.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_reservation_bottom_widget.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_reservation_cancellation_controller.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_reservation_cancellation_policy.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_reservation_detail_list.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_reservation_info.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_reservation_network_error_with_refresh.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/userdetail_view_model.dart';
import 'package:ota/modules/car_rental/contact_information/view_model/contact_information_argument_model.dart';
import 'package:ota/modules/car_rental/guest_driver_details/view_model/driver_information_argument_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/guest_user_detail/guest_user_detail_controller.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/member_text_widget.dart';
import 'package:provider/provider.dart';

import '../../../../common/utils/app_colors.dart';
import '../../../../common/utils/app_localization_strings.dart';
import '../../../../common/utils/consts.dart';
import '../../../../core/app_config.dart';
import '../../../../core/app_routes.dart';
import '../../../../core_components/bloc/bloc_builder.dart';
import '../../../../core_pack/custom_widgets/ota_alert_dialog.dart';
import '../../../../core_pack/custom_widgets/ota_app_bar.dart';
import '../../../../core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import '../../../../core_pack/custom_widgets/ota_countdown_timer/ota_countdown_timer.dart';
import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_banner_widget.dart';
import '../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import '../../../../core_pack/custom_widgets/ota_horizontal_divider.dart';
import '../../../../core_pack/custom_widgets/ota_loading_indicator.dart';
import '../../../../core_pack/i18n/language_constants.dart';
import '../bloc/car_reservation_bloc.dart';
import '../view_model/car_reservation_add_on_view_model.dart';
import '../view_model/car_reservation_argument_view_model.dart';
import '../view_model/car_reservation_view_model.dart';

const String formNextLine = '\n';
const int roundingOff = 2;
const double _kTopPadding = 53;
const int _kSecondsInMinute = 60;
const _kTopHeight = 180;
const String _arrowRight = "assets/images/icons/arrow_right.svg";
const String _textFormatter = r'[A-Za-z\u0E00-\u0E7F0-9 ]';
const String _invalidFormatter = r'[฿]';
const int _charCount = 255;
const double _kSize = kSize34;
const _kReserveForOther = "reserve_for_someoneElse";
const int _kMaxLines = 1;
const String prefixTitle = 'Khun';

class CarReservationScreen extends StatefulWidget {
  const CarReservationScreen({Key? key}) : super(key: key);
  @override
  CarReservationScreenState createState() => CarReservationScreenState();
}

class CarReservationScreenState extends State<CarReservationScreen> {
  final CarReservationBloc _carReservationBloc = CarReservationBloc();
  final UserDetailBloc _userDetailBloc = UserDetailBloc();
  bool contactInfoSelected = false;
  final TextEditingController _additionalNeed = TextEditingController();
  late OtaCountDownController _otaCountDownController;
  CarReservationViewArgumentModel? carReservationViewArgumentModel;
  final GuestUserDetailController _guestUserDetailController =
      GuestUserDetailController();
  final CurrencyUtil currencyUtil = CurrencyUtil();
  AppFlyerLogger appFlyerLogger = AppFlyerLogger();
  FirebaseLogger firebaseLogger = FirebaseLogger();
  final CarReservationCancellationController controller =
      CarReservationCancellationController();

  @override
  void initState() {
    _otaCountDownController = OtaCountDownController(
        durationInSecond:
            AppConfig().configModel.timerValue * _kSecondsInMinute,
        onComplete: () {
          _showTimeoutAlert();
        });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getReservationData();
      _initialize();
      CarClickReservationAppFlyer.addOnList.clear();
    });
    resetPromoData();
    super.initState();
  }

  _getReservationData({dynamic isRefresh = false}) async {
    carReservationViewArgumentModel = ModalRoute.of(context)?.settings.arguments
        as CarReservationViewArgumentModel;

    _otaCountDownController.reStartTimer();
    await _requestCarDetailData(isRefresh: isRefresh);
    await _userDetailBloc.getFromApiCall(carReservationViewArgumentModel);
  }

  void _initialize() async {
    Provider.of<CarReservationUpdate>(context, listen: false).updateData(false);
    _carReservationBloc.stream.listen((event) {
      if (_carReservationBloc.state.pageState ==
          CarReservationPageState.success) {
        _launchAppFlyerViewEvent();
        List<ExtraChargeData> extraCharges =
            _carReservationBloc.state.carDetailInfoModel?.extraCharges ?? [];
        List<ExtraChargeData> mandatoryAddon = extraCharges
            .where((element) => element.isCompulsory == true)
            .toList();

        if (mandatoryAddon.isNotEmpty) {
          for (ExtraChargeData item in mandatoryAddon) {
            var value = Provider.of<CarReservationAddOnViewModel>(context,
                listen: false);
            int quantity =
                value.getQuantityForMandatoryAddOn(item.extraChargeGroup?.id);
            value.putAddOn(item.extraChargeGroup?.id, quantity);
          }
        }
      }
      if (_carReservationBloc.state.pageState ==
          CarReservationPageState.failureNetwork) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
      if (_carReservationBloc.isValidationRequired) {
        if (isCarUnAvailable()) {
          _showCarUnavailableAlert();
        } else if (isCarPriceChanged()) {
          _showPriceChangeAlert();
        } else {
          _otaCountDownController.startTimer();
        }
      }
    });
    _otaCountDownController.startTimer();
  }

  void _showTimeoutAlert() {
    OtaAlertDialog(
        errorMessage:
            getTranslated(context, AppLocalizationsStrings.timerTimeOutMessage),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.ok),
        useRootNavigator: false,
        onPressed: () {
          Navigator.pop(context);
          Navigator.popUntil(context,
              (route) => route.settings.name == AppRoutes.carReservationScreen);
          _otaCountDownController.resetTimer();
          refreshReviewPage();
          Provider.of<CarReservationAddOnViewModel>(context, listen: false)
              .resetValues();
        }).showAlertDialog(context);
  }

  void resetPromoData() {
    Provider.of<PromoWidgetViewModel>(context, listen: false)
        .setPromoWidgetViewModelData(PromoWidgetViewModel());
  }

  void refreshReviewPage({isRefresh = false}) {
    resetPromoData();
    _carReservationBloc.saveCarReservationData(carReservationViewArgumentModel,
        isRefresh: isRefresh);
  }

  bool isCarUnAvailable() {
    return _carReservationBloc.state.pageState ==
        CarReservationPageState.failureUnAvailable;
  }

  bool isCarPriceChanged() {
    return _carReservationBloc.state.carDetailInfoModel!.totalPrice !=
        carReservationViewArgumentModel?.lastPrice;
  }

  void _showCarUnavailableAlert() {
    _otaCountDownController.stopTimer();
    OtaAlertDialog(
        errorMessage:
            getTranslated(context, AppLocalizationsStrings.carNotLeft),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.ok),
        onPressed: () {
          Provider.of<CarReservationUpdate>(context, listen: false)
              .updateData(true);
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          // Navigator.popUntil(context,
          //     (route) => route.settings.name == AppRoutes.carDetailScreen);
        }).showAlertDialog(context);
  }

  void _showPriceChangeAlert() {
    _otaCountDownController.stopTimer();
    OtaAlertDialog(
        errorMessage: getTranslated(
            context, AppLocalizationsStrings.carPriceSubjectToChange),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.carPriceChangeTitle),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.ok),
        onPressed: () {
          Navigator.of(context).pop();
          _otaCountDownController.startTimer();
          //Update price info.
        }).showAlertDialog(context);
  }

  @override
  void dispose() {
    _carReservationBloc.dispose();
    _otaCountDownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _otaCountDownController.cancelTimer();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.kLight100,
        appBar: OtaAppBar(
          title: getTranslated(
              context, AppLocalizationsStrings.carRentalReservation),
          titleColor: AppColors.kGrey70,
          onLeftButtonPressed: () {
            final carReservationAddOnViewModel =
                Provider.of<CarReservationAddOnViewModel>(context,
                    listen: false);
            carReservationAddOnViewModel.resetValues();
            Navigator.pop(context);
          },
          key: const Key("back_button_icon"),
        ),
        body: BlocBuilder(
            bloc: _carReservationBloc,
            builder: () {
              switch (_carReservationBloc.state.pageState) {
                case CarReservationPageState.success:
                  return successWidget();
                case CarReservationPageState.initial:
                  return defaultWidget();
                case CarReservationPageState.loading:
                  return loadIngWidget();
                case CarReservationPageState.failure:
                case CarReservationPageState.failureNetwork:
                  return _failureWidget();
                default:
                  return defaultWidget();
              }
            }),
      ),
    );
  }

  Widget defaultWidget() {
    return const SizedBox();
  }

  Widget loadIngWidget() {
    return const OTALoadingIndicator();
  }

  Future<void> _requestCarDetailData({isRefresh = false}) async {
    _carReservationBloc.saveCarReservationData(carReservationViewArgumentModel);
  }

  Widget _failureWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: kSize24),
      child: Material(
        child: CarReservationNetworkErrorWidgetWithRefresh(
          height: MediaQuery.of(context).size.height - _kTopHeight,
          onRefresh: () async {
            await _getReservationData(isRefresh: true);
          },
        ),
      ),
    );
  }

  Widget promotionBannerWidget(
      List<OtaFreeFoodPromotionModel> freeFoodPromotionList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        const SizedBox(height: kSize24),
        Text(
          getTranslated(context, AppLocalizationsStrings.robinhoodSpecialOffer),
          style: AppTheme.kHeading1Medium,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: kSize16),
        OtaFreeFoodBannerWidget(freeFoodPromotionList: freeFoodPromotionList),
        const SizedBox(height: kSize24),
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
      ],
    );
  }

  Widget successWidget() {
    List<OtaFreeFoodPromotionModel> freeFoodPromotionList =
        _carReservationBloc.state.carDetailInfoModel?.promotionList ?? [];
    return GestureDetector(
      key: const Key("gesture_key"),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: kSize120),
            child: ListView(
              key: const Key("listview_key"),
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                  top: _kTopPadding, right: kSize24, left: kSize24),
              children: <Widget>[
                getCarReservationInfo(),
                const SizedBox(
                  height: kSize16,
                ),
                const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
                getCarReservationDetailList(),
                const SizedBox(
                  height: kSize16,
                ),
                const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
                _getPickUpReturnDetails(),
                const SizedBox(
                  height: kSize16,
                ),
                OtaSpecialPromotionWidget(
                  allowLateReturn: _carReservationBloc
                          .state.carDetailInfoModel?.allowLateReturn ??
                      0,
                ),
                if (freeFoodPromotionList.isNotEmpty)
                  promotionBannerWidget(freeFoodPromotionList),
                getCancellationPolicy(),
                const SizedBox(
                  height: kSize16,
                ),
                const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
                _getAdditionalNeeds(),
                showMandatoryAddonView(_carReservationBloc),
                showAddonView(_carReservationBloc),
                getUserName(),
                bookForSomeoneElse(),
                getDriverDetails(_carReservationBloc),
              ],
            ),
          ),
          _buildBottomPriceWidget(),
          OtaCountDownTimer(
            controller: _otaCountDownController,
          ),
        ],
      ),
    );
  }

  Widget getCancellationPolicy() {
    return CarReservationCancellationScreen(
      key: const Key("cancel_policy"),
      carReservationBloc: _carReservationBloc,
      controller: controller,
    );
  }

  Widget getUserName() {
    return BlocBuilder(
        bloc: _userDetailBloc,
        builder: () {
          debugPrint('test ---> ${_userDetailBloc.state.userDetailViewModelDataState}');
          if (_userDetailBloc.state.userDetailViewModelDataState !=
              CarUserDetailViewModelDataState.loaded) {
            return const SizedBox();
          }
          return CarGuestInformationFieldWidget(
            key: const Key('car_guest_info'),
            firstName: _userDetailBloc.state.firstName,
            lastName: _userDetailBloc.state.secondName,
            phoneNumber: _userDetailBloc.state.mobileNumber,
            onTitleArrowClick: _openGuestInfoPage,
            isBookForSomeoneElse: _userDetailBloc.state.buttonState ==
                OtaRadioButtonState.selected,
            headerText:
                getTranslated(context, AppLocalizationsStrings.contactInfo),
            subheadText: getTranslated(
                context, AppLocalizationsStrings.carProvideContactInfo),
          );
        });
  }

  Widget bookForSomeoneElse() {
    return BlocBuilder(
        bloc: _guestUserDetailController.state.otaRadioButtonBloc!,
        builder: () {
          return OtaRadioButton(
            key: const Key(_kReserveForOther),
            verticalPadding: kSize5,
            isCenteredAlign: true,
            unSelectedWidget: Ink(
              height: kSize20,
              width: kSize20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.kPurpleOutline,
                ),
              ),
            ),
            textWidget: Text(
              getTranslated(context, AppLocalizationsStrings.reserveForOther),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: AppTheme.kBodyRegular,
            ),
            label:
                getTranslated(context, AppLocalizationsStrings.reserveForOther),
            isSelected: _guestUserDetailController
                    .state.otaRadioButtonBloc!.state.otaRadioButtonState ==
                OtaRadioButtonState.selected,
            onClicked: _onRadioBtnClicked,
            horizontalPadding: kSize0,
          );
        });
  }

  void _onRadioBtnClicked() {
    if (_guestUserDetailController
            .state.otaRadioButtonBloc!.state.otaRadioButtonState ==
        OtaRadioButtonState.selected) {
      _guestUserDetailController.state.otaRadioButtonBloc!.unSelect();
      _guestUserDetailController.state.firstNameBloc!.validInputState();
      _guestUserDetailController.state.lastNameBloc!.validInputState();
    } else {
      _guestUserDetailController.state.otaRadioButtonBloc!.select();
    }
    _userDetailBloc.isBookForSomeoneElse(
        _guestUserDetailController.state.otaRadioButtonBloc!);
    return;
  }

  Widget getDriverDetails(CarReservationBloc bloc) {
    return BlocBuilder(
        bloc: _userDetailBloc,
        builder: () {
          if (_userDetailBloc.state.userDetailViewModelDataState !=
              CarUserDetailViewModelDataState.loaded) {
            return const SizedBox();
          }
          return CarGuestInformationFieldWidget(
            key: const Key('driver_details'),
            isDriverDetail: true,
            firstName: _userDetailBloc.state.driverFirstName,
            lastName: _userDetailBloc.state.driverLastName,
            phoneNumber: _userDetailBloc.state.driverPhoneNumber,
            onTitleArrowClick: _openDriverDetailsPage,
            isBookForSomeoneElse: _userDetailBloc.state.buttonState ==
                OtaRadioButtonState.selected,
            headerText: getTranslated(
                context, AppLocalizationsStrings.driverInformation),
            isWarningEnabled: _isWarningVisible(),
            warningText:
                getTranslated(context, AppLocalizationsStrings.moreInfo),
          );
        });
  }

  bool _isWarningVisible() {
    bool isVisible = (_userDetailBloc.state.driverFirstName.isEmpty ||
        _userDetailBloc.state.driverLastName == null ||
        _userDetailBloc.state.driverLastName!.isEmpty ||
        _userDetailBloc.state.driverPhoneNumber.isEmpty ||
        _userDetailBloc.state.driverPhoneNumber.length != 10 ||
        !_userDetailBloc.state.driverPhoneNumber.startsWith('0') ||
        _userDetailBloc.state.driverAge == 0 ||
        kInvalidNameFormatter.hasMatch(_userDetailBloc.state.driverFirstName) ||
        kInvalidNameFormatter.hasMatch(_userDetailBloc.state.driverLastName!));
    return isVisible;
  }

  void _openGuestInfoPage() {
    Navigator.pushNamed(context, AppRoutes.carContactInformation,
        arguments: ContactInformationArgumentModel(
          initialContactInformationArgumentData: ContactInformationArgumentData(
            firstName: _userDetailBloc.state.firstName,
            email: _userDetailBloc.state.email,
            phoneNumber: _userDetailBloc.state.mobileNumber,
            lastName: _userDetailBloc.state.secondName,
            contactInformationSelected: contactInfoSelected,
          ),
          onOkClicked: (updatedContactInformationArgumentData) {
            contactInfoSelected = updatedContactInformationArgumentData
                .contactInformationSelected;
            _userDetailBloc.setUserDataFromArg(
              lastName: updatedContactInformationArgumentData.lastName,
              mobileNumber: updatedContactInformationArgumentData.phoneNumber,
              firstName: updatedContactInformationArgumentData.firstName,
              email: updatedContactInformationArgumentData.email,
            );
          },
        ));
  }

  void _openDriverDetailsPage() {
    Navigator.pushNamed(context, AppRoutes.guestDriverDetailsScreen,
        arguments: DriverInformationArgumentModel(
          initialContactInformationArgumentData: DriverInformationArgumentData(
            firstName: _userDetailBloc.state.driverFirstName,
            lastName: _userDetailBloc.state.driverLastName,
            phoneNumber: _userDetailBloc.state.driverPhoneNumber,
            age: _userDetailBloc.state.driverAge,
            flightNumber: _userDetailBloc.state.flightNumber,
            minAge: _carReservationBloc.state.carDetailInfoModel?.minAge,
            maxAge: _carReservationBloc.state.carDetailInfoModel?.maxAge,
          ),
          onOkClicked: (updatedDriverInformationArgumentData) {
            _userDetailBloc.setDriverDataFromArg(
              firstName: updatedDriverInformationArgumentData.firstName,
              lastName: updatedDriverInformationArgumentData.lastName,
              age: updatedDriverInformationArgumentData.age,
              mobileNumber: updatedDriverInformationArgumentData.phoneNumber,
              flightNumber: updatedDriverInformationArgumentData.flightNumber,
            );
            setState(() {});
          },
        ));
  }

  CarDetailInfoDataViewModel _getCarDetailInfoDataList(
      CarDetailInfoModel? carDetail) {
    return CarReservationHelper.getCarDetailInfo(carDetail, context);
  }

  void _goToPickupDropOff(CarDetailInfoPickType carDetailInfoPickType) {
    CarDetailInfoModel? carDetail =
        _carReservationBloc.state.carDetailInfoModel;
    CarDetailInfoDataViewModel argument = _getCarDetailInfoDataList(carDetail);

    Navigator.pushNamed(
      context,
      AppRoutes.carDetailInfoScreen,
      arguments: CarDetailInfoArgumentModel(
        carDetailInfoCarInfo: CarDetailInfoCarInfo(
          carDetails: argument.carDetails,
          facilityList: carDetail?.facilities ?? [],
          pricing: argument.pricing,
        ),
        carDetailInfoDropOff: CarDetailInfoDropOff(
          carDetails: argument.carDetailsDropOff,
          carInfo: argument.carInfo,
          pricing: argument.pricing,
        ),
        carDetailInfoPickup: CarDetailInfoPickup(
          carDetails: argument.carDetailsPickUp,
          carInfo: argument.carInfo,
          pricing: argument.pricing,
        ),
        carDetailInfoPickType: carDetailInfoPickType,
        carReservationViewArgumentModel: carReservationViewArgumentModel,
      ),
    );
  }

  Widget getCarReservationInfo() {
    String? brandName = _carReservationBloc.state.carDetailInfoModel?.brand;
    String? carName = _carReservationBloc.state.carDetailInfoModel?.name;
    return CarReservationInfo(
      headerText: '$brandName' '${' '}$carName',
      imageUrl: _carReservationBloc.state.carDetailInfoModel?.imageUrl,
      logo: _carReservationBloc.state.carDetailInfoModel?.logoUrl,
      subHeaderText:
          '${_carReservationBloc.state.carDetailInfoModel?.crafttype}'
          '${" "}${getTranslated(context, AppLocalizationsStrings.orSimilar)}',
    );
  }

  Widget getCarReservationDetailList() {
    return CarReservationDetailList(
      noOfSmallBag: _carReservationBloc.state.carDetailInfoModel?.bagSmallNbr,
      noOfDoors: _carReservationBloc.state.carDetailInfoModel?.doorNbr,
      gear: _carReservationBloc.state.carDetailInfoModel?.gear,
      noOfSeats: _carReservationBloc.state.carDetailInfoModel?.seatNbr,
      noOfLargeBag: _carReservationBloc.state.carDetailInfoModel?.bagLargeNbr,
    );
  }

  Widget _getPickUpReturnDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kSize16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getTranslated(context, AppLocalizationsStrings.infoAboutCar),
              style: AppTheme.kBodyMedium,
            ),
            OtaIconButton(
              key: const Key("pick_off_button"),
              icon: SvgPicture.asset(
                _arrowRight,
                width: kSize20,
                height: kSize20,
              ),
              onTap: () {
                _goToPickupDropOff(CarDetailInfoPickType.carDetailInfoPickup);
              },
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: kSize8),
          child: Text(
            getTranslated(context, AppLocalizationsStrings.pickUp),
            style: AppTheme.kBodyMedium,
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: kSize8),
              child: Text(
                getTranslated(context, AppLocalizationsStrings.pickUpDate),
                style: AppTheme.kBodyRegular,
              ),
            ),
            const Spacer(),
            _pickUpdate(),
          ],
        ),
        Row(
          children: [
            Text(
              getTranslated(context, AppLocalizationsStrings.carPickupPoint),
              style: AppTheme.kBodyRegular,
            ),
            const SizedBox(width: _kSize),
            Expanded(
              child: Text(
                  '${_carReservationBloc.state.carDetailInfoModel?.pickUpLocation}',
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
        Padding(
          padding: const EdgeInsets.only(bottom: kSize8),
          child: Text(
            getTranslated(context, AppLocalizationsStrings.dropOff),
            style: AppTheme.kBodyMedium,
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: kSize8),
              child: Text(
                getTranslated(context, AppLocalizationsStrings.dropOffDate),
                style: AppTheme.kBodyRegular,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            _returnDate()
          ],
        ),
        Row(
          children: [
            Text(getTranslated(context, AppLocalizationsStrings.dropOffPoint),
                style: AppTheme.kBodyRegular, overflow: TextOverflow.ellipsis),
            const SizedBox(width: _kSize),
            Expanded(
              child: Text(
                '${_carReservationBloc.state.carDetailInfoModel?.returnLocation}',
                style: AppTheme.kBodyMedium,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        if (_carReservationBloc.state.carDetailInfoModel != null &&
            _carReservationBloc.state.carDetailInfoModel!.returnExtraCharge !=
                null &&
            _carReservationBloc.state.carDetailInfoModel!.returnExtraCharge! >
                0)
          _setDropText(context),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: kSize16),
          child: OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        ),
        _getRentalPeriod(),
        _getServiceProvider(),
        if (_carReservationBloc.state.carDetailInfoModel != null &&
            _carReservationBloc.state.carDetailInfoModel!.returnExtraCharge !=
                null &&
            _carReservationBloc.state.carDetailInfoModel!.returnExtraCharge! >
                0)
          Padding(
            padding: const EdgeInsets.only(top: kSize8),
            child: _getExtraChargeView(_carReservationBloc
                    .state.carDetailInfoModel?.returnExtraCharge ??
                0),
          ),
        const SizedBox(height: kSize8)
      ],
    );
  }

  _setDropText(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: kSize8),
        Text(
          getTranslated(context, AppLocalizationsStrings.dropOffFeeText),
          style: AppTheme.kSmallRegular,
        ),
      ],
    );
  }

  String _getDateTimeFormat(DateTime? date) {
    return "${Helpers.getwwddMMMyy(date ?? DateTime.now())},${Helpers.gethhmm(date ?? DateTime.now()).addLeadingSpace()}";
  }

  Widget _pickUpdate() {
    return Text(
      _getDateTimeFormat(carReservationViewArgumentModel?.pickupDate),
      style: AppTheme.kBodyMedium,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _returnDate() {
    return Text(
      _getDateTimeFormat(carReservationViewArgumentModel?.returnDate),
      style: AppTheme.kBodyMedium,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getRentalPeriod() {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSize8),
      child: Row(
        children: [
          Text(
            getTranslated(context, AppLocalizationsStrings.rentalPeriod),
            style: AppTheme.kBodyRegular,
          ),
          const Spacer(),
          Text(
              '${_carReservationBloc.state.carDetailInfoModel?.numberofDays} ${getTranslated(context, AppLocalizationsStrings.days)}',
              style: AppTheme.kBodyMedium),
        ],
      ),
    );
  }

  Widget _getServiceProvider() {
    return Row(
      children: [
        Text(
          getTranslated(context, AppLocalizationsStrings.carSupplier),
          style: AppTheme.kBodyRegular,
        ),
        const SizedBox(width: _kSize),
        Expanded(
          child: Text(
              '${_carReservationBloc.state.carDetailInfoModel?.serviceProvider}',
              style: AppTheme.kBodyMedium,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right),
        ),
      ],
    );
  }

  Widget _getAdditionalNeeds() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kSize24),
      child: MemberTextWidget(
          headerText: getTranslated(
              context, AppLocalizationsStrings.additionalRequests),
          subText: getTranslated(
              context, AppLocalizationsStrings.carAdditionalRequirements),
          textController: _additionalNeed,
          characterCount: _charCount,
          textFormatter: _textFormatter,
          invalidFormatter: _invalidFormatter,
          maxLines: null,
          padding: kSize0,
          hintMemberText:
              getTranslated(context, AppLocalizationsStrings.carHintText)),
    );
  }

  Widget _buildBottomPriceWidget() {
    return BlocBuilder(
        bloc: _userDetailBloc,
        builder: () {
          return BlocBuilder(
              bloc: _guestUserDetailController.state.otaRadioButtonBloc!,
              builder: () {
                return BlocBuilder(
                  bloc: _carReservationBloc,
                  builder: () {
                    final value =
                        Provider.of<CarReservationAddOnViewModel>(context);
                    List<ExtraChargeData>? selectedAddOns = _carReservationBloc
                        .state.carDetailInfoModel?.extraCharges
                        ?.where((element) => value.addOnServiceMap
                            .containsKey(element.extraChargeGroup?.id))
                        .toList();
                    return _carReservationBloc.state.pageState ==
                            CarReservationPageState.success
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: CarReservationBottomWidget(
                              key: const Key("car_reservation_bottom_widget"),
                              pricePerDay: value.getTotalPrice(
                                selectedAddOns ?? [],
                                _carReservationBloc
                                    .state.carDetailInfoModel?.totalPrice,
                                _carReservationBloc
                                    .state.carDetailInfoModel?.numberofDays,
                              ),
                              onPressed: () {
                                getCarAndSupplierData(
                                  FirebaseEvent.carBookingSuccess,
                                );
                                _getFirebaseParametersForPaymentEvents();
                                _launchAppFlyerClickEvent();
                                _launchFirebaseClickEvent();
                                CarDetailInfoModel? carDetail =
                                    _carReservationBloc
                                        .state.carDetailInfoModel;
                                CarDetailInfoDataViewModel
                                    carDetailInfoDataViewModel =
                                    _getCarDetailInfoDataList(carDetail);

                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.carPaymentMainScreen,
                                  arguments: CarPaymentArgumentModel(
                                    promotionModelList: _carReservationBloc
                                            .state
                                            .carDetailInfoModel
                                            ?.promotionList ??
                                        [],
                                    allowLateReturn: _carReservationBloc.state
                                        .carDetailInfoModel?.allowLateReturn,
                                    totalPrice: _setTotalPrice(
                                        _carReservationBloc,
                                        context,
                                        selectedAddOns),
                                    age: carReservationViewArgumentModel?.age,
                                    carName: _carReservationBloc
                                        .state.carDetailInfoModel?.name,
                                    brandName: _carReservationBloc
                                        .state.carDetailInfoModel?.brand,
                                    serviceProvider: _carReservationBloc.state
                                        .carDetailInfoModel?.serviceProvider,
                                    bagLargeNbr: _carReservationBloc
                                        .state.carDetailInfoModel?.bagLargeNbr,
                                    bagSmallNbr: _carReservationBloc
                                        .state.carDetailInfoModel?.bagSmallNbr,
                                    seatNbr: _carReservationBloc
                                        .state.carDetailInfoModel?.seatNbr,
                                    gear: _carReservationBloc
                                        .state.carDetailInfoModel?.gear,
                                    otaCountDownController:
                                        _otaCountDownController,
                                    doorNbr: _carReservationBloc
                                        .state.carDetailInfoModel?.doorNbr,
                                    pickupDate: carReservationViewArgumentModel
                                        ?.pickupDate,
                                    returnDate: carReservationViewArgumentModel
                                        ?.returnDate,
                                    pickUpPoint: _carReservationBloc.state
                                        .carDetailInfoModel?.pickUpLocation,
                                    droffPoint: _carReservationBloc.state
                                        .carDetailInfoModel?.returnLocation,
                                    duration: _carReservationBloc
                                        .state.carDetailInfoModel?.numberofDays,
                                    firstName: _userDetailBloc.state.firstName,
                                    secondName:
                                        _userDetailBloc.state.secondName,
                                    driverFirstName: _userDetailBloc
                                                .state.buttonState ==
                                            OtaRadioButtonState.selected
                                        ? _userDetailBloc.state.driverFirstName
                                        : _userDetailBloc.state.firstName,
                                    driverLastName: _userDetailBloc
                                                .state.buttonState ==
                                            OtaRadioButtonState.selected
                                        ? _userDetailBloc.state.driverLastName
                                        : _userDetailBloc.state.secondName,
                                    email: _userDetailBloc.state.email,
                                    flightNumber:
                                        _userDetailBloc.state.flightNumber,
                                    driverAge: _userDetailBloc.state.driverAge,
                                    extraCharge: selectedAddOns,
                                    bookingUrn: _carReservationBloc
                                        .state.carDetailInfoModel?.bookingUrn,
                                    rateKey: carReservationViewArgumentModel
                                        ?.rateKey,
                                    refCode: carReservationViewArgumentModel
                                        ?.refCode,
                                    imageUrl: _carReservationBloc
                                        .state.carDetailInfoModel?.imageUrl,
                                    logoUrl: _carReservationBloc
                                        .state.carDetailInfoModel?.logoUrl,
                                    craftType: _carReservationBloc
                                        .state.carDetailInfoModel?.crafttype,
                                    carReservationViewArgumentModel:
                                        carReservationViewArgumentModel,
                                    pricePerDay: _carReservationBloc
                                        .state.carDetailInfoModel?.pricePerDay,
                                    meetingPointDescription: _carReservationBloc
                                        .state
                                        .carDetailInfoModel
                                        ?.meetingPointDescription,
                                    pickUpaddress: _carReservationBloc.state
                                        .carDetailInfoModel?.pickUpaddress,
                                    pickUpOpenTime: _carReservationBloc.state
                                        .carDetailInfoModel?.pickUpOpenTime,
                                    pickUpCloseTime: _carReservationBloc.state
                                        .carDetailInfoModel?.pickUpCloseTime,
                                    returnPointDescription: _carReservationBloc
                                        .state
                                        .carDetailInfoModel
                                        ?.returnPointDescription,
                                    returnAddress: _carReservationBloc.state
                                        .carDetailInfoModel?.returnAddress,
                                    returnOpenTime: _carReservationBloc.state
                                        .carDetailInfoModel?.returnOpenTime,
                                    returnCloseTime: _carReservationBloc.state
                                        .carDetailInfoModel?.returnCloseTime,
                                    fuelType: _carReservationBloc
                                        .state.carDetailInfoModel?.fuelType,
                                    engine: _carReservationBloc
                                        .state.carDetailInfoModel?.engine,
                                    year: _carReservationBloc
                                        .state.carDetailInfoModel?.year,
                                    facilities: _carReservationBloc
                                        .state.carDetailInfoModel?.facilities,
                                    carDetailInfoDataViewModel:
                                        CarInfoDataViewModel(
                                      carDetailsPickUp:
                                          carDetailInfoDataViewModel
                                              .carDetailsPickUp,
                                      carDetails:
                                          carDetailInfoDataViewModel.carDetails,
                                      carDetailsDropOff:
                                          carDetailInfoDataViewModel
                                              .carDetailsDropOff,
                                      pricing:
                                          carDetailInfoDataViewModel.pricing,
                                      facilities: carDetail?.facilities ?? [],
                                      carInfo:
                                          carDetailInfoDataViewModel.carInfo,
                                      pickupLocation: LocationsModelData(
                                        lattitude: _carReservationBloc.state
                                            .carDetailInfoModel?.pickUpLatitude,
                                        longitude: _carReservationBloc
                                            .state
                                            .carDetailInfoModel
                                            ?.pickUpLongitude,
                                      ),
                                      dropOffLocation: LocationsModelData(
                                        lattitude: _carReservationBloc.state
                                            .carDetailInfoModel?.returnLatitude,
                                        longitude: _carReservationBloc
                                            .state
                                            .carDetailInfoModel
                                            ?.returnLongitude,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              isWarningVisible: _isWarningVisible(),
                              dropLocation: _carReservationBloc
                                  .state.carDetailInfoModel?.returnLocation,
                              pickupLocation: _carReservationBloc
                                  .state.carDetailInfoModel?.pickUpLocation,
                              returnExtraCharge: _carReservationBloc.state
                                      .carDetailInfoModel?.returnExtraCharge ??
                                  0,
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                );
              });
        });
  }

  _getExtraChargeView(int extraCharge) {
    return Row(
      children: [
        Expanded(
            child: Text(
          getTranslated(
              context, AppLocalizationsStrings.returnTheCarToDifferentPlace),
          style: AppTheme.kBodyRegular,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        )),
        Text(currencyUtil.getFormattedPrice(extraCharge),
            style: AppTheme.kBodyMedium),
      ],
    );
  }

  Map<String, String> _getAppFlyerParameterData() {
    return {
      CarViewReservationAppFlyer.carId:
          carReservationViewArgumentModel?.carId ?? '',
      CarViewReservationAppFlyer.carAgencyName:
          _carReservationBloc.state.carDetailInfoModel?.serviceProvider ?? '',
      CarViewReservationAppFlyer.carDropOffLocation:
          _carReservationBloc.state.carDetailInfoModel?.returnLocation ?? '',
      CarViewReservationAppFlyer.carPickUpLocation:
          _carReservationBloc.state.carDetailInfoModel?.pickUpLocation ?? '',
      CarViewReservationAppFlyer.carPickUpDate:
          _carReservationBloc.state.carDetailInfoModel?.pickUpDate != null
              ? _getDateTimeFormat(carReservationViewArgumentModel?.pickupDate)
              : '',
      CarViewReservationAppFlyer.carReturnDate:
          _carReservationBloc.state.carDetailInfoModel?.returnDate != null
              ? _getDateTimeFormat(carReservationViewArgumentModel?.returnDate)
              : '',
      CarViewReservationAppFlyer.carContentId:
          carReservationViewArgumentModel?.carId ?? '',
    };
  }

  void _launchAppFlyerViewEvent() {
    appFlyerLogger.addParameters(_getAppFlyerParameterData());
    appFlyerLogger.addDoubleValue(
        key: CarViewReservationAppFlyer.carRentalPrice,
        value: _carReservationBloc.state.carDetailInfoModel?.pricePerDay);
    appFlyerLogger.addIntValue(
        key: CarViewReservationAppFlyer.carRentalPeriod,
        value: _carReservationBloc.state.carDetailInfoModel?.numberofDays);
    appFlyerLogger.addIntValue(
        key: CarViewReservationAppFlyer.carNoOfPassengers,
        value: _carReservationBloc.state.carDetailInfoModel?.seatNbr);
    appFlyerLogger.addContentType(
        key: CarViewReservationAppFlyer.carContentType);
    appFlyerLogger.addCurrency(key: CarViewReservationAppFlyer.carCurrency);
    appFlyerLogger.addUserLocation();
    appFlyerLogger.publishToSuperApp(AppFlyerEvent.carViewReservationEvent);
  }

  Map<String, String> _getAppFlyerParameterClickData() {
    return {
      CarClickReservationAppFlyer.carId:
          carReservationViewArgumentModel?.carId ?? '',
      CarClickReservationAppFlyer.carAgencyName:
          _carReservationBloc.state.carDetailInfoModel?.serviceProvider ?? '',
      CarClickReservationAppFlyer.carDropOffLocation:
          _carReservationBloc.state.carDetailInfoModel?.returnLocation ?? '',
      CarClickReservationAppFlyer.carPickUpLocation:
          _carReservationBloc.state.carDetailInfoModel?.pickUpLocation ?? '',
    };
  }

  void _getAppFlyerParametersForClickEvent() {
    appFlyerLogger.addParameters(_getAppFlyerParameterClickData());
    appFlyerLogger.addKeyValue(
        key: CarClickReservationAppFlyer.carPickUpDate,
        value: CarAppFlyerHelper().addCarFormatDateValue(
            value: carReservationViewArgumentModel?.pickupDate));
    appFlyerLogger.addKeyValue(
        key: CarClickReservationAppFlyer.carReturnDate,
        value: CarAppFlyerHelper().addCarFormatDateValue(
            value: carReservationViewArgumentModel?.returnDate));
    appFlyerLogger.addDoubleValue(
        key: CarClickReservationAppFlyer.carRentalPrice,
        value: _carReservationBloc.state.carDetailInfoModel?.pricePerDay);
    appFlyerLogger.addIntValue(
        key: CarClickReservationAppFlyer.carRentalPeriod,
        value: _carReservationBloc.state.carDetailInfoModel?.numberofDays);
    appFlyerLogger.addIntValue(
        key: CarClickReservationAppFlyer.carNoOfPassengers,
        value: _carReservationBloc.state.carDetailInfoModel?.seatNbr);

    appFlyerLogger.addDoubleValue(
        key: CarClickReservationAppFlyer.carAddOnPrice,
        value: _getTotalAdditionalPayOnline(
                _carReservationBloc.state.carDetailInfoModel?.extraCharges,
                context) +
            _getTotalAdditionalPayOffline(
                _carReservationBloc.state.carDetailInfoModel?.extraCharges,
                context));
    appFlyerLogger.addDoubleValue(
        key: CarClickReservationAppFlyer.carPayNowPrice,
        value: (_carReservationBloc.state.carDetailInfoModel?.totalPrice ?? 0) +
            _getTotalAdditionalPayOnline(
                _carReservationBloc.state.carDetailInfoModel?.extraCharges,
                context) +
            (_carReservationBloc.state.carDetailInfoModel?.returnExtraCharge ??
                0.0));
    appFlyerLogger.addDoubleValue(
        key: CarClickReservationAppFlyer.carPayLaterPrice,
        value: _getTotalAdditionalPayOffline(
            _carReservationBloc.state.carDetailInfoModel?.extraCharges,
            context));
    appFlyerLogger.addUserLocation();
    appFlyerLogger.addCommaSeparatedList(
        value: CarClickReservationAppFlyer.addOnList,
        key: CarClickReservationAppFlyer.carAddOnItems);
  }

  void _launchAppFlyerClickEvent() {
    _getAppFlyerParametersForClickEvent();
    appFlyerLogger.publishToSuperApp(AppFlyerEvent.carClickReservationEvent);
  }

  void _getFirebaseParametersForClickEvent() {
    firebaseLogger.addKeyValue(
        key: CarClickReservationFirebase.carModelId,
        value: carReservationViewArgumentModel?.carId);
    firebaseLogger.addKeyValue(
        key: CarClickReservationFirebase.carModelName,
        value: _carReservationBloc.state.carDetailInfoModel?.name);
    firebaseLogger.addKeyValue(
        key: CarClickReservationFirebase.carBrand,
        value: _carReservationBloc.state.carDetailInfoModel?.brand);
    firebaseLogger.addIntValue(
        key: CarClickReservationFirebase.carNumberDay,
        value: _carReservationBloc.state.carDetailInfoModel?.numberofDays);
    firebaseLogger.addKeyValue(
        key: CarClickReservationFirebase.carSupplierId,
        value: carReservationViewArgumentModel?.supplierId);
    firebaseLogger.addKeyValue(
        key: CarClickReservationFirebase.carSupplierName,
        value: _carReservationBloc.state.carDetailInfoModel?.serviceProvider);
    firebaseLogger.addKeyValue(
        key: CarClickReservationFirebase.carType,
        value: _carReservationBloc.state.carDetailInfoModel?.crafttype);
    firebaseLogger.addKeyValue(
        key: CarClickReservationFirebase.carDropOffLocation,
        value: _carReservationBloc.state.carDetailInfoModel?.returnLocation);
    firebaseLogger.addKeyValue(
        key: CarClickReservationFirebase.carPickUpLocation,
        value: _carReservationBloc.state.carDetailInfoModel?.pickUpLocation);
    firebaseLogger.addDateTimeValue(
        key: CarClickReservationFirebase.carPickUpDateTime,
        value: carReservationViewArgumentModel?.pickupDate);
    firebaseLogger.addDateTimeValue(
        key: CarClickReservationFirebase.carReturnUpDateTime,
        value: carReservationViewArgumentModel?.returnDate);

    firebaseLogger.addKeyValue(
        key: CarClickReservationFirebase.carSpecialRequest,
        value: _additionalNeed.text);
    firebaseLogger.addKeyValue(
        key: CarClickReservationFirebase.carBookForOthers,
        value: _getBookForOthers());
    firebaseLogger.addDoubleValue(
        key: CarClickReservationFirebase.carTotalPrice,
        value: (_carReservationBloc.state.carDetailInfoModel?.totalPrice ?? 0) +
            _getTotalAdditionalPayOnline(
                _carReservationBloc.state.carDetailInfoModel?.extraCharges,
                context) +
            (_carReservationBloc.state.carDetailInfoModel?.returnExtraCharge ??
                0.0));
  }

  void _launchFirebaseClickEvent() {
    _getFirebaseParametersForClickEvent();
    firebaseLogger.publishToSuperApp(FirebaseEvent.carClickReservationEvent);
  }

  void getCarAndSupplierData(String eventName) {
    FirebaseHelper.startCapturingEvent(eventName);
    FirebaseHelper.addKeyValue(
        key: CarPaymentSuccessFirebase.carModelId,
        eventName: eventName,
        value: carReservationViewArgumentModel?.carId);
    FirebaseHelper.addKeyValue(
        key: CarPaymentSuccessFirebase.carModelName,
        eventName: eventName,
        value: _carReservationBloc.state.carDetailInfoModel?.name);
    FirebaseHelper.addKeyValue(
        key: CarPaymentSuccessFirebase.carBrand,
        eventName: eventName,
        value: _carReservationBloc.state.carDetailInfoModel?.brand);
    FirebaseHelper.addIntValue(
        key: CarPaymentSuccessFirebase.carNumberDay,
        eventName: eventName,
        value: _carReservationBloc.state.carDetailInfoModel?.numberofDays);
    FirebaseHelper.addKeyValue(
        key: CarPaymentSuccessFirebase.carSupplierId,
        eventName: eventName,
        value: carReservationViewArgumentModel?.supplierId);
    FirebaseHelper.addKeyValue(
        key: CarPaymentSuccessFirebase.carSupplierName,
        eventName: eventName,
        value: _carReservationBloc.state.carDetailInfoModel?.serviceProvider);
    FirebaseHelper.addKeyValue(
        key: CarPaymentSuccessFirebase.carType,
        eventName: eventName,
        value: _carReservationBloc.state.carDetailInfoModel?.crafttype);
    FirebaseHelper.addKeyValue(
        key: CarPaymentSuccessFirebase.carReturnLocation,
        eventName: eventName,
        value: _carReservationBloc.state.carDetailInfoModel?.returnLocation);
    FirebaseHelper.addKeyValue(
        key: CarPaymentSuccessFirebase.carPickupLocation,
        eventName: eventName,
        value: _carReservationBloc.state.carDetailInfoModel?.pickUpLocation);
    FirebaseHelper.addDateTimeValue(
        key: CarPaymentSuccessFirebase.carPickupDatetime,
        eventName: eventName,
        value: carReservationViewArgumentModel?.pickupDate);
    FirebaseHelper.addDateTimeValue(
        key: CarPaymentSuccessFirebase.carReturnDatetime,
        eventName: eventName,
        value: carReservationViewArgumentModel?.returnDate);
    FirebaseHelper.addKeyValue(
      key: CarPaymentSuccessFirebase.carSpecialRequest,
      value: _additionalNeed.text,
      eventName: eventName,
    );
    FirebaseHelper.addKeyValue(
      key: CarPaymentSuccessFirebase.carBookforOthers,
      value: _getBookForOthers(),
      eventName: eventName,
    );
    FirebaseHelper.addKeyValue(
      key: CarPaymentSuccessFirebase.referenceId,
      value: _carReservationBloc.state.carDetailInfoModel?.bookingUrn ?? "",
      eventName: eventName,
    );
    FirebaseHelper.addDoubleValue(
      key: CarPaymentSuccessFirebase.totalPriceCar,
      value: _carReservationBloc.state.carDetailInfoModel?.totalPrice,
      eventName: eventName,
    );
  }

  String _getBookForOthers() {
    if (_guestUserDetailController
            .state.otaRadioButtonBloc!.state.otaRadioButtonState ==
        OtaRadioButtonState.selected) {
      return '${_userDetailBloc.state.driverLastName} ${_userDetailBloc.state.driverFirstName}, '
          '$prefixTitle';
    } else {
      return "";
    }
  }

  void _getFirebaseParametersForPaymentEvents() {
    FirebaseHelper.startCapturingEvent(FirebaseEvent.carClickPaymentEvent);
    FirebaseHelper.startCapturingEvent(FirebaseEvent.carPaymentErrorEvent);
    FirebaseHelper.startCapturingEvent(FirebaseEvent.carAddPromoErrorEvent);
    FirebaseHelper.addKeyValue(
      eventName: FirebaseEvent.carClickPaymentEvent,
      key: CarClickPaymentFirebase.carSpecialRequest,
      value: _additionalNeed.text,
    );
    FirebaseHelper.addKeyValue(
      eventName: FirebaseEvent.carClickPaymentEvent,
      key: CarClickPaymentFirebase.carBookForOthers,
      value: _getBookForOthers(),
    );

    FirebaseHelper.addKeyValue(
      eventName: FirebaseEvent.carPaymentErrorEvent,
      key: CarPaymentPromoErrorFirebase.carSpecialRequest,
      value: _additionalNeed.text,
    );
    FirebaseHelper.addKeyValue(
      eventName: FirebaseEvent.carPaymentErrorEvent,
      key: CarPaymentPromoErrorFirebase.carBookForOthers,
      value: _getBookForOthers(),
    );

    FirebaseHelper.addKeyValue(
      eventName: FirebaseEvent.carAddPromoErrorEvent,
      key: CarPaymentPromoErrorFirebase.carSpecialRequest,
      value: _additionalNeed.text,
    );
    FirebaseHelper.addKeyValue(
      eventName: FirebaseEvent.carAddPromoErrorEvent,
      key: CarPaymentPromoErrorFirebase.carBookForOthers,
      value: _getBookForOthers(),
    );
  }

  double _setTotalPrice(CarReservationBloc carReservationBloc,
      BuildContext context, List<ExtraChargeData>? selectedAddOns) {
    if (carReservationBloc.state.carDetailInfoModel?.returnExtraCharge !=
            null &&
        carReservationBloc.state.carDetailInfoModel!.returnExtraCharge! > 0) {
      return (carReservationBloc.state.carDetailInfoModel?.totalPrice ?? 0) +
          _getTotalAdditionalPayOnline(selectedAddOns, context) +
          (carReservationBloc.state.carDetailInfoModel?.returnExtraCharge ?? 0);
    } else {
      return (carReservationBloc.state.carDetailInfoModel?.totalPrice ?? 0) +
          _getTotalAdditionalPayOnline(selectedAddOns, context);
    }
  }

  double _getTotalAdditionalPayOnline(
      List<ExtraChargeData>? selectedAddOns, BuildContext context) {
    List<ExtraChargeData>? addOnsToPay =
        selectedAddOns?.where((element) => element.isCompulsory!).toList();
    final value =
        Provider.of<CarReservationAddOnViewModel>(context, listen: false);
    double totalprice = 0;
    addOnsToPay?.forEach((element) {
      element.chargeType == 0
          ? totalprice = totalprice +
              (element.addonPriceToDisplay! *
                  value.getQuantityForAddOn(element.extraChargeGroup?.id) *
                  _carReservationBloc.state.carDetailInfoModel!.numberofDays!)
          : totalprice = totalprice +
              (element.addonPriceToDisplay! *
                  value.getQuantityForAddOn(element.extraChargeGroup?.id));
    });
    return totalprice;
  }

  double _getTotalAdditionalPayOffline(
      List<ExtraChargeData>? selectedAddOns, BuildContext context) {
    List<ExtraChargeData>? addOnsToPay =
        selectedAddOns?.where((element) => !element.isCompulsory!).toList();
    final value =
        Provider.of<CarReservationAddOnViewModel>(context, listen: false);
    double totalprice = 0;
    addOnsToPay?.forEach((element) {
      element.chargeType == 0
          ? totalprice = totalprice +
              (element.addonPriceToDisplay! *
                  value.getQuantityForAddOn(element.extraChargeGroup?.id) *
                  _carReservationBloc.state.carDetailInfoModel!.numberofDays!)
          : totalprice = totalprice +
              (element.addonPriceToDisplay! *
                  value.getQuantityForAddOn(element.extraChargeGroup?.id));
    });
    return totalprice;
  }
}

ExtraChargeData extra = ExtraChargeData();
Widget showMandatoryAddonView(CarReservationBloc carReservationBloc) {
  if (carReservationBloc.state.carDetailInfoModel?.extraCharges != null &&
      carReservationBloc.state.carDetailInfoModel!.extraCharges!.isNotEmpty) {
    return CarMandatoryAddonView(
        carReservationBloc.state.carDetailInfoModel?.extraCharges,
        carReservationBloc);
  }
  return const SizedBox();
}

Widget showAddonView(CarReservationBloc carReservationBloc) {
  if (carReservationBloc.state.carDetailInfoModel?.extraCharges != null &&
      carReservationBloc.state.carDetailInfoModel!.extraCharges!.isNotEmpty) {
    return CarAddonView(
        carReservationBloc.state.carDetailInfoModel?.extraCharges,
        carReservationBloc);
  }
  return const SizedBox();
}
