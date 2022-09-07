import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view_model/car_booking_detail_view_model.dart';

class CancellationPolicyWidget extends StatelessWidget {
  final List<CancellationPolicyModel> cancellationPolicy;
  final String cancellationPolicyDescription;
  const CancellationPolicyWidget(
      {Key? key,
      required this.cancellationPolicy,
      required this.cancellationPolicyDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cancellationPolicy.isEmpty && cancellationPolicyDescription.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslated(context, AppLocalizationsStrings.cancelationPolicy),
          style: AppTheme.kHeading1Medium,
        ),
        const SizedBox(height: kSize10),
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
        if (cancellationPolicyDescription.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: kSize20),
            child: Text(
              cancellationPolicyDescription.replaceAll('\\n', '\n'),
              style: AppTheme.kSmallRegular.copyWith(
                color: AppColors.kGrey50,
              ),
            ),
          ),
        const SizedBox(height: kSize24),
        const OtaHorizontalDivider(
          dividerColor: AppColors.kGrey10,
        ),
        const SizedBox(height: kSize24),
      ],
    );
  }
}
