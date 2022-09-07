import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const String _kConditionalCancellation = "conditional.cancellation";
const String _kFreeCancellation = "policy.cancellation.free";
const String _kNonRefundable = "policy.cancellation.non.refundable";

class HotelBookingDetailsCancellationPolicy extends StatelessWidget {
  final bool isGradientText;
  final TextStyle headingStyle;
  final TextStyle descriptionStyle;
  final List<OtaCancellationPolicyListModel> cancellationPolicyViewModel;

  const HotelBookingDetailsCancellationPolicy({
    Key? key,
    required this.cancellationPolicyViewModel,
    this.isGradientText = true,
    this.headingStyle = AppTheme.kHeading1,
    this.descriptionStyle = AppTheme.kBodyGrey50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return cancellationPolicyViewModel.isNotEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  getTranslated(
                      context, AppLocalizationsStrings.cancellationPolicy),
                  style: headingStyle,
                ),
              ),
              const SizedBox(
                height: kSize10,
              ),
              getPolicy(context),
            ],
          )
        : const SizedBox();
  }

  Widget getPolicy(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (cancellationPolicyViewModel.isNotEmpty) getPolicyHeading(context),
        if (cancellationPolicyViewModel.isNotEmpty &&
            cancellationPolicyViewModel.elementAt(0).cancellationPolicyState ==
                _kConditionalCancellation)
          if (cancellationPolicyViewModel.isNotEmpty) getPolicyData(),
        if (cancellationPolicyViewModel.isNotEmpty)
          _getCancellationPolicyLine(context).isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: kSize16),
                  child: Text(
                    _getCancellationPolicyLine(context),
                    style: AppTheme.kBody.copyWith(color: AppColors.kGreyScale),
                  ),
                )
              : const SizedBox.shrink(),
        if (cancellationPolicyViewModel.isNotEmpty)
          const OtaHorizontalDivider(
            dividerColor: AppColors.kGrey10,
            height: kSize32,
          ),
      ],
    );
  }

  String _getCancellationPolicyLine(BuildContext context) =>
      getTranslated(context, AppLocalizationsStrings.cancellationLine)
          .replaceAll('\\n', '\n')
          .trim();

  Widget getPolicyHeading(BuildContext context) {
    String cancellationText = "";
    switch (cancellationPolicyViewModel.elementAt(0).cancellationPolicyState) {
      case _kFreeCancellation:
        cancellationText =
            getTranslated(context, AppLocalizationsStrings.freeCancellation);
        break;
      case _kNonRefundable:
        cancellationText =
            getTranslated(context, AppLocalizationsStrings.nonRefundable);
        break;
      case _kConditionalCancellation:
        cancellationText = getTranslated(
            context, AppLocalizationsStrings.conditionalCancellation);
        break;
      default:
        cancellationText =
            getTranslated(context, AppLocalizationsStrings.nonRefundable);
        break;
    }
    return isGradientText
        ? OtaGradientText(
            gradientText: cancellationText,
            gradientTextStyle: AppTheme.kBody,
            textGradientStartColor: AppColors.kGradientStart,
            textGradientEndColor: AppColors.kGradientEnd,
          )
        : Text(
            cancellationText,
            style: AppTheme.kBody.copyWith(color: AppColors.kGreyScale),
          );
  }

  Widget getPolicyData() {
    return Padding(
      padding: const EdgeInsets.only(top: kSize10),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: cancellationPolicyViewModel.length,
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  cancellationPolicyViewModel[index]
                      .cancellationDaysDescription!,
                  style: descriptionStyle),
              Text(
                  cancellationPolicyViewModel[index]
                      .cancellationChargeDescription!,
                  style: descriptionStyle),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: kSize20,
          );
        },
      ),
    );
  }
}
