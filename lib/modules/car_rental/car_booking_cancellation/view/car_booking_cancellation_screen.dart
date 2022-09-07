import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/appflyer/appflyer_event.dart';
import 'package:ota/core_pack/appflyer/appflyer_helper.dart';
import 'package:ota/core_pack/appflyer/car_rental/car_cancellation_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_dialog_loader.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/bloc/cancellation_reason_bloc.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/bloc/car_booking_cancellation_bloc.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/helpers/car_cancellation_reason_helper.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view/widgets/cancellation_bottom_sheet_widget.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view/widgets/cancellation_policy_widget.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view/widgets/cancellation_reasons_list_widget.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/car_booking_cancellation_argument.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/car_booking_cancellation_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/car_booking_cancellation_view_model.dart';

const _cancellationButton = 'CancellationButton';
const _cancelOtaTextButtonWidget = 'NotNowCancellationOrder';

class CarBookingCancellationScreen extends StatefulWidget {
  const CarBookingCancellationScreen({Key? key}) : super(key: key);

  @override
  CarBookingCancellationScreenState createState() =>
      CarBookingCancellationScreenState();
}

class CarBookingCancellationScreenState
    extends State<CarBookingCancellationScreen> {
  CarBookingCancellationArgumentViewModel? argument;
  final CancellationReasonBloc cancellationReasonBloc =
      CancellationReasonBloc();
  final TextEditingController _textEditingController = TextEditingController();
  final CarBookingCancellationBloc carBookingCancellationBloc =
      CarBookingCancellationBloc();
  final FocusNode _othersFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      if (_textEditingController.text.isNotEmpty) {
        cancellationReasonBloc.setCancellationReason(
          isSelected: true,
          reason: _textEditingController.text,
        );
      } else {
        cancellationReasonBloc.setCancellationReason(
          isSelected: false,
          reason: _textEditingController.text,
        );
      }
    });
    carBookingCancellationBloc.stream.listen((event) {
      OtaDialogLoader().hideLoader(context);
      if (carBookingCancellationBloc.state.state ==
          CarBookingCancellationScreenStates.loading) {
        OtaDialogLoader().showLoader(context);
      } else if (carBookingCancellationBloc.state.state ==
          CarBookingCancellationScreenStates.failureNetwork) {
        OtaNoInternetAlertDialog().showAlertDialog(context);
      } else if (carBookingCancellationBloc.state.state ==
          CarBookingCancellationScreenStates.bookingCancelFailure) {
        _showErrorDialog();
      }
    });
  }

  verifyCancellationPickupDate(context) {
    _showModalBottomSheet(context);
  }

  _showErrorDialog() {
    OtaAlertDialog(
            errorTitle:
                getTranslated(context, AppLocalizationsStrings.unableToProceed),
            errorMessage: getTranslated(
                context, AppLocalizationsStrings.carCannotBecanceled),
            onPressed: () => Navigator.of(context).pop(),
            buttonTitle: getTranslated(context, AppLocalizationsStrings.ok))
        .showAlertDialog(context)
        .then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    argument = ModalRoute.of(context)?.settings.arguments
        as CarBookingCancellationArgumentViewModel;
    return Scaffold(
      appBar: OtaAppBar(
        title:
            getTranslated(context, AppLocalizationsStrings.cancelReservation),
        titleColor: AppColors.kGreyScale,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: kSize80),
            child: _buildCancellationReasonsListWidget(),
          ),
          _buildCancleButton(context),
        ],
      ),
    );
  }

  Widget _buildCancellationReasonsListWidget() {
    return GestureDetector(
      onTap: () => _othersFocus.unfocus(),
      child: ListView(
        padding: kPaddingHori24,
        children: [
          CancellationPolicyWidget(
            cancellationPolicy: argument?.cancellationPolicyList ?? [],
            cancellationPolicyDescription:
                argument?.cancellationPolicyDescription ?? '',
          ),
          Text(
            getTranslated(context, AppLocalizationsStrings.cancellationReasons),
            style: AppTheme.kHeading3.copyWith(color: AppColors.kGreyScale),
          ),
          OtaGradientText(
            gradientText: getTranslated(
                context, AppLocalizationsStrings.cancelPlsSelectReason),
            gradientTextStyle: AppTheme.kBodyRegular,
            textGradientStartColor: AppColors.kGradientStart,
            textGradientEndColor: AppColors.kGradientEnd,
          ),
          const SizedBox(height: kSize24),
          CancellationReasonsListWidget(
            othersFocus: _othersFocus,
            onTap: (index, isSelected, reason) {
              cancellationReasonBloc.setCancellationReason(
                index: index,
                isSelected: isSelected,
                reason: reason,
              );
            },
            labelList: CancellationReasonsHelper.cancellationReasons,
            textEditingController: _textEditingController,
          ),
          const SizedBox(
            height: kSize100,
          ),
        ],
      ),
    );
  }

  Widget _buildCancleButton(BuildContext context) {
    return BlocBuilder(
      bloc: cancellationReasonBloc,
      builder: () {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            color: AppColors.kLight100.withOpacity(0.94),
            padding: const EdgeInsets.symmetric(
                vertical: kSize16, horizontal: kSize24),
            child: SafeArea(
              top: false,
              child: OtaTextButton(
                key: const Key(_cancellationButton),
                title: getTranslated(
                    context, AppLocalizationsStrings.cancelReservation),
                onPressed: () {
                  _launchAppFLyerEvent();
                  _showModalBottomSheet(context);
                },
                isDisabled: cancellationReasonBloc.state.isSelected == false,
              ),
            ),
          ),
        );
      },
    );
  }

  _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (bgContext) {
        return CancellationBottomSheetWidget(
          cancelkey: const Key(_cancelOtaTextButtonWidget),
          context: bgContext,
          heading: getTranslated(
              bgContext, AppLocalizationsStrings.cancelThisReservation),
          body: getTranslated(
              bgContext, AppLocalizationsStrings.carCancellationPopup),
          onCancel: () => Navigator.of(context).pop(),
          onOK: () {
            Navigator.of(bgContext).pop();
            _getRejectBookingData(context);
          },
        );
      },
    );
  }

  void _getRejectBookingData(BuildContext widgetContext) async {
    await carBookingCancellationBloc.getCarBookingCancellationData(
      CarBookingCancellationArgument(
        confirmNo: argument!.confirmNo,
        reason: cancellationReasonBloc.state.cancellationReason ?? '',
      ),
    );

    await Future.delayed(const Duration(milliseconds: 500));
    if (carBookingCancellationBloc.state.state ==
            CarBookingCancellationScreenStates.success ||
        carBookingCancellationBloc.state.state ==
            CarBookingCancellationScreenStates.failure) {
      Navigator.pop(
          widgetContext,
          carBookingCancellationBloc.state.state ==
              CarBookingCancellationScreenStates.success);
    }
  }

  @override
  void dispose() {
    carBookingCancellationBloc.dispose();
    _textEditingController.removeListener(() {});
    _textEditingController.dispose();
    _othersFocus.dispose();
    super.dispose();
  }

  void _launchAppFLyerEvent() {
    AppFlyerHelper.addKeyValue(
        eventName: AppFlyerEvent.carCancellationEvent,
        key: CarCancellationAppFlyer.carCancellationReason,
        value: cancellationReasonBloc.state.cancellationReason);
    AppFlyerHelper.stopCapturingEvent(AppFlyerEvent.carCancellationEvent);
  }
}
