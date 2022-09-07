import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_bottom_sheet.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_discount_price_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/hotel/hotel_view_room_details.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/hotel/room_detail/bloc/room_detail_bloc.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_argument_model.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_detail_view_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_argument_model.dart';

const double _kSize102 = 102;

class HotelRoomBottomWidget extends StatelessWidget {
  final RoomDetailViewBloc roomDetailViewBloc;
  final RoomDetailArgument argument;
  final void Function() waitForSuperAppToPushLandingPage;
  const HotelRoomBottomWidget(
      {Key? key,
      required this.argument,
      required this.roomDetailViewBloc,
      required this.waitForSuperAppToPushLandingPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _getFirebaseData();
    return _getBottomBar(
      context,
      roomDetailViewBloc,
      argument,
      waitForSuperAppToPushLandingPage,
    );
  }

  Widget _getBottomBar(
      BuildContext context,
      RoomDetailViewBloc roomDetailViewBloc,
      RoomDetailArgument arguments,
      void Function() waitForSuperAppToPushLandingPage) {
    return OtaBottomButtonBar(
      safeAreaBottom: false,
      color: AppColors.kLight100,
      containerHeight: _kSize102,
      padding: const EdgeInsets.fromLTRB(kSize24, kSize16, kSize24, kSize9),
      button1: BlocBuilder(
        bloc: roomDetailViewBloc,
        builder: () {
          RoomDetailModel? roomDetailModel = roomDetailViewBloc.state.data;
          return OtaDiscountPriceWidget(
              pricePerNight: roomDetailModel?.perNightPrice ?? 0,
              totalAmount: roomDetailModel?.totalAmount ?? 0,
              isRightAlign: false,
              percentageDiscount: roomDetailModel?.discountPercent?.toInt(),
              priceBeforeDiscount: roomDetailModel?.nightPriceBeforeDiscount);
        },
      ),
      button2: SizedBox(
        width: kSize120,
        child: OtaTextButton(
          title: getTranslated(context, AppLocalizationsStrings.chooseThisRoom),
          key: const Key("BookNowButton"),
          onPressed: () {
            FirebaseHelper.stopCapturingEvent(
                FirebaseEvent.hotelViewRoomDetails);
            LoginModel loginModel = getLoginProvider();
            if (loginModel.userType == UserType.loggedInUser) {
              Navigator.pushNamed(context, AppRoutes.reservationScreen,
                  arguments: ReservationArgumentModel.mapFromRoomDetailArgument(
                    roomDetailArgument: arguments,
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
                },
              );
            }
          },
        ),
      ),
    );
  }

  void _getFirebaseData() {
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelViewRoomDetails,
        key: HotelViewRoomDetails.hotelId,
        value: argument.hotelId);
    FirebaseHelper.addDoubleValue(
        eventName: FirebaseEvent.hotelViewRoomDetails,
        key: HotelViewRoomDetails.hotelTotalPrice,
        value: roomDetailViewBloc.state.data?.totalAmount);
    FirebaseHelper.addDoubleWithPercentValue(
        eventName: FirebaseEvent.hotelViewRoomDetails,
        key: HotelViewRoomDetails.hotelDiscountPercent,
        value: roomDetailViewBloc.state.data?.discountPercent);
    FirebaseHelper.addDoubleValue(
        eventName: FirebaseEvent.hotelViewRoomDetails,
        key: HotelViewRoomDetails.hotelPricePerNight,
        value: roomDetailViewBloc.state.data?.perNightPrice);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.hotelViewRoomDetails,
        key: HotelViewRoomDetails.hotelRoomMealType,
        value: roomDetailViewBloc.state.data?.roomType);
  }
}
