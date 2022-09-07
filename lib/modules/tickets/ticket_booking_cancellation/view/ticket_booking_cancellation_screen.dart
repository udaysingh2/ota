import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_helper.dart';
import 'package:ota/core_pack/appflyer/tours_and_activities/tickets_cancellation_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_bottom_sheet.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_dialog_loader.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_booking_cancellation/view/widgets/cancellation_button.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/bloc/ticket_booking_cancellation_bloc.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/bloc/ticket_cancellation_reason_bloc.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/helper/ticket_cancellation_reasons_helper.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view/widgets/ticket_booking_cancellation_policy.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view/widgets/ticket_cancellation_reasons_list_widget.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view_model/ticket_booking_cancellation_argument.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view_model/ticket_booking_cancellation_argument_view_model.dart';
import 'package:ota/modules/tickets/ticket_booking_cancellation/view_model/ticket_booking_cancellation_view_model.dart';

class TicketBookingCancellationScreen extends StatefulWidget {
  const TicketBookingCancellationScreen({Key? key}) : super(key: key);

  @override
  TicketBookingCancellationScreenState createState() =>
      TicketBookingCancellationScreenState();
}

class TicketBookingCancellationScreenState
    extends State<TicketBookingCancellationScreen> {
  TicketBookingCancellationArgumentViewModel? argument;
  final TicketCancellationReasonBloc cancellationReasonBloc =
      TicketCancellationReasonBloc();
  final TextEditingController textEditingController = TextEditingController();
  final TicketBookingCancellationBloc ticketBookingCancellationBloc =
      TicketBookingCancellationBloc();

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

    ticketBookingCancellationBloc.stream.listen(
      (event) {
        if (ticketBookingCancellationBloc.state.state ==
            TicketBookingCancellationScreenStates.loading) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            OtaDialogLoader().showLoader(context);
          });
        } else {
          OtaDialogLoader().hideLoader(context);
        }
        if (ticketBookingCancellationBloc.state.state ==
            TicketBookingCancellationScreenStates.internetFailure) {
          OtaNoInternetAlertDialog().showAlertDialog(context);
        } else if (ticketBookingCancellationBloc.state.state ==
            TicketBookingCancellationScreenStates.failure1899) {
          _showUnableToProceedAlert();
        } else if (ticketBookingCancellationBloc.state.state ==
                TicketBookingCancellationScreenStates.success ||
            ticketBookingCancellationBloc.state.state ==
                TicketBookingCancellationScreenStates.failure) {
          Navigator.of(context).pop(
              ticketBookingCancellationBloc.state.data?.actionStatus ??
                  TicketCancellationStatus.failure);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    argument = ModalRoute.of(context)?.settings.arguments
        as TicketBookingCancellationArgumentViewModel;
    return Scaffold(
      appBar: OtaAppBar(
        title:
            getTranslated(context, AppLocalizationsStrings.cancelReservation),
        titleColor: AppColors.kGrey70,
      ),
      body: Stack(
        children: [
          SafeArea(
            minimum: const EdgeInsets.only(
              bottom: kSize100,
            ),
            child: ListView(
              children: [
                _getCancellationPolicy(argument),
                Padding(
                  padding: kPaddingHori24,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      getTranslated(
                          context, AppLocalizationsStrings.cancellationReasons),
                      style: AppTheme.kHeading1Medium,
                    ),
                  ),
                ),
                _getReasonSelectWidget(),
                const SizedBox(
                  height: kSize24,
                ),
                TicketCancellationReasonsListWidget(
                  onTap: (index, isSelected, reason) {
                    cancellationReasonBloc.setCancellationReason(
                        index: index, isSelected: isSelected, reason: reason);
                  },
                  labelList:
                      TicketCancellationReasonsHelper.cancellationReasons,
                  textEditingController: textEditingController,
                ),
              ],
            ),
          ),
          _getBottomBar(context, argument),
        ],
      ),
    );
  }

  Widget _getCancellationPolicy(
      TicketBookingCancellationArgumentViewModel? argument) {
    return Padding(
      padding: kPaddingHori24,
      child: Column(
        children: [
          TicketBookingCancellationPolicy(
            padding: EdgeInsets.zero,
            cancelPolicy: argument?.cancellationPolicyList,
          ),
        ],
      ),
    );
  }

  Widget _getBottomBar(BuildContext context,
      TicketBookingCancellationArgumentViewModel? argument) {
    return BlocBuilder(
        bloc: cancellationReasonBloc,
        builder: () {
          return OtaBottomButtonBar(
            safeAreaBottom: false,
            isExpandedRightButton: true,
            spaceBetweenButton: kSize16,
            button1: Align(
              alignment: Alignment.bottomCenter,
              child: CancellationButton(
                title: getTranslated(
                    context, AppLocalizationsStrings.cancelReservation),
                key: const Key("CancelReservationButton"),
                textHorizontalPadding: kSize72,
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (bgContext) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OtaAlertBottomSheet(
                              isSafeArea: false,
                              alertTitle: getTranslated(
                                  bgContext,
                                  AppLocalizationsStrings
                                      .cancelThisReservation),
                              textWidget: _getAlertText(),
                              leftButtonText: getTranslated(
                                  bgContext, AppLocalizationsStrings.notNow),
                              rightButtonText: getTranslated(
                                  bgContext, AppLocalizationsStrings.agree),
                              onLeftButtonTap: () {
                                Navigator.of(bgContext).pop();
                              },
                              onRightButtonTap: () {
                                _getAppFlyerData();
                                Navigator.of(bgContext).pop();
                                _getRejectBookingData(context);
                              },
                            ),
                          ],
                        );
                      });
                },
                backgroundColor: AppColors.kSecondary,
                isDisabled: cancellationReasonBloc.state.isSelected == false,
              ),
            ),
          );
        });
  }

  void _getRejectBookingData(BuildContext widgetContext) async {
    await ticketBookingCancellationBloc.getTicketBookingCancellationData(
        TicketBookingCancellationArgument(
            confirmNo: argument!.confirmNo,
            reason: cancellationReasonBloc.state.cancellationReason ?? ''));
  }

  Widget _getAlertText() {
    return Column(
      children: [
        Text(
          getTranslated(
              context, AppLocalizationsStrings.tourCancellationPopupOne),
          style: AppTheme.kSmallRegular
              .copyWith(color: AppColors.kGrey50, fontFamily: kFontFamily),
          textAlign: TextAlign.center,
        ),
        Text(
          getTranslated(
              context, AppLocalizationsStrings.tourCancellationPopupTwo),
          style: AppTheme.kSmallRegular
              .copyWith(color: AppColors.kGrey50, fontFamily: kFontFamily),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _getReasonSelectWidget() {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return AppColors.gradient2.createShader(Offset.zero & bounds.size);
      },
      child: Padding(
        padding: kPaddingHori24,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            getTranslated(context, AppLocalizationsStrings.selectReason),
            style: AppTheme.kBodyRegular.copyWith(color: AppColors.kLight100),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    ticketBookingCancellationBloc.dispose();
    textEditingController.removeListener(() {});
    textEditingController.dispose();
    super.dispose();
  }

  Future<void> _showUnableToProceedAlert() async => await OtaAlertDialog(
        errorMessage: getTranslated(
            context, AppLocalizationsStrings.unableToCancelOnActivityDate),
        errorTitle:
            getTranslated(context, AppLocalizationsStrings.unableToProceed),
        buttonTitle: getTranslated(context, AppLocalizationsStrings.ok),
        useRootNavigator: false,
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      ).showAlertDialog(context);

  void _getAppFlyerData() {
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.ticketCancellationEvent,
        key: TicketCancellationAppFlyer.ticketCancellationReason,
        value: cancellationReasonBloc.state.cancellationReason);
    AppFlyerHelper.stopCapturingEvent(AppFlyerEvent.ticketCancellationEvent);
  }
}
