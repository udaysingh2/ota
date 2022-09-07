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

class TourReserveDetailsWidget extends StatelessWidget {
  final DateTime? packageDate;
  final String? numberOfDays;
  final String? activityDuration;
  final String? contactName;
  final String? noOfParticipants;
  final String? participationInformation;
  final EdgeInsetsGeometry? padding;
  const TourReserveDetailsWidget({
    Key? key,
    this.packageDate,
    this.numberOfDays,
    this.activityDuration,
    this.contactName,
    this.noOfParticipants,
    this.participationInformation,
    this.padding = _kDefaultPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kSize24),
          if (packageDate != null)
            Text(
              Helpers.getwwddMMMyy(packageDate!),
              style: AppTheme.kBodyMedium,
              maxLines: _kMaxLines,
              overflow: TextOverflow.ellipsis,
            ),
          if (numberOfDays != null) const SizedBox(height: kSize8),
          if (numberOfDays != null) _getNumberOfdaysRow(context, numberOfDays!),
          if (numberOfDays != null && numberOfDays!.isNotEmpty)
            const SizedBox(height: kSize8),
          if (activityDuration != null && activityDuration!.isNotEmpty)
            _getDurationRow(context, activityDuration!),
          if (noOfParticipants != null && noOfParticipants!.isNotEmpty)
            const SizedBox(height: kSize8),
          if (noOfParticipants != null && noOfParticipants!.isNotEmpty)
            _getNumberofParticipantsRow(context, noOfParticipants!),
          if (contactName != null && contactName!.isNotEmpty)
            const SizedBox(height: kSize8),
          if (contactName != null && contactName!.isNotEmpty)
            _getContactNameRow(context, contactName!),
          const SizedBox(height: kSize24),
          const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        ],
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

  Widget _getNumberofParticipantsRow(
      BuildContext context, String noOfParticipants) {
    return Row(
      children: [
        Expanded(
            child: Text(
          getTranslated(context, AppLocalizationsStrings.numberOfTravellers),
          style: AppTheme.kBodyRegular,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        )),
        Text(noOfParticipants, style: AppTheme.kBodyMedium),
      ],
    );
  }

  Widget _getContactNameRow(BuildContext context, String contactName) {
    return Row(
      children: [
        Expanded(
            child: Text(
          getTranslated(context, AppLocalizationsStrings.contactPersonName),
          style: AppTheme.kBodyRegular,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        )),
        Text(contactName, style: AppTheme.kBodyMedium),
      ],
    );
  }
}
