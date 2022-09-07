import 'package:flutter/material.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_helper.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_payment_parameters.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_payment_success_parameters.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_payment_view_parameters.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_review_reservation_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_addon_service_tile.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_list_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_countdown_timer/ota_countdown_timer.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_banner_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_loading_indicator.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_reservation_details_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/view_model/promo_widget_view_model.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_booking_review_parameters.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_payment_review_parameters.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_success_payment_parameters.dart';
import 'package:ota/modules/hotel/hotel_detail/model/hotel_update.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/hotel_payment_main_argument_model.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/view_model/hotel_service_view_argument.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service_calendar/view_model/addon_service_argument_model.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service_calendar/view_model/addon_service_view_model.dart';
import 'package:ota/modules/hotel/room_reservation/contact_information/view_model/contact_information_argument_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/bloc/addons_view_bloc.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/bloc/filter_view_bloc.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/bloc/user_detail_bloc.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/bloc/your_list_bloc.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/guest_information_widget.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/guest_user_detail/guest_user_detail_controller.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/guest_user_detail/guest_user_detail_widget.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/member_text_widget.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/reservation_error_widget.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/reservation_room_info/reservation_room_info_widget.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view/widgets/service_carousel_widget.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/adons_view_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_argument_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/userdetail_view_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/your_list_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../core_pack/custom_widgets/ota_room_promotion_widget/ota_promotion_model.dart';
import '../../../../../core_pack/custom_widgets/ota_room_promotion_widget/ota_room_special_promotion_widget.dart';

const String formNextLine = '\n';
const int roundingOff = 2;
const double _kTotalBottomSpacing = 20;
const double _kAppBarHeight = 89;
const int _kAdditionalTextCharacterCount = 255;
const int _kMemberTextCharacterCount = 25;
const double _kTopPadding = 53;
const int _kSecondsInMinute = 60;
const int _kMaxlines = 1;

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  ReservationScreenState createState() => ReservationScreenState();
}

class ReservationScreenState extends State<ReservationScreen> {
  final GuestUserDetailController _guestUserDetailController =
      GuestUserDetailController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _additionalNeed = TextEditingController();
  final TextEditingController _memberText = TextEditingController();
  final YourListBloc _yourListBloc = YourListBloc();
  final FilterViewBloc _filterViewBloc = FilterViewBloc();
  final UserDetailBloc _userDetailBloc = UserDetailBloc();
  final AddonsListBloc _addonsListBloc = AddonsListBloc();
  ReservationArgumentModel? reservationArgumentModel;
  late OtaCountDownController _otaCountDownController;
  double lastPrice = -1;
  bool contactInfoSelected = false;
  FocusNode focusNodeGuestFirstName = FocusNode();
  FocusNode focusNodeGuestLastName = FocusNode();
  List<String> addOnIndexSelected = [];
  @override
  void initState() {
    FirebaseHelper.startCapturingEvent(FirebaseEvent.hotelBookingSuccess);
    FirebaseHelper.startCapturingEvent(FirebaseEvent.hotelPayment);
    FirebaseHelper.startCapturingEvent(FirebaseEvent.hotelPaymentError);
    FirebaseHelper.startCapturingEvent(FirebaseEvent.hotelPromoRedeemError);
    focusNodeGuestFirstName.addListener(() {
      if (!focusNodeGuestFirstName.hasFocus) {
        _guestUserDetailController.checkFirstNameValidation();
        _guestUserDetailController.updateTextState();
      }
    });

    focusNodeGuestLastName.addListener(() {
      if (!focusNodeGuestLastName.hasFocus) {
        _guestUserDetailController.checkLastNameValidation();
        _guestUserDetailController.updateTextState();
      }
    });

    _otaCountDownController = OtaCountDownController(
        durationInSecond:
            AppConfig().configModel.timerValue * _kSecondsInMinute,
        onComplete: () {
          _showTimeoutAlert();
        });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      reservationArgumentModel = ModalRoute.of(context)?.settings.arguments
          as ReservationArgumentModel;
      initialize();
    });
    resetPromoData();
    super.initState();
  }

  void initialize() async {
    _filterViewBloc.getFromArgument(reservationArgumentModel);
    _yourListBloc.getFromApiCall(_filterViewBloc, reservationArgumentModel);
    _userDetailBloc.getFromApiCall(reservationArgumentModel);
    _addonsListBloc.getFromApiCall(reservationArgumentModel);
    _yourListBloc.stream.listen((event) {
      if (_yourListBloc.state.yourListViewModelState ==
          YourListViewModelState.loaded) {
        _getAppFlyerData();
        AppFlyerHelper.stopCapturingEvent(AppFlyerEvent.hotelReservationEvent);
        if (isRoomUnAvailable()) {
          _showRoomUnavailableAlert();
        } else if (isRoomPriceChanged()) {
          _showPriceChangeAlert();
        } else {
          _otaCountDownController.startTimer();
        }
      } else if (_yourListBloc.state.yourListViewModelState ==
          YourListViewModelState.internetFailure) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
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
          title:
              getTranslated(context, AppLocalizationsStrings.roomReservation),
          titleColor: AppColors.kGrey70,
          key: const Key("back_button_icon"),
        ),
        body: BlocBuilder(
            bloc: _yourListBloc,
            builder: () {
              switch (_yourListBloc.state.yourListViewModelState) {
                case YourListViewModelState.loaded:
                  return successWidget();
                case YourListViewModelState.initial:
                  return defaultWidget();
                case YourListViewModelState.loading:
                  return loadIngWidget();
                case YourListViewModelState.failed:
                case YourListViewModelState.internetFailure:
                  return failureState();
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

  Widget failureState() {
    return ReservationErrorWidget(
      height: MediaQuery.of(context).size.height - _kAppBarHeight,
      onRefresh: () async {
        _filterViewBloc.getFromArgument(reservationArgumentModel);
        _yourListBloc.getFromApiCall(_filterViewBloc, reservationArgumentModel);
        _userDetailBloc.getFromApiCall(reservationArgumentModel);
        _addonsListBloc.getFromApiCall(reservationArgumentModel);
      },
    );
  }

  Widget _getSpecialPromotion(BuildContext context) {
    List<OtaPromotionModel> specialPromotionList =
        _yourListBloc.state.specialPromotionDetailList;
    if (specialPromotionList.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSize24),
        child: Column(
          children: [
            OtaRoomSpecialPromotionWidget(
              header: getTranslated(
                  context, AppLocalizationsStrings.specialPromotion),
              specialPromotionList: specialPromotionList,
              bottomDetail: getTranslated(
                  context, AppLocalizationsStrings.promotionTNCreview),
            ),
            const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget successWidget() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Stack(
        children: [
          SafeArea(
            minimum: const EdgeInsets.only(bottom: kSize100),
            child: ListView(
              padding: const EdgeInsets.only(top: _kTopPadding),
              children: <Widget>[
                getReservationRoomInfo(),
                getReservationDetails(),
                getHotelAddonServiceList(),
                _getSpecialPromotion(context),
                if (_yourListBloc.state.freeFoodPromotions.isNotEmpty) ...[
                  getPrivileges(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: kSize24),
                    child:
                        OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
                  ),
                ],
                getCancellationPolicyList(),
                getAddonServices(),
                getAdditionalNeedsWidget(),
                getMembershipWidget(),
                getUserName(),
                getGuestUserWidget(),
              ],
            ),
          ),
          _getBottomBar(context),
          OtaCountDownTimer(
            label: AppLocalizationsStrings.countdownTitle,
            controller: _otaCountDownController,
          ),
        ],
      ),
    );
  }

  Widget getUserName() {
    return BlocBuilder(
        bloc: _userDetailBloc,
        builder: () {
          if (_userDetailBloc.state.userDetailViewModelDataState !=
              UserDetailViewModelDataState.loaded) {
            return const SizedBox();
          }
          return GuestInformationFieldWidget(
            firstName: _userDetailBloc.state.firstName,
            lastName: _userDetailBloc.state.secondName,
            phoneNumber: _userDetailBloc.state.mobileNumber,
            onTitleArrowClick: _openGuestInfoPage,
            isBookForSomeoneElse: _userDetailBloc.state.buttonState ==
                OtaRadioButtonState.selected,
          );
        });
  }

  Widget getGuestUserWidget() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        GuestUserDetailWidget(
          firstNameController: _nameController,
          lastNameController: _lastNameController,
          guestUserDetailController: _guestUserDetailController,
          guestFirstName: focusNodeGuestFirstName,
          guestLastName: focusNodeGuestLastName,
          onRadioBtnClicked: _onRadioBtnClicked,
        ),
        const SizedBox(
          height: _kTotalBottomSpacing,
        ),
      ],
    );
  }

  void _onRadioBtnClicked() {
    _userDetailBloc.isBookForSomeoneElse(
        _guestUserDetailController.state.otaRadioButtonBloc!);
    return;
  }

  void _openGuestInfoPage() {
    Navigator.pushNamed(context, AppRoutes.contactInformationFormPage,
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

  Widget getAddonServices() {
    return BlocBuilder(
        bloc: _addonsListBloc,
        builder: () {
          if (_addonsListBloc.state.addonsNetworkState !=
              AddonsNetworkState.loaded) {
            return const SizedBox();
          }
          List<AddonsModel> models = _addonsListBloc.getUnselectedAddons();
          if (models.isEmpty) {
            return const SizedBox();
          }
          return ServiceCarouselWidget(
            serviceList: models,
            onItemClicked: (index) async {
              int addOnIndex = _addonsListBloc.getAddonIndex(models[index]);
              if (addOnIndex >= 0) {
                addOnIndexSelected.add((addOnIndex + 1).toString());
              }
              var data = await Navigator.pushNamed(
                context,
                AppRoutes.addonServiceCalendarScreen,
                arguments: AddonServiceCalendarArgument(
                  price: double.tryParse(models.elementAt(index).cost) ?? 0,
                  title: models.elementAt(index).serviceName,
                  description: models.elementAt(index).description,
                  checkInDate: Helpers.getYYYYmmddFromDateTime(
                      reservationArgumentModel?.fromDate),
                  checkOutDate: Helpers.getYYYYmmddFromDateTime(
                      reservationArgumentModel?.toDate),
                  noOfAdults: reservationArgumentModel?.getAdultCount() ??
                      AppConfig().configModel.defaultAdultCount,
                  currency: reservationArgumentModel?.currency ?? 'TBH',
                  imageUrl: models.elementAt(index).imageUrl,
                  uniqueId: models.elementAt(index).uniqueId,
                  isFlight: models.elementAt(index).isFlight,
                ),
              );
              if (data != null) {
                printDebug('++++++++++++++');
                printDebug(models.elementAt(index).uniqueId);
                printDebug('++++++++++++++');

                AddonServiceViewModel model = data as AddonServiceViewModel;
                _addonsListBloc.setSelected(
                  AddonsModel(
                    description: model.description,
                    serviceName: model.title,
                    uniqueId: models.elementAt(index).uniqueId,
                    quantity: model.quantity.toString(),
                    cost: models.elementAt(index).cost,
                    imageUrl: models.elementAt(index).imageUrl,
                    selectedDate: model.serviceSelectedDate,
                    isFlight: model.isFlight,
                  ),
                );
              }
            },
          );
        });
  }

  Widget getAdditionalNeedsWidget() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const SizedBox(
          height: kSize24,
        ),
        MemberTextWidget(
            headerText: getTranslated(
                context, AppLocalizationsStrings.additionalRequests),
            subText: getTranslated(
                context, AppLocalizationsStrings.roomAvailability),
            textController: _additionalNeed,
            characterCount: _kAdditionalTextCharacterCount,
            textFormatter: r'[A-Za-z\u0E00-\u0E7F0-9 ]',
            invalidFormatter: r'[฿]',
            maxLines: null,
            hintMemberText: getTranslated(
                context, AppLocalizationsStrings.hintAdditionalText)),
      ],
    );
  }

  Widget getMembershipWidget() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const SizedBox(
          height: kSize24,
        ),
        MemberTextWidget(
            headerText: getTranslated(
                context, AppLocalizationsStrings.membershipNumber),
            subText: getTranslated(
                context, AppLocalizationsStrings.enterMembershipNumber),
            textController: _memberText,
            characterCount: _kMemberTextCharacterCount,
            textFormatter: r'[A-Za-z0-9 ]',
            invalidFormatter: '',
            maxLines: _kMaxlines,
            hintMemberText: getTranslated(
                context, AppLocalizationsStrings.hintMembershipText)),
      ],
    );
  }

  Widget getHotelAddonServiceList() {
    return BlocBuilder(
        bloc: _addonsListBloc,
        builder: () {
          if (_addonsListBloc.state.addonsNetworkState !=
              AddonsNetworkState.loaded) {
            return const SizedBox();
          }
          List<AddonsModel> models = _addonsListBloc.getSelectedAddons();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: kSize24),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return OtaHotelAddonServiceTile(
                  name: models.elementAt(index).serviceName,
                  price: double.tryParse(models.elementAt(index).cost) ?? 0,
                  currency: reservationArgumentModel?.currency ?? "",
                  quantity: models.elementAt(index).quantity,
                  requestDate:
                      models.elementAt(index).selectedDate ?? DateTime.now(),
                  showHeader: index == 0 ? true : false,
                  onAddItemsTap: () {
                    final hotelViewArgument = HotelServiceViewArgument.from(
                        reservationArgumentModel?.hotelId ?? '',
                        reservationArgumentModel?.fromDate ?? DateTime.now(),
                        reservationArgumentModel?.toDate ?? DateTime.now(),
                        reservationArgumentModel?.currency ?? 'THB',
                        reservationArgumentModel?.getAdultCount() ??
                            AppConfig().configModel.defaultAdultCount,
                        models, (model) {
                      _addonsListBloc.setSelected(
                        AddonsModel(
                          description: model.description,
                          serviceName: model.title,
                          uniqueId: model.uniqueId,
                          quantity: model.quantity.toString(),
                          cost: model.price.toString(),
                          imageUrl: model.imageUrl,
                          selectedDate: model.serviceSelectedDate,
                          isFlight: model.isFlight,
                        ),
                      );
                    });

                    Navigator.pushNamed(
                        context, AppRoutes.hotelAddonServiceScreen,
                        arguments: hotelViewArgument);
                  },
                  onEditTap: () async {
                    var data = await Navigator.pushNamed(
                      context,
                      AppRoutes.addonServiceCalendarScreen,
                      arguments: AddonServiceCalendarArgument(
                        price:
                            double.tryParse(models.elementAt(index).cost) ?? 0,
                        title: models.elementAt(index).serviceName,
                        description: models.elementAt(index).description,
                        checkInDate: Helpers.getYYYYmmddFromDateTime(
                            reservationArgumentModel?.fromDate),
                        checkOutDate: Helpers.getYYYYmmddFromDateTime(
                            reservationArgumentModel?.toDate),
                        noOfAdults: reservationArgumentModel?.getAdultCount() ??
                            AppConfig().configModel.defaultChildCount,
                        serviceSelectedDate: Helpers.getYYYYmmddFromDateTime(
                            models.elementAt(index).selectedDate),
                        preselectedDates: _addonsListBloc
                            .getListOfSelectedDateTime(models.elementAt(index)),
                        quantity:
                            int.tryParse(models.elementAt(index).quantity) ?? 0,
                        currency: reservationArgumentModel?.currency ?? 'TBH',
                        imageUrl: models.elementAt(index).imageUrl,
                        uniqueId: models.elementAt(index).uniqueId,
                        isFlight: models.elementAt(index).isFlight,
                      ),
                    );
                    if (data != null) {
                      AddonServiceViewModel model =
                          data as AddonServiceViewModel;
                      if (model.quantity > 0) {
                        _addonsListBloc.setSelected(AddonsModel(
                          description: model.description,
                          serviceName: model.title,
                          uniqueId: models.elementAt(index).uniqueId,
                          quantity: model.quantity.toString(),
                          cost: models.elementAt(index).cost,
                          imageUrl: models.elementAt(index).imageUrl,
                          selectedDate: model.serviceSelectedDate,
                          isFlight: model.isFlight,
                        ));
                      }
                      _addonsListBloc.setUnSelected(models.elementAt(index));
                    }
                  },
                );
              },
              itemCount: models.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
          );
        });
  }

  Widget getReservationDetails() {
    return BlocBuilder(
        bloc: _filterViewBloc,
        builder: () {
          return OtaReservationDetailsWidget(
            checkInDate: Helpers().parseDateTime(
                Helpers.getYYYYmmddFromDateTime(
                    _filterViewBloc.state.fromDate)),
            checkOutDate: Helpers().parseDateTime(
                Helpers.getYYYYmmddFromDateTime(_filterViewBloc.state.toDate)),
            numberOfAdults: int.tryParse(_filterViewBloc.state.adultsCount) ??
                AppConfig().configModel.defaultAdultCount,
            numberOfNights:
                int.tryParse(_filterViewBloc.state.nightsCount) ?? 0,
            numberOfRooms: int.tryParse(_filterViewBloc.state.roomCount) ?? 0,
            numberOfChildren: int.tryParse(_filterViewBloc.state.childCount) ??
                AppConfig().configModel.defaultChildCount,
            nightLabel: AppLocalizationsStrings.nights,
          );
        });
  }

  bool isRoomPriceChanged() {
    double? updatedPrice = double.tryParse(_yourListBloc.state.price);
    if (updatedPrice == null) return false;
    if (lastPrice != -1 && lastPrice != updatedPrice) {
      lastPrice = updatedPrice;
      return true;
    }
    lastPrice = updatedPrice;
    return false;
  }

  bool isRoomUnAvailable() {
    if (_yourListBloc.state.isRoomAvailable) return false;
    return true;
  }

  void resetPromoData() {
    Provider.of<PromoWidgetViewModel>(context, listen: false)
        .setPromoWidgetViewModelData(PromoWidgetViewModel());
  }

  void refreshReviewPage() {
    resetPromoData();
    _yourListBloc.getFromApiCall(_filterViewBloc, reservationArgumentModel);
  }

  void _showTimeoutAlert() {
    OtaAlertDialog(
        errorMessage:
            getTranslated(context, AppLocalizationsStrings.timerTimeOutMessage),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
        useRootNavigator: false,
        onPressed: () {
          Navigator.popUntil(context,
              (route) => route.settings.name == AppRoutes.reservationScreen);
          _otaCountDownController.resetTimer();
          _addonsListBloc.clearAddons();
          refreshReviewPage();
        }).showAlertDialog(context);
  }

  void _showRoomUnavailableAlert() {
    _otaCountDownController.stopTimer();
    OtaAlertDialog(
        errorMessage: getTranslated(
            context, AppLocalizationsStrings.roomUnavailableMessage),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
        onPressed: () {
          Navigator.of(context).pop();
          //Navigate to property screen/hotel detail
          Navigator.popUntil(
              context, (route) => route.settings.name == AppRoutes.hotelDetail);
          Provider.of<HotelDetailStatus>(context, listen: false)
              .updateHotelDetailView();
        }).showAlertDialog(context);
  }

  void _showPriceChangeAlert() {
    _otaCountDownController.stopTimer();
    OtaAlertDialog(
        errorMessage: getTranslated(
            context, AppLocalizationsStrings.roomPriceChangeMessage),
        errorTitle: getTranslated(
            context, AppLocalizationsStrings.roomPriceChangeTitle),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.agree),
        onPressed: () {
          Navigator.of(context).pop();
          _otaCountDownController.startTimer();
          //Update price info.
        }).showAlertDialog(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _additionalNeed.dispose();
    _memberText.dispose();
    _yourListBloc.dispose();
    _userDetailBloc.dispose();
    _addonsListBloc.dispose();
    _filterViewBloc.dispose();
    _otaCountDownController.dispose();
    super.dispose();
  }

  Widget getReservationRoomInfo() {
    return ReservationRoomInfo(
      cancellationPolicy: _yourListBloc.state.cancellationPolicy,
      facilityMap: _yourListBloc.state.facilitiesList,
      roomDetailsList: _yourListBloc.state.categoriesList,
      imageUrl: _yourListBloc.state.imageUrl,
      offerName: _yourListBloc.state.roomTitle,
      pricePerNight: double.tryParse(_yourListBloc.state.price),
      propertyName: _yourListBloc.state.hotelName,
      addressText: _yourListBloc.state.address,
      ratingText: _yourListBloc.state.rating,
    );
  }

  Widget _getBottomBar(BuildContext context) {
    CurrencyUtil currencyUtil =
        CurrencyUtil(currency: reservationArgumentModel?.currency);

    return OtaBottomButtonBar(
      safeAreaBottom: false,
      button1: BlocBuilder(
          bloc: _yourListBloc,
          builder: () {
            return BlocBuilder(
                bloc: _addonsListBloc,
                builder: () {
                  return RichText(
                      key: const Key("Total_Price"),
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyText1,
                        children: <TextSpan>[
                          TextSpan(
                              text: currencyUtil.getFormattedPrice(
                                _addonsListBloc.getTotalAmount(double.tryParse(
                                        _yourListBloc.state.totalPrice) ??
                                    0),
                              ),
                              style: AppTheme.kHeading1Medium),
                          TextSpan(
                              text: formNextLine +
                                  getTranslated(context,
                                      AppLocalizationsStrings.totalPrice),
                              style: AppTheme.kSmallRegular
                                  .copyWith(color: AppColors.kGrey50))
                        ],
                      ));
                });
          }),
      button2: BlocBuilder(
          bloc: _userDetailBloc,
          builder: () {
            return BlocBuilder(
                bloc: _guestUserDetailController,
                builder: () {
                  return OtaTextButton(
                    key: const Key("BookNowButton"),
                    title:
                        getTranslated(context, AppLocalizationsStrings.confirm),
                    textHorizontalPadding: kSize32,
                    isDisabled: !isConfirmEnabled(),
                    onPressed: () {
                      getEnhancementHotelBookingSuccess(
                          FirebaseEvent.hotelBookingSuccess);
                      getEnhancementValues(FirebaseEvent.hotelPayment);
                      getEnhancementsHotelPaymentErrorPop(
                          FirebaseEvent.hotelPaymentError);
                      getEnhancementsHotelPaymentErrorPop(
                          FirebaseEvent.hotelPromoRedeemError);
                      if (_guestUserDetailController
                          .isReservingForSomeoneElse()) {
                        if (_guestUserDetailController.isValidationSuccess()) {
                          printDebug("Success");
                          _getAppFlyerViewData();
                          _getFirebaseEvent();
                          FirebaseHelper.stopCapturingEvent(
                              FirebaseEvent.hotelBookingReview);
                          navigateToPaymentScreen();
                        }
                      } else if (_userDetailBloc.state.secondName.isNotEmpty &&
                          !kInvalidNameFormatter
                              .hasMatch(_userDetailBloc.state.firstName) &&
                          !kInvalidNameFormatter
                              .hasMatch(_userDetailBloc.state.secondName)) {
                        printDebug("Success");
                        _getAppFlyerViewData();

                        _getFirebaseEvent();
                        FirebaseHelper.stopCapturingEvent(
                            FirebaseEvent.hotelBookingReview);
                        navigateToPaymentScreen();
                      }
                    },
                  );
                });
          }),
    );
  }

  bool isConfirmEnabled() {
    if (_guestUserDetailController.isReservingForSomeoneElse()) {
      return _guestUserDetailController.isValidationConfirmed();
    } else {
      return _userDetailBloc.state.secondName.isNotEmpty &&
          !kInvalidNameFormatter.hasMatch(_userDetailBloc.state.firstName) &&
          !kInvalidNameFormatter.hasMatch(_userDetailBloc.state.secondName);
    }
  }

  void navigateToPaymentScreen() {
    Navigator.pushNamed(
      context,
      AppRoutes.hotelPaymentMainScreen,
      arguments: HotelPaymentMainArgumentModel(
        otaCountDownController: _otaCountDownController,
        totalCost: _yourListBloc.state.totalPrice,
        addonsModels: _addonsListBloc.getSelectedForArgument(),
        lastName: _userDetailBloc.state.secondName,
        firstName: _userDetailBloc.state.firstName,
        secondGuestName: _guestUserDetailController.isReservingForSomeoneElse()
            ? _lastNameController.text
            : "",
        firstGuestName: _guestUserDetailController.isReservingForSomeoneElse()
            ? _nameController.text
            : "",
        membershipId: _memberText.text,
        bookingUrn: _yourListBloc.state.bookingUrn,
        additionalNeedsText: _additionalNeed.text,
        roomCode: reservationArgumentModel!.roomCode,
        hotelId: reservationArgumentModel!.hotelId,
        freefoodDelivery: reservationArgumentModel!.freefoodDelivery,
      ),
    );
  }

  Widget getCancellationPolicyList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: kSize24,
          ),
          OtaCancellationPolicyListWidget(
            cancellationPolicyModel: _yourListBloc.state.cancellationPolicyList,
          ),
          const SizedBox(
            height: kSize8,
          ),
          const OtaHorizontalDivider(
            dividerColor: AppColors.kGrey10,
          ),
        ],
      ),
    );
  }

  Widget getPrivileges() {
    return Padding(
      padding: const EdgeInsets.all(kSize24),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                getTranslated(
                    context, AppLocalizationsStrings.robinhoodPrivileges),
                style: AppTheme.kHeading1Medium,
                maxLines: _kMaxlines,
                overflow: TextOverflow.ellipsis),
            const SizedBox(
              height: kSize16,
            ),
            OtaFreeFoodBannerWidget(
              freeFoodPromotionList: _yourListBloc.state.freeFoodPromotions,
            ),
          ]),
    );
  }

  void _getAppFlyerData() {
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelReservationEvent,
        key: HotelReservationAppFlyer.hotelId,
        value: reservationArgumentModel?.hotelId);
    AppFlyerHelper.addCurrency(
        eventName: AppFlyerEvent.hotelReservationEvent,
        key: HotelReservationAppFlyer.hotelCurrency);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelReservationEvent,
        key: HotelReservationAppFlyer.hotelStarRating,
        value: _yourListBloc.state.rating);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelReservationEvent,
        key: HotelReservationAppFlyer.hotelRoomId,
        value: reservationArgumentModel?.roomCode);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelReservationEvent,
        key: HotelReservationAppFlyer.hotelRoomClass,
        value: _yourListBloc.state.categoriesList.first.category);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.hotelReservationEvent,
        key: HotelReservationAppFlyer.hotelRoomPrice,
        value: double.tryParse(_yourListBloc.state.price));
    AppFlyerHelper.addDateValue(
        eventName: AppFlyerEvent.hotelReservationEvent,
        key: HotelReservationAppFlyer.hotelCheckInDate,
        value: reservationArgumentModel?.fromDate);
    AppFlyerHelper.addDateValue(
        eventName: AppFlyerEvent.hotelReservationEvent,
        key: HotelReservationAppFlyer.hotelCheckOutDate,
        value: reservationArgumentModel?.toDate);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelReservationEvent,
        key: HotelReservationAppFlyer.hotelStayPeriod,
        value: _filterViewBloc.state.nightsCount);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelReservationEvent,
        key: HotelReservationAppFlyer.hotelLocation,
        value: _yourListBloc.state.address);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelReservationEvent,
        key: HotelReservationAppFlyer.hotelAdultCount,
        value: _filterViewBloc.state.adultsCount);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelReservationEvent,
        key: HotelReservationAppFlyer.hotelChildCount,
        value: _filterViewBloc.state.childCount);
    AppFlyerHelper.addUserLocation(
        eventName: AppFlyerEvent.hotelReservationEvent);

    AppFlyerHelper.addCommaSeparatedList(
        eventName: AppFlyerEvent.hotelReservationEvent,
        value:
            _yourListBloc.state.freeFoodPromotions.map((e) => e.line1).toList(),
        key: HotelReservationAppFlyer.hotelPromoType);

    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentEvent,
        key: HotelPaymentAppFlyer.hotelStarRating,
        value: _yourListBloc.state.rating);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentEvent,
        key: HotelPaymentAppFlyer.hotelRoomId,
        value: reservationArgumentModel?.roomCode);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentEvent,
        key: HotelPaymentAppFlyer.hotelLocation,
        value: _yourListBloc.state.address);

    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentSuccessEvent,
        key: HotelPaymentSuccessAppFlyer.hotelStarRating,
        value: _yourListBloc.state.rating);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentSuccessEvent,
        key: HotelPaymentSuccessAppFlyer.hotelLocation,
        value: _yourListBloc.state.address);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentSuccessEvent,
        key: HotelPaymentSuccessAppFlyer.hotelRoomId,
        value: reservationArgumentModel?.roomCode);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentSuccessFirstBookingEvent,
        key: HotelPaymentSuccessAppFlyer.hotelStarRating,
        value: _yourListBloc.state.rating);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentSuccessFirstBookingEvent,
        key: HotelPaymentSuccessAppFlyer.hotelLocation,
        value: _yourListBloc.state.address);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentSuccessFirstBookingEvent,
        key: HotelPaymentSuccessAppFlyer.hotelRoomId,
        value: reservationArgumentModel?.roomCode);
    _getAddOnData(_addonsListBloc.getSelectedAddons());
  }

  void _getAppFlyerViewData() {
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentViewEvent,
        key: HotelPaymentViewAppFlyer.hotelId,
        value: reservationArgumentModel?.hotelId);
    AppFlyerHelper.addCurrency(
        eventName: AppFlyerEvent.hotelPaymentViewEvent,
        key: HotelPaymentViewAppFlyer.hotelCurrency);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentViewEvent,
        key: HotelPaymentViewAppFlyer.hotelStarRating,
        value: _yourListBloc.state.rating);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentViewEvent,
        key: HotelPaymentViewAppFlyer.hotelRoomId,
        value: reservationArgumentModel?.roomCode);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentViewEvent,
        key: HotelPaymentViewAppFlyer.hotelRoomClass,
        value: _yourListBloc.state.categoriesList.first.category);
    AppFlyerHelper.addDoubleValue(
        eventName: AppFlyerEvent.hotelPaymentViewEvent,
        key: HotelPaymentViewAppFlyer.hotelRoomPrice,
        value: double.tryParse(_yourListBloc.state.price));
    AppFlyerHelper.addDateValue(
        eventName: AppFlyerEvent.hotelPaymentViewEvent,
        key: HotelPaymentViewAppFlyer.hotelCheckInDate,
        value: reservationArgumentModel?.fromDate);
    AppFlyerHelper.addDateValue(
        eventName: AppFlyerEvent.hotelPaymentViewEvent,
        key: HotelPaymentViewAppFlyer.hotelCheckOutDate,
        value: reservationArgumentModel?.toDate);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentViewEvent,
        key: HotelPaymentViewAppFlyer.hotelStayPeriod,
        value: _filterViewBloc.state.nightsCount);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentViewEvent,
        key: HotelPaymentViewAppFlyer.hotelLocation,
        value: _yourListBloc.state.address);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentViewEvent,
        key: HotelPaymentViewAppFlyer.hotelAdultCount,
        value: _filterViewBloc.state.adultsCount);
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelPaymentViewEvent,
        key: HotelPaymentViewAppFlyer.hotelChildCount,
        value: _filterViewBloc.state.childCount);
    AppFlyerHelper.addUserLocation(
        eventName: AppFlyerEvent.hotelPaymentViewEvent);

    AppFlyerHelper.addCommaSeparatedList(
        eventName: AppFlyerEvent.hotelPaymentViewEvent,
        value:
            _yourListBloc.state.freeFoodPromotions.map((e) => e.line1).toList(),
        key: HotelPaymentViewAppFlyer.hotelPromoType);

    _getAddOnData(_addonsListBloc.getSelectedAddons());
    AppFlyerHelper.stopCapturingEvent(AppFlyerEvent.hotelPaymentViewEvent);
  }

  void _getAddOnData(List<AddonsModel>? models) {
    double price = 0.0;
    double addonCost = 0.0;
    int quantity = 0;
    if (models == null) {
      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.hotelPaymentEvent,
          key: HotelPaymentAppFlyer.hotelEnhancement,
          value: "No");

      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.hotelPaymentSuccessEvent,
          key: HotelPaymentSuccessAppFlyer.hotelEnhancement,
          value: "No");
      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.hotelPaymentSuccessFirstBookingEvent,
          key: HotelPaymentSuccessAppFlyer.hotelEnhancement,
          value: "No");

      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.hotelPaymentViewEvent,
          key: HotelPaymentViewAppFlyer.hotelEnhancement,
          value: "No");

      AppFlyerHelper.addDoubleValue(
          eventName: AppFlyerEvent.hotelPaymentEvent,
          key: HotelPaymentAppFlyer.hotelEnhancementPrice,
          value: 0.0);

      AppFlyerHelper.addDoubleValue(
          eventName: AppFlyerEvent.hotelPaymentSuccessEvent,
          key: HotelPaymentSuccessAppFlyer.hotelEnhancementPrice,
          value: 0.0);
      AppFlyerHelper.addDoubleValue(
          eventName: AppFlyerEvent.hotelPaymentSuccessFirstBookingEvent,
          key: HotelPaymentSuccessAppFlyer.hotelEnhancementPrice,
          value: 0.0);

      AppFlyerHelper.addDoubleValue(
          eventName: AppFlyerEvent.hotelPaymentViewEvent,
          key: HotelPaymentViewAppFlyer.hotelEnhancementPrice,
          value: 0.0);
    } else if (models.isEmpty) {
      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.hotelPaymentEvent,
          key: HotelPaymentAppFlyer.hotelEnhancement,
          value: "No");

      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.hotelPaymentSuccessEvent,
          key: HotelPaymentSuccessAppFlyer.hotelEnhancement,
          value: "No");
      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.hotelPaymentSuccessFirstBookingEvent,
          key: HotelPaymentSuccessAppFlyer.hotelEnhancement,
          value: "No");

      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.hotelPaymentViewEvent,
          key: HotelPaymentViewAppFlyer.hotelEnhancement,
          value: "No");
      AppFlyerHelper.addDoubleValue(
          eventName: AppFlyerEvent.hotelPaymentEvent,
          key: HotelPaymentAppFlyer.hotelEnhancementPrice,
          value: 0.0);

      AppFlyerHelper.addDoubleValue(
          eventName: AppFlyerEvent.hotelPaymentSuccessEvent,
          key: HotelPaymentSuccessAppFlyer.hotelEnhancementPrice,
          value: 0.0);
      AppFlyerHelper.addDoubleValue(
          eventName: AppFlyerEvent.hotelPaymentSuccessFirstBookingEvent,
          key: HotelPaymentSuccessAppFlyer.hotelEnhancementPrice,
          value: 0.0);

      AppFlyerHelper.addDoubleValue(
          eventName: AppFlyerEvent.hotelPaymentViewEvent,
          key: HotelPaymentViewAppFlyer.hotelEnhancementPrice,
          value: 0.0);
    } else {
      for (int i = 0; i < models.length; i++) {
        addonCost = double.tryParse(models[i].cost) ?? 0.0;
        quantity = int.tryParse(models[i].quantity) ?? 0;
        addonCost = addonCost * quantity;
        price += addonCost;
      }
      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.hotelPaymentEvent,
          key: HotelPaymentAppFlyer.hotelEnhancement,
          value: "Yes");

      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.hotelPaymentSuccessEvent,
          key: HotelPaymentSuccessAppFlyer.hotelEnhancement,
          value: "Yes");
      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.hotelPaymentSuccessFirstBookingEvent,
          key: HotelPaymentSuccessAppFlyer.hotelEnhancement,
          value: "Yes");

      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.hotelPaymentViewEvent,
          key: HotelPaymentViewAppFlyer.hotelEnhancement,
          value: "Yes");
      AppFlyerHelper.addDoubleValue(
          eventName: AppFlyerEvent.hotelPaymentEvent,
          key: HotelPaymentAppFlyer.hotelEnhancementPrice,
          value: price);

      AppFlyerHelper.addDoubleValue(
          eventName: AppFlyerEvent.hotelPaymentSuccessEvent,
          key: HotelPaymentSuccessAppFlyer.hotelEnhancementPrice,
          value: price);
      AppFlyerHelper.addDoubleValue(
          eventName: AppFlyerEvent.hotelPaymentSuccessFirstBookingEvent,
          key: HotelPaymentSuccessAppFlyer.hotelEnhancementPrice,
          value: price);

      AppFlyerHelper.addDoubleValue(
          eventName: AppFlyerEvent.hotelPaymentViewEvent,
          key: HotelPaymentViewAppFlyer.hotelEnhancementPrice,
          value: price);
    }
  }

  void _getFirebaseEvent() {
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelBookingReview,
        key: HotelBookingReviewFirebase.hotelId,
        value: reservationArgumentModel?.hotelId);

    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelBookingReview,
        key: HotelBookingReviewFirebase.hotelName,
        value: _yourListBloc.state.hotelName);

    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelBookingReview,
        key: HotelBookingReviewFirebase.hotelSpecialRequest,
        value: _additionalNeed.text);

    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelBookingReview,
        key: HotelBookingReviewFirebase.hotelMembership,
        value: _memberText.text);

    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelBookingReview,
        key: HotelBookingReviewFirebase.hotelBookForOthers,
        value: _getBookForOthers());

    FirebaseHelper.addDoubleValue(
        eventName: FirebaseEvent.hotelBookingReview,
        key: HotelBookingReviewFirebase.hotelTotalPrice,
        value: _addonsListBloc.getTotalAmount(
            double.tryParse(_yourListBloc.state.totalPrice) ?? 0));

    FirebaseHelper.addDoubleValue(
        eventName: FirebaseEvent.hotelBookingReview,
        key: HotelBookingReviewFirebase.hotelPricePerNight,
        value: double.tryParse(_yourListBloc.state.price));
    FirebaseHelper.addCommaSeparatedList(
        eventName: FirebaseEvent.hotelBookingReview,
        key: HotelBookingReviewFirebase.hotelEnhancementName,
        value: _addonsListBloc
            .getSelectedAddons()
            .map((e) => e.serviceName)
            .toList());
    FirebaseHelper.addCommaSeparatedList(
      eventName: FirebaseEvent.hotelBookingReview,
      key: HotelBookingReviewFirebase.hotelEnhancementNo,
      value:
          _addonsListBloc.getSelectedAddons().map((e) => e.quantity).toList(),
    );
    FirebaseHelper.addCommaSeparatedList(
        eventName: FirebaseEvent.hotelBookingReview,
        key: HotelBookingReviewFirebase.hotelEnhancementPrice,
        value: _addonsListBloc.getSelectedAddons().map((e) => e.cost).toList());
    FirebaseHelper.addCommaSeparatedList(
        eventName: FirebaseEvent.hotelBookingReview,
        key: HotelBookingReviewFirebase.hotelEnhancementSequence,
        value: addOnIndexSelected);
  }

  String _getBookForOthers() {
    const String prefixTitle = 'Khun';
    if (_guestUserDetailController.isReservingForSomeoneElse()) {
      return '${_lastNameController.text} ${_nameController.text}, '
          '$prefixTitle';
    } else {
      return "";
    }
  }

  getEnhancementValues(String eventName) {
    FirebaseHelper.addCommaSeparatedList(
        eventName: eventName,
        key: HotelPaymentReviewFirebase.hotelEnhancementName,
        value: _addonsListBloc
            .getSelectedAddons()
            .map((e) => e.serviceName)
            .toList());
    FirebaseHelper.addCommaSeparatedList(
      eventName: eventName,
      key: HotelPaymentReviewFirebase.hotelEnhancementNo,
      value:
          _addonsListBloc.getSelectedAddons().map((e) => e.quantity).toList(),
    );
    FirebaseHelper.addCommaSeparatedList(
        eventName: eventName,
        key: HotelPaymentReviewFirebase.hotelEnhancementPrice,
        value: _addonsListBloc.getSelectedAddons().map((e) => e.cost).toList());
    FirebaseHelper.addCommaSeparatedList(
        eventName: FirebaseEvent.hotelPayment,
        key: HotelPaymentReviewFirebase.hotelEnhancementSequence,
        value: addOnIndexSelected);
  }

  getEnhancementHotelBookingSuccess(String eventName) {
    FirebaseHelper.addKeyValue(
        key: HotelSuccessPaymentFirebase.hotelId,
        eventName: eventName,
        value: reservationArgumentModel?.hotelId);
    FirebaseHelper.addCommaSeparatedList(
        eventName: eventName,
        key: HotelSuccessPaymentFirebase.enhancementName,
        value: _addonsListBloc
            .getSelectedAddons()
            .map((e) => e.serviceName)
            .toList());
    FirebaseHelper.addCommaSeparatedList(
      eventName: eventName,
      key: HotelSuccessPaymentFirebase.enhancementNo,
      value:
          _addonsListBloc.getSelectedAddons().map((e) => e.quantity).toList(),
    );
    FirebaseHelper.addCommaSeparatedList(
        eventName: eventName,
        key: HotelSuccessPaymentFirebase.enhancementPrice,
        value: _addonsListBloc.getSelectedAddons().map((e) => e.cost).toList());
    FirebaseHelper.addCommaSeparatedList(
        eventName: eventName,
        key: HotelSuccessPaymentFirebase.enhancementSequence,
        value: addOnIndexSelected);
  }

  getEnhancementsHotelPaymentErrorPop(String eventName) {
    FirebaseHelper.addCommaSeparatedList(
        eventName: eventName,
        key: HotelPaymentReviewFirebase.hotelEnhancementName,
        value: _addonsListBloc
            .getSelectedAddons()
            .map((e) => e.serviceName)
            .toList());
    FirebaseHelper.addCommaSeparatedList(
      eventName: eventName,
      key: HotelPaymentReviewFirebase.hotelEnhancementNo,
      value:
          _addonsListBloc.getSelectedAddons().map((e) => e.quantity).toList(),
    );
    FirebaseHelper.addCommaSeparatedList(
        eventName: eventName,
        key: HotelPaymentReviewFirebase.hotelEnhancementPrice,
        value: _addonsListBloc.getSelectedAddons().map((e) => e.cost).toList());
    FirebaseHelper.addCommaSeparatedList(
        eventName: eventName,
        key: HotelPaymentReviewFirebase.hotelEnhancementSequence,
        value: addOnIndexSelected);
  }
}
