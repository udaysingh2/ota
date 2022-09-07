import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/bloc/car_booking_detail_bloc.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view_model/car_booking_detail_view_model.dart';

import 'car_details_view_controller.dart';

const String _kUpArrowIcon = "assets/images/icons/arrow_up.svg";
const String _kDownArrowIcon = "assets/images/icons/arrow_down.svg";
const String _kCarDetailCancellationPolicyViewlKey =
    "car_detail_cancellation_policy_view_key";

class CarBookingDetailCancellationPolicy extends StatelessWidget {
  final CarBookingDetailBloc carBookingDetailBloc;
  final CarDetailsViewController carDetailsViewController;

  const CarBookingDetailCancellationPolicy({
    Key? key,
    required this.carBookingDetailBloc,
    required this.carDetailsViewController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CancellationPolicyModel> cancellationPolicy = carBookingDetailBloc
            .state.bookingDetail?.carBookingDetails?.cancellationPolicy ??
        [];
    String cancellationPolicyDescription = getTranslated(
        context, AppLocalizationsStrings.carCancelPolicyConfigLine);
    if (cancellationPolicy.isEmpty && cancellationPolicyDescription.isEmpty) {
      return const SizedBox.shrink();
    }
    return BlocBuilder(
      bloc: carDetailsViewController,
      builder: () {
        return Column(
          children: [
            const OtaHorizontalDivider(
              dividerColor: AppColors.kGrey10,
            ),
            const SizedBox(height: kSize24),
            Row(
              children: [
                Expanded(
                  child: Text(
                    getTranslated(
                        context, AppLocalizationsStrings.cancelationPolicy),
                    style: AppTheme.kHeading1Medium,
                  ),
                ),
                OtaIconButton(
                  key: const Key(_kCarDetailCancellationPolicyViewlKey),
                  icon: SvgPicture.asset(
                    carDetailsViewController.isViewOpen
                        ? _kUpArrowIcon
                        : _kDownArrowIcon,
                  ),
                  onTap: () => carDetailsViewController.updateState(),
                )
              ],
            ),
            const SizedBox(height: kSize16),
            if (carDetailsViewController.isViewOpen)
              Column(
                children: cancellationPolicy
                    .map(
                      (policy) => Padding(
                        padding: const EdgeInsets.only(bottom: kSize20),
                        child: Text(
                          policy.message ?? '',
                          style: AppTheme.kBodyRegular.copyWith(
                            color: AppColors.kGrey50,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            if (carDetailsViewController.isViewOpen &&
                cancellationPolicyDescription.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: kSize20),
                child: Text(
                  cancellationPolicyDescription.replaceAll('\\n', '\n'),
                  style: AppTheme.kSmallRegular.copyWith(
                    color: AppColors.kGrey50,
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
