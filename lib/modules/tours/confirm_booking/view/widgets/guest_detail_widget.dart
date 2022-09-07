import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/tour_confirm_booking_view_model.dart';

const int _kMaxLines = 1;

class GuestDetailsWidget extends StatelessWidget {
  final ParticipantInfoViewModel data;
  final String title;

  const GuestDetailsWidget({Key? key, required this.data, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSize32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: AppTheme.kHBody.copyWith(color: AppColors.kGreyScale),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: kSize16),
        Text(
          data.name!.addTrailingSpace() + data.surname!,
          style: AppTheme.kBody,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: kSize10,
        ),
        if (data.weight != null)
          _getDetailRow(
              context,
              getTranslated(context, AppLocalizationsStrings.weight),
              data.weight!.toString()),
        if (data.weight != null)
          const SizedBox(
            height: kSize10,
          ),
        if (data.dateOfBirth != null)
          _getDetailRow(
              context,
              getTranslated(context, AppLocalizationsStrings.dateOfBirth),
              data.dateOfBirth!),
        if (data.dateOfBirth != null)
          const SizedBox(
            height: kSize10,
          ),
        if (data.passportCountry != null)
          _getDetailRow(
              context,
              getTranslated(
                  context, AppLocalizationsStrings.countryAsInPassport),
              data.passportCountry!),
        if (data.passportCountry != null)
          const SizedBox(
            height: kSize10,
          ),
        if (data.passportNumber != null)
          _getDetailRow(
              context,
              getTranslated(context, AppLocalizationsStrings.passportNo),
              data.passportNumber!),
        if (data.passportNumber != null)
          const SizedBox(
            height: kSize10,
          ),
        if (data.passportCountryIssue != null)
          _getDetailRow(
              context,
              getTranslated(
                  context, AppLocalizationsStrings.passportIssuingCountry),
              data.passportCountryIssue!),
        if (data.passportCountryIssue != null)
          const SizedBox(
            height: kSize10,
          ),
        if (data.expiryDate != null)
          _getDetailRow(
              context,
              getTranslated(
                  context, AppLocalizationsStrings.passportExpiryDate),
              data.expiryDate!),
        if (data.expiryDate != null)
          const SizedBox(
            height: kSize16,
          ),
      ]),
    );
  }

  Widget _getDetailRow(BuildContext context, String text1, String text2) {
    return Row(
      children: [
        Expanded(
            child: Text(
          text1,
          style: AppTheme.kSmall2,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        )),
        Text(
          text2,
          style: AppTheme.kSmall2,
        ),
      ],
    );
  }
}
