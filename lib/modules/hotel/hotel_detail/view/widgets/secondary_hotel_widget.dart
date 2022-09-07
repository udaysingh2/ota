import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/channels/booking_customer_register_invoke/models/booking_customer_register_argument_model_channel.dart';
import 'package:ota/channels/booking_customer_register_invoke/usecases/booking_customer_register_use_cases.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/navigation_helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_helper.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_detail_click_hotel_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_bottom_sheet.dart';
import 'package:ota/core_pack/custom_widgets/ota_discount_price_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_booking_review_parameters.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_roomselect_parameter.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_view_room_details.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/secondary_view_model.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_argument_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_argument_model.dart';
import 'package:provider/provider.dart';

const String _roomDetailKey = "room_detail_key";
const _kMaxLines = 2;

class SecondaryHotelView extends StatefulWidget {
  final SecondaryViewModel secondaryViewModel;

  const SecondaryHotelView({
    Key? key,
    required this.secondaryViewModel,
  }) : super(key: key);

  @override
  SecondaryHotelViewState createState() => SecondaryHotelViewState();
}

class SecondaryHotelViewState extends State<SecondaryHotelView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppFlyerHelper.addDoubleValue(
          eventName: AppFlyerEvent.hoteldetailClickEvent,
          key: HotelDetailClickHotelAppFlyer.roomPrice,
          value: widget.secondaryViewModel.nightPrice);
      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.hoteldetailClickEvent,
          key: HotelDetailClickHotelAppFlyer.roomId,
          value: widget.secondaryViewModel.roomCode);
      AppFlyerHelper.addKeyValue(
          eventName: AppFlyerEvent.hoteldetailClickEvent,
          key: HotelDetailClickHotelAppFlyer.roomClass,
          value: widget.secondaryViewModel.roomCatName);
      FirebaseHelper.addKeyValue(
          eventName: FirebaseEvent.hotelViewRoomDetails,
          key: HotelViewRoomDetails.hotelRoomCat,
          value: widget.secondaryViewModel.roomCatName);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSize16),
      child: Container(
        margin: kPaddingHori16,
        padding: const EdgeInsets.fromLTRB(kSize16, kSize8, kSize16, kSize16),
        decoration: const BoxDecoration(
          borderRadius: kBorderRad12,
          border: Border.symmetric(
            horizontal: BorderSide(
              color: AppColors.kGrey10,
              width: kSize1,
            ),
            vertical: BorderSide(
              color: AppColors.kGrey10,
              width: kSize1,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getCardTopBar(),
            _getCardMiddleBar(),
            const OtaHorizontalDivider(
              dividerColor: AppColors.kGrey10,
              height: kSize16,
            ),
            const SizedBox(
              height: kSize8,
            ),
            _getCardBottomBar()
          ],
        ),
      ),
    );
  }

  Widget _getCardTopBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            widget.secondaryViewModel.roomName.addTrailingPlus() +
                widget.secondaryViewModel.roomType,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.kBodyMedium,
          ),
        ),
        Transform(
          transform:
              Matrix4.translationValues(kSize8, Offset.zero.dy, Offset.zero.dy),
          child: OtaNextButton(
              key: const Key(_roomDetailKey),
              onPress: () {
                _onNextButtonClicked();
              }),
        ),
      ],
    );
  }

  RoomDetailArgument _mapHotelToRoom(HotelDetailArgument argument) {
    return RoomDetailArgument(
      hotelId: argument.hotelId,
      cityId: argument.cityId,
      checkInDate: argument.checkInDate,
      checkOutDate: argument.checkOutDate,
      rooms: argument.rooms,
      currency: argument.currencyCode,
      countryId: argument.countryCode,
      roomCode: widget.secondaryViewModel.roomCode,
      roomCategory: widget.secondaryViewModel.roomOffer?.breakfast ?? 0,
      price: widget.secondaryViewModel.totalPrice,
      freefoodDelivery: widget.secondaryViewModel.freeFoodDelivery,
      address: widget.secondaryViewModel.address,
      rating: widget.secondaryViewModel.rating,
      supplierId: widget.secondaryViewModel.supplierId,
      supplierName: widget.secondaryViewModel.supplierName,
      mealCode: widget.secondaryViewModel.roomOffer?.mealCode,
    );
  }

  void _onNextButtonClicked() {
    HotelDetailArgument argument =
        ModalRoute.of(context)?.settings.arguments as HotelDetailArgument;
    Navigator.pushNamed(context, AppRoutes.roomDetails,
        arguments: _mapHotelToRoom(argument));
  }

  Widget _getCardMiddleBar() {
    List<Widget> totalCard = [];
    RoomOffers? roomOffers = widget.secondaryViewModel.roomOffer;
    if (widget.secondaryViewModel.facilityList != null) {
      if (widget.secondaryViewModel.facilityList?[kWifi] == "1") {
        totalCard.add(_getFacility(kWifi));
        totalCard.add(const SizedBox(
          height: kSize8,
        ));
      }
    }
    if (roomOffers != null) {
      if (roomOffers.breakfast != null && roomOffers.breakfast == 1) {
        totalCard.add(_getFacility(kBreakfast));
        totalCard.add(const SizedBox(
          height: kSize8,
        ));
      }
      if (roomOffers.payNow != null) {
        totalCard.add(_getService(kPayNow, roomOffers.payNow!));
        totalCard.add(const SizedBox(
          height: kSize8,
        ));
      }
      if (roomOffers.cancellationPolicy != null) {
        totalCard.add(
            _getService(kCancellationPolicy, roomOffers.cancellationPolicy!));
        totalCard.add(const SizedBox(
          height: kSize8,
        ));
      }
    }

    for (String asset in widget.secondaryViewModel.hotelBenefits) {
      totalCard.add(_getService(kCheckCircle, asset,
          AppTheme.kSmallRegular.copyWith(color: AppColors.kSecondary), false));
      totalCard.add(const SizedBox(
        height: kSize8,
      ));
    }
    return Column(
      children: totalCard,
    );
  }

  Widget _getService(String assetId, String offerId,
      [TextStyle textStyle = AppTheme.kSmallRegular, bool isEllipsis = true]) {
    String imageName = FacilityHelper.getAssetName(assetId);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          imageName,
          width: kSize20,
          height: kSize20,
        ),
        const SizedBox(
          width: kSize4,
        ),
        _getText(offerId, textStyle, isEllipsis),
      ],
    );
  }

  Widget _getText(String offerId, TextStyle textStyle, bool isEllipsis) {
    return Expanded(
      child: isEllipsis
          ? Text(
              offerId,
              maxLines: _kMaxLines,
              overflow: TextOverflow.ellipsis,
              style: textStyle,
            )
          : Text(
              offerId,
              style: textStyle,
            ),
    );
  }

  Widget _getFacility(String assetId) {
    String imageName = FacilityHelper.getAssetName(assetId);
    return Row(
      children: [
        SvgPicture.asset(
          imageName,
          width: kSize20,
          height: kSize20,
        ),
        const SizedBox(
          width: kSize4,
        ),
        Expanded(
            child: Text(
          FacilityHelper.getLocalizedText(assetId, context),
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
          style: AppTheme.kSmallRegular,
        )),
      ],
    );
  }

  Widget _getCardBottomBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        OtaDiscountPriceWidget(
            pricePerNight: widget.secondaryViewModel.nightPrice.toDouble(),
            totalAmount: widget.secondaryViewModel.totalPrice,
            isRightAlign: false,
            percentageDiscount: widget.secondaryViewModel.maxDiscount,
            priceBeforeDiscount:
                widget.secondaryViewModel.priceWithoutDiscount),
        SizedBox(
          width: kSize120,
          child: OtaTextButton(
            title:
                getTranslated(context, AppLocalizationsStrings.chooseThisRoom),
            child: Text(
              getTranslated(context, AppLocalizationsStrings.chooseThisRoom),
              style: AppTheme.kButton.copyWith(color: AppColors.kLight100),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              _getFirebaseHotelRoomSelectData();
              FirebaseHelper.stopCapturingEvent(FirebaseEvent.hotelRoomSelect);
              AppFlyerHelper.stopCapturingEvent(
                  AppFlyerEvent.hoteldetailClickEvent);
              HotelDetailArgument argument = ModalRoute.of(context)
                  ?.settings
                  .arguments as HotelDetailArgument;
              LoginModel loginModel = Provider.of<LoginModel>(
                  GlobalKeys.navigatorKey.currentContext!,
                  listen: false);
              if (loginModel.userType == UserType.loggedInUser) {
                getRoomReservationReviewData();
                Navigator.pushNamed(context, AppRoutes.reservationScreen,
                    arguments:
                        ReservationArgumentModel.mapFromRoomDetailArgument(
                      roomDetailArgument: _mapHotelToRoom(argument),
                      firstName: getLoginProvider().userName,
                    ));
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
                                    topRight: Radius.circular(kSize24))),
                            child: OtaAlertBottomSheet(
                              leftButtonText: getTranslated(
                                  context, AppLocalizationsStrings.cancel),
                              rightButtonText: getTranslated(
                                  context,
                                  AppLocalizationsStrings
                                      .registerPopupRegisterButton),
                              alertText: getTranslated(context,
                                  AppLocalizationsStrings.registerPopupMessage),
                              alertTitle: getTranslated(context,
                                  AppLocalizationsStrings.registerPopupHeader),
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
          ),
        )
      ],
    );
  }

  void waitForSuperAppToPushLandingPage() {
    BookingCustomerRegisterUseCases landingCustomerRegisterUseCases =
        BookingCustomerRegisterUseCasesImpl();
    LoginModel loginModel = Provider.of<LoginModel>(
        GlobalKeys.navigatorKey.currentContext!,
        listen: false);
    landingCustomerRegisterUseCases.invokeExampleMethod(
        methodName: "bookingCustomerRegister",
        arguments: BookingCustomerRegisterArgumentModelChannel(
          userType: loginModel.userType.getSuperAppString(),
          env: loginModel.getEnv(),
          language: loginModel.getLanguage(),
          userId: loginModel.userId,
        ));
  }

  void _getFirebaseHotelRoomSelectData() {
    FirebaseHelper.addDoubleValue(
        eventName: FirebaseEvent.hotelRoomSelect,
        key: HotelRoomSelectFirebase.hotelPricePerNight,
        value: widget.secondaryViewModel.nightPrice);
    FirebaseHelper.addDoubleValue(
        eventName: FirebaseEvent.hotelRoomSelect,
        key: HotelRoomSelectFirebase.hotelTotalPrice,
        value: widget.secondaryViewModel.totalPrice);
    FirebaseHelper.addKeyWithPercentValue(
        eventName: FirebaseEvent.hotelRoomSelect,
        key: HotelRoomSelectFirebase.hotelDiscountPercent,
        value: widget.secondaryViewModel.maxDiscount != null
            ? widget.secondaryViewModel.maxDiscount.toString()
            : '');
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelRoomSelect,
        key: HotelRoomSelectFirebase.hotelRoomCat,
        value: widget.secondaryViewModel.roomCatName);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelRoomSelect,
        key: HotelRoomSelectFirebase.hotelRoomMealtype,
        value: widget.secondaryViewModel.roomName);
  }

  void getRoomReservationReviewData() {
    FirebaseHelper.addKeyValue(
      eventName: FirebaseEvent.hotelBookingReview,
      key: HotelBookingReviewFirebase.hotelDiscountPercent,
      value:
          '${(widget.secondaryViewModel.maxDiscount ?? 0).toString()} ${'%'}',
    );
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelBookingReview,
        key: HotelBookingReviewFirebase.hotelRoomCat,
        value: widget.secondaryViewModel.roomCatName);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelBookingReview,
        key: HotelBookingReviewFirebase.hotelRoomMealType,
        value: widget.secondaryViewModel.roomName);
  }
}
