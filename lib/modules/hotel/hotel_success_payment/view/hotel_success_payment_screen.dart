import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_helper.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_payment_success_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_addon_service_tile.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_reservation_details_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_reservation_service_card_list_view.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_success_payment_parameters.dart';
import 'package:ota/modules/hotel/hotel_success_payment/bloc/hotel_success_payment_bloc.dart';
import 'package:ota/modules/hotel/hotel_success_payment/helpers/hotel_success_payment_service_card_helper.dart';
import 'package:ota/modules/hotel/hotel_success_payment/view/widgets/hotel_success_payment_room_info_widget.dart';
import 'package:ota/modules/hotel/hotel_success_payment/view_model/hotel_success_payment_argument_model.dart';
import 'package:ota/modules/hotel/hotel_success_payment/view_model/hotel_success_payment_service_card_view_model.dart';
import 'package:ota/modules/hotel/hotel_success_payment/view_model/hotel_success_payment_view_model.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:provider/provider.dart';

const String _kCongratulationAssetName =
    "assets/images/icons/congratulation_image.svg";
const String _kCheckBoxAssetName = "assets/images/icons/yellow_check_box.svg";
const double _kSize91 = 91;
const int _maxLines = 1;
const double _kDividerHeight = 1;
const String _kHotelKey = "hotel_key";
const String _kAppFlyerHotelContentType = 'product';

class HotelSuccessPaymentScreen extends StatefulWidget {
  const HotelSuccessPaymentScreen({Key? key}) : super(key: key);

  @override
  HotelSuccessPaymentScreenState createState() =>
      HotelSuccessPaymentScreenState();
}

class HotelSuccessPaymentScreenState extends State<HotelSuccessPaymentScreen> {
  final HotelSuccessPaymentBloc _hotelSuccessPaymentBloc =
      HotelSuccessPaymentBloc();
  List<HotelSuccessPaymentServiceCardViewModel>? serviceViewModel;

  @override
  void initState() {
    HotelSuccessPaymentArgumentModel argument =
        Provider.of<HotelSuccessPaymentArgumentModel>(context, listen: false);
    _hotelSuccessPaymentBloc.loadFromArgument(argument);
    HotelPaymentSuccessAppFlyer.isFirstOrder
        ? _getAppFlyerData(AppFlyerEvent.hotelPaymentSuccessFirstBookingEvent,
            AppFlyerEvent.hotelPaymentSuccessEvent)
        : _getAppFlyerData(AppFlyerEvent.hotelPaymentSuccessEvent,
            AppFlyerEvent.hotelPaymentSuccessFirstBookingEvent);
    _triggerFirebaseEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.kLight100,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: AppColors.kPurpleOutline),
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
        ),
        body: BlocBuilder(
            bloc: _hotelSuccessPaymentBloc,
            builder: () {
              return _hotelSuccessPaymentBloc.state.state ==
                      HotelSuccessPaymentViewModelState.loaded
                  ? successWidget()
                  : const SizedBox();
            }),
      ),
    );
  }

  Widget successWidget() {
    serviceViewModel = HotelSuccessPaymentServiceCardHelper.getServiceCardList(
        context, _hotelSuccessPaymentBloc.state.argumentModel!);
    return Stack(
      children: [
        SafeArea(
          minimum: EdgeInsets.only(
              bottom: _kSize91 + MediaQuery.of(context).padding.bottom),
          child: ListView(
            children: [
              _getTopBar(),
              if (serviceViewModel != null && serviceViewModel!.isNotEmpty)
                _getServiceCards(serviceViewModel!.length),
              const SizedBox(
                height: kSize16,
              ),
              getReservationRoomInfo(),
              getReservationDetails(),
              getHotelAddonServiceList(),
            ],
          ),
        ),
        _getBottomBar(),
      ],
    );
  }

  Widget getHotelAddonServiceList() {
    List<AddonsModel>? models =
        _hotelSuccessPaymentBloc.state.argumentModel?.addonsModels;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return OtaHotelAddonServiceTile(
            name: models!.elementAt(index).serviceName ?? "",
            price: double.tryParse(models.elementAt(index).cost ?? "0") ?? 0,
            currency: _hotelSuccessPaymentBloc.state.argumentModel!.currency,
            quantity: models.elementAt(index).quantity!,
            requestDate: models.elementAt(index).selectedDate ?? DateTime.now(),
            showHeader: index == 0 ? true : false,
            isEditAvailable: false,
            isAddItemsAvailable: false,
          );
        },
        itemCount: models?.length ?? 0,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }

  Widget getReservationDetails() {
    return OtaReservationDetailsWidget(
      checkInDate: _hotelSuccessPaymentBloc.state.argumentModel!.checkInDate!,
      checkOutDate: _hotelSuccessPaymentBloc.state.argumentModel!.checkOutDate!,
      numberOfAdults:
          _hotelSuccessPaymentBloc.state.argumentModel!.numberOfAdults!,
      numberOfNights:
          _hotelSuccessPaymentBloc.state.argumentModel!.numberOfNights!,
      numberOfRooms:
          _hotelSuccessPaymentBloc.state.argumentModel!.numberOfRooms!,
      numberOfChildren:
          _hotelSuccessPaymentBloc.state.argumentModel!.numberOfChildren,
    );
  }

  @override
  void dispose() {
    _hotelSuccessPaymentBloc.dispose();
    super.dispose();
  }

  Widget getReservationRoomInfo() => HotelSuccessPaymentRoomInfoWidget(
        cancellationPolicy: _hotelSuccessPaymentBloc
            .state.argumentModel!.cancellationPolicyStatus,
        facilityMap: _hotelSuccessPaymentBloc.state.argumentModel!.facilityMap,
        roomDetailsList:
            _hotelSuccessPaymentBloc.state.argumentModel!.roomDetailsList,
        imageUrl: _hotelSuccessPaymentBloc.state.argumentModel!.imageUrl,
        offerName: _hotelSuccessPaymentBloc.state.argumentModel!.offerName,
        pricePerNight:
            _hotelSuccessPaymentBloc.state.argumentModel!.pricePerNight,
        propertyName:
            _hotelSuccessPaymentBloc.state.argumentModel!.propertyName,
        bookingID: _hotelSuccessPaymentBloc.state.argumentModel!.bookingUrn,
      );

  Widget _getBottomBar() {
    return OtaBottomButtonBar(
      isExpandedRightButton: true,
      spaceBetweenButton: kSize16,
      containerHeight: kSize92,
      padding: const EdgeInsets.fromLTRB(kSize24, kSize16, kSize24, kSize32),
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
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.otaBookingScreen,
                (Route<dynamic> route) =>
                    route.settings.name == AppRoutes.landingPage,
                arguments: _kHotelKey);
          },
        ),
      ),
    );
  }

  Widget _getTopBar() => Container(
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
                _kCongratulationAssetName,
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
                    getTranslated(
                        context, AppLocalizationsStrings.paymentSuccessMessage),
                    style: AppTheme.kSmallRegular
                        .copyWith(color: AppColors.kLight100),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget _getServiceCards(final int countServiceCards) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kSize16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSize21),
          child: Text(
            getTranslated(context, AppLocalizationsStrings.extraServices),
            style: AppTheme.kHeading1Medium,
            maxLines: _maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: kSize16),
        OtaServiceCardListView(
          padding: const EdgeInsets.symmetric(horizontal: kSize21),
          serviceCardList: List.generate(
            serviceViewModel?.length ?? 0,
            (index) =>
                serviceViewModel![index].toOtaResrvationServiceCardViewModel(),
          ),
          serviceType: OtaServiceType.hotel,
        ),
        const SizedBox(height: kSize16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: kSize21),
          child: OtaHorizontalDivider(
            dividerColor: AppColors.kBorderGrey,
            height: _kDividerHeight,
          ),
        ),
      ],
    );
  }

  void _getAppFlyerData(String eventName, String clearEventName) {
    AppFlyerHelper.addDoubleValue(
        eventName: eventName,
        key: HotelPaymentSuccessAppFlyer.hotelRoomPrice,
        value: _hotelSuccessPaymentBloc.state.argumentModel?.pricePerNight);
    AppFlyerHelper.addDateValue(
        eventName: eventName,
        key: HotelPaymentSuccessAppFlyer.hotelCheckInDate,
        value: _hotelSuccessPaymentBloc.state.argumentModel?.checkInDate);
    AppFlyerHelper.addDateValue(
        eventName: eventName,
        key: HotelPaymentSuccessAppFlyer.hotelCheckOutDate,
        value: _hotelSuccessPaymentBloc.state.argumentModel?.checkOutDate);
    AppFlyerHelper.addIntValue(
        eventName: eventName,
        key: HotelPaymentSuccessAppFlyer.hotelAdultCount,
        value: _hotelSuccessPaymentBloc.state.argumentModel?.numberOfAdults);
    AppFlyerHelper.addIntValue(
        eventName: eventName,
        key: HotelPaymentSuccessAppFlyer.hotelChildCount,
        value: _hotelSuccessPaymentBloc.state.argumentModel?.numberOfChildren);
    AppFlyerHelper.addIntValue(
        eventName: eventName,
        key: HotelPaymentSuccessAppFlyer.hotelStayPeriod,
        value: _hotelSuccessPaymentBloc.state.argumentModel?.numberOfNights);
    AppFlyerHelper.addKeyValue(
        eventName: eventName,
        key: HotelPaymentSuccessAppFlyer.hotelContentType,
        value: _kAppFlyerHotelContentType);
    AppFlyerHelper.addUserLocation(eventName: eventName);
    AppFlyerHelper.stopCapturingEvent(eventName);
    AppFlyerHelper.clearEvent(clearEventName);
  }

  void _triggerFirebaseEvent() {
    FirebaseHelper.addKeyValue(
        key: HotelSuccessPaymentFirebase.referenceId,
        eventName: FirebaseEvent.hotelBookingSuccess,
        value: _hotelSuccessPaymentBloc.state.argumentModel?.bookingUrn);
    FirebaseHelper.addKeyValue(
        key: HotelSuccessPaymentFirebase.hotelName,
        eventName: FirebaseEvent.hotelBookingSuccess,
        value: _hotelSuccessPaymentBloc.state.argumentModel?.propertyName);
    FirebaseHelper.addDateValue(
        key: HotelSuccessPaymentFirebase.hotelStartDate,
        eventName: FirebaseEvent.hotelBookingSuccess,
        value: _hotelSuccessPaymentBloc.state.argumentModel?.checkInDate);
    FirebaseHelper.addDateValue(
        key: HotelSuccessPaymentFirebase.hotelEndDate,
        eventName: FirebaseEvent.hotelBookingSuccess,
        value: _hotelSuccessPaymentBloc.state.argumentModel?.checkOutDate);
    FirebaseHelper.addIntValue(
        key: HotelSuccessPaymentFirebase.hotelNumberAdult,
        eventName: FirebaseEvent.hotelBookingSuccess,
        value: _hotelSuccessPaymentBloc.state.argumentModel?.numberOfAdults);
    FirebaseHelper.addIntValue(
        key: HotelSuccessPaymentFirebase.hotelNumberChild,
        eventName: FirebaseEvent.hotelBookingSuccess,
        value: _hotelSuccessPaymentBloc.state.argumentModel?.numberOfChildren);
    FirebaseHelper.addIntValue(
        key: HotelSuccessPaymentFirebase.hotelNumberRoom,
        eventName: FirebaseEvent.hotelBookingSuccess,
        value: _hotelSuccessPaymentBloc.state.argumentModel?.numberOfRooms);
    FirebaseHelper.addIntValue(
        key: HotelSuccessPaymentFirebase.hotelNumberNight,
        eventName: FirebaseEvent.hotelBookingSuccess,
        value: _hotelSuccessPaymentBloc.state.argumentModel?.numberOfNights);
    FirebaseHelper.addKeyValue(
        key: HotelSuccessPaymentFirebase.paymentStatus,
        eventName: FirebaseEvent.hotelBookingSuccess,
        value: 'success');
    FirebaseHelper.stopCapturingEvent(FirebaseEvent.hotelBookingSuccess);
  }
}
