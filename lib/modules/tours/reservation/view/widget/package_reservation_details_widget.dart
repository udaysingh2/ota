import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const EdgeInsetsGeometry _kDefaultPadding = kPaddingHori24;
const int _kMaxLines = 1;

class PackageReservationDetailWidget extends StatelessWidget {
  final DateTime packageDate;
  final String? numberOfDays;
  final String? activityDuration;
  final int? numberOfAdults;
  final int? numberOfChildren;
  final EdgeInsetsGeometry? padding;
  const PackageReservationDetailWidget({
    Key? key,
    required this.packageDate,
    this.numberOfDays,
    this.activityDuration,
    this.numberOfAdults,
    this.numberOfChildren,
    this.padding = _kDefaultPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kSize24),
            Text(
              Helpers.getwwddMMMyy(packageDate),
              style: AppTheme.kBodyMedium,
              maxLines: _kMaxLines,
              overflow: TextOverflow.ellipsis,
            ),
            if (numberOfDays != null) const SizedBox(height: kSize8),
            if (numberOfDays != null)
              _getNumberOfdaysRow(context, numberOfDays!),
            if (activityDuration != null && activityDuration!.isNotEmpty)
              const SizedBox(height: kSize8),
            if (activityDuration != null && activityDuration!.isNotEmpty)
              _getDurationRow(context, activityDuration!),
            if (numberOfAdults != null) const SizedBox(height: kSize8),
            if (numberOfAdults != null)
              _getGuestRow(context, numberOfAdults!, numberOfChildren),
            const SizedBox(height: kSize24),
            const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          ],
        ),
      ),
    );
  }

  Widget _getNumberOfdaysRow(BuildContext context, String count) {
    return Row(
      children: [
        Expanded(
            child: Text(
          getTranslated(context, AppLocalizationsStrings.numberOfdays),
          style: AppTheme.kBodyRegular,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        )),
        Text(
            count.addTrailingSpace() +
                getTranslated(context, AppLocalizationsStrings.days),
            style: AppTheme.kBodyMedium),
      ],
    );
  }

  Widget _getDurationRow(BuildContext context, String durationText) {
    return Row(
      children: [
        Expanded(
            child: Text(
          getTranslated(context, AppLocalizationsStrings.duration),
          style: AppTheme.kBodyRegular,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        )),
        Text(durationText, style: AppTheme.kBodyMedium),
      ],
    );
  }

  Widget _getGuestRow(BuildContext context, int adultCount, int? childCount) {
    String numberOfParticipants =
        getTranslated(context, AppLocalizationsStrings.adults)
                .addTrailingSpace() +
            adultCount.toString();

    if (childCount != null && childCount > 0) {
      numberOfParticipants +=
          getTranslated(context, AppLocalizationsStrings.children)
                  .addTrailingSpace()
                  .addLeadingSpace() +
              childCount.toString();
    }

    return Row(
      children: [
        Expanded(
            child: Text(
          getTranslated(context, AppLocalizationsStrings.numberOfTravellers),
          style: AppTheme.kBodyRegular,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        )),
        Text(numberOfParticipants, style: AppTheme.kBodyMedium),
      ],
    );
  }
}
