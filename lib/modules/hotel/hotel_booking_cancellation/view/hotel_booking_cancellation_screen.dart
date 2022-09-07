import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_helper.dart';
import 'package:ota/core_pack/appflyer/hotel/hotel_cancellation_request_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_bottom_sheet.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_dialog_loader.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/bloc/cancellation_reason_bloc.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/bloc/hotel_booking_cancellation_bloc.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/helpers/cancellation_reasons_helper.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view/widgets/cancellation_reasons_list_widget.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_argument_view_model.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view_model/hotel_booking_cancellation_view_model.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view/widgets/hotel_booking_details_cancellation_policy.dart';
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_detail_argument.dart';

class HotelBookingCancellationScreen extends StatefulWidget {
  const HotelBookingCancellationScreen({Key? key}) : super(key: key);

  @override
  HotelBookingCancellationScreenState createState() =>
      HotelBookingCancellationScreenState();
}

class HotelBookingCancellationScreenState
    extends State<HotelBookingCancellationScreen> {
  HotelBookingCancellationArgumentViewModel? argument;
  final CancellationReasonBloc cancellationReasonBloc =
      CancellationReasonBloc();
  final TextEditingController textEditingController = TextEditingController();
  final HotelBookingCancellationBloc hotelBookingCancellationBloc =
      HotelBookingCancellationBloc();

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(() {
      if (textEditingController.text.isNotEmpty) {
        cancellationReasonBloc.setCancellationReason(
          isSelected: true,
          reason: textEditingController.text,
        );
      } else {
        cancellationReasonBloc.setCancellationReason(
          isSelected: false,
          reason: textEditingController.text,
        );
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      hotelBookingCancellationBloc.stream.listen((event) {
        if (hotelBookingCancellationBloc.state.state ==
            HotelBookingCancellationScreenStates.loading) {
          OtaDialogLoader().showLoader(context);
        } else {
          OtaDialogLoader().hideLoader(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    argument = ModalRoute.of(context)?.settings.arguments
        as HotelBookingCancellationArgumentViewModel;
    return Scaffold(
      appBar: OtaAppBar(
        title:
            getTranslated(context, AppLocalizationsStrings.cancelReservation),
        titleColor: AppColors.kGreyScale,
      ),
      body: Stack(
        children: [
          SafeArea(
            minimum: const EdgeInsets.only(
              bottom: kSize100,
            ),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                _getCancellationPolicy(argument),
                Padding(
                  padding: kPaddingHori24,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      getTranslated(
                          context, AppLocalizationsStrings.cancellationReasons),
                      style: AppTheme.kHeading3
                          .copyWith(color: AppColors.kGreyScale),
                    ),
                  ),
                ),
                _getGradientSelectionMessage(),
                const SizedBox(height: kSize24),
                CancellationReasonsListWidget(
                  onTap: (index, isSelected, reason) {
                    cancellationReasonBloc.setCancellationReason(
                        index: index, isSelected: isSelected, reason: reason);
                  },
                  labelList: CancellationReasonsHelper.cancellationReasons,
                  textEditingController: textEditingController,
                ),
                const SizedBox(height: kSize46),
              ],
            ),
          ),
          _getBottomBar(context, argument),
        ],
      ),
    );
  }

  Widget _getGradientSelectionMessage() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSize24, kSize4, kSize24, kSize0),
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return AppColors.gradient1.createShader(Offset.zero & bounds.size);
        },
        child: Text(
          getTranslated(context, AppLocalizationsStrings.cancelPlsSelectReason),
          style: AppTheme.kBodyRegular.copyWith(color: AppColors.kTrueWhite),
        ),
      ),
    );
  }

  Widget _getCancellationPolicy(
      HotelBookingCancellationArgumentViewModel? argument) {
    return Padding(
      padding: kPaddingHori24,
      child: Column(
        children: [
          HotelBookingDetailsCancellationPolicy(
            cancellationPolicyViewModel: argument?.cancellationPolicyList ?? [],
            isGradientText: false,
            headingStyle:
                AppTheme.kHeading3.copyWith(color: AppColors.kGreyScale),
            descriptionStyle: AppTheme.kBody,
          ),
        ],
      ),
    );
  }

  Widget _getBottomBar(BuildContext context,
      HotelBookingCancellationArgumentViewModel? argument) {
    return BlocBuilder(
      bloc: cancellationReasonBloc,
      builder: () {
        return OtaBottomButtonBar(
          isExpandedRightButton: true,
          spaceBetweenButton: kSize16,
          button1: OtaTextButton(
            title: getTranslated(
                context, AppLocalizationsStrings.cancelReservation),
            key: const Key("CancelReservationButton"),
            textHorizontalPadding: kSize72,
            onPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.white10,
                  context: context,
                  builder: (bgContext) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OtaAlertBottomSheet(
                          alertTitle: getTranslated(bgContext,
                              AppLocalizationsStrings.cancelThisReservation),
                          textWidget: _getAlertText(),
                          leftButtonText: getTranslated(
                              bgContext, AppLocalizationsStrings.notNow),
                          rightButtonText: getTranslated(
                              bgContext, AppLocalizationsStrings.agree),
                          onLeftButtonTap: () {
                            Navigator.of(bgContext).pop();
                          },
                          onRightButtonTap: () {
                            _cancelRequestAppFlyer();
                            Navigator.of(bgContext).pop();
                            _getRejectBookingData(context);
                          },
                        ),
                      ],
                    );
                  });
            },
            isDisabled: cancellationReasonBloc.state.isSelected == false,
          ),
        );
      },
    );
  }

  void _getRejectBookingData(BuildContext widgetContext) async {
    await hotelBookingCancellationBloc.getHotelBookingCancellationData(
        HotelBookingCancellationArgument(
            confirmNo: argument!.confirmNo,
            reason: cancellationReasonBloc.state.cancellationReason ?? ''));
    hotelBookingCancellationBloc.stream.first.then((value) {
      if (hotelBookingCancellationBloc.state.state ==
          HotelBookingCancellationScreenStates.failure1899) {
        _showUnableToProceedAlert();
      } else if (hotelBookingCancellationBloc.state.state ==
              HotelBookingCancellationScreenStates.success ||
          hotelBookingCancellationBloc.state.state ==
              HotelBookingCancellationScreenStates.failure) {
        Navigator.pop(
          widgetContext,
          _getHotelBookingDetailArgument(
              argument, hotelBookingCancellationBloc.state.data?.actionStatus),
        );
      } else if (hotelBookingCancellationBloc.state.state ==
          HotelBookingCancellationScreenStates.internetFailure) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      }
    });
  }

  Future<void> _showUnableToProceedAlert() async => await OtaAlertDialog(
        errorMessage: getTranslated(
            context, AppLocalizationsStrings.unableToCancelOnCheckInDate),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.ok),
        useRootNavigator: false,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      ).showAlertDialog(context);

  Widget _getAlertText() {
    return Text(
      getTranslated(context, AppLocalizationsStrings.cancellationPopupOne),
      style: AppTheme.kSmall1,
      textAlign: TextAlign.center,
    );
  }

  HotelBookingDetailArgument _getHotelBookingDetailArgument(
      HotelBookingCancellationArgumentViewModel? argument,
      CancellationStatus? state) {
    if (state == CancellationStatus.success) {
      return HotelBookingDetailArgument(
        cancelDate: hotelBookingCancellationBloc.state.data?.cancellationDate,
        bookingUrn: argument!.bookingUrn,
        bookingStatus:
            getTranslated(context, AppLocalizationsStrings.canceledOn),
        cancellationStatus:
            hotelBookingCancellationBloc.state.data?.actionStatus,
        confirmationNo: argument.confirmNo,
      );
    } else {
      return HotelBookingDetailArgument(
        cancelDate: hotelBookingCancellationBloc.state.data?.cancellationDate,
        bookingUrn: argument!.bookingUrn,
        cancellationStatus:
            hotelBookingCancellationBloc.state.data?.actionStatus,
        confirmationNo: argument.confirmNo,
      );
    }
  }

  @override
  void dispose() {
    hotelBookingCancellationBloc.dispose();
    textEditingController.removeListener(() {});
    textEditingController.dispose();
    super.dispose();
  }

  void _cancelRequestAppFlyer() {
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.hotelcancellationRequestEvent,
        key: HotelCancellationRequestAppFlyer.cancellationReason,
        value: cancellationReasonBloc.state.cancellationReason ?? '');
    AppFlyerHelper.stopCapturingEvent(
        AppFlyerEvent.hotelcancellationRequestEvent);
  }
}
