import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double _kDefaultHeightThickness = 1;
const int _kMaxLines = 1;

class HotelPaymentReservationDetailsWidget extends StatelessWidget {
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int numberOfNights;
  final int numberOfRooms;
  final int numberOfAdults;
  final int? numberOfChildren;
  final bool showDivider;
  final String? guestName;
  const HotelPaymentReservationDetailsWidget({
    Key? key,
    required this.checkOutDate,
    required this.checkInDate,
    required this.numberOfNights,
    required this.numberOfRooms,
    required this.numberOfAdults,
    this.numberOfChildren,
    this.showDivider = true,
    this.guestName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kSize24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const OtaHorizontalDivider(
              dividerColor: AppColors.kGrey10,
              height: kSize32,
              thickness: _kDefaultHeightThickness,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Helpers.getwwddMMMyyyy(checkInDate).addTrailingDash() +
                      Helpers.getwwddMMMyyyy(checkOutDate),
                  style: AppTheme.kBodyMedium,
                  maxLines: _kMaxLines,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: kSize10,
                ),
                _getRow(context, AppLocalizationsStrings.numberOfNights,
                    numberOfNights, AppLocalizationsStrings.nights),
                const SizedBox(
                  height: kSize10,
                ),
                _getRow(context, AppLocalizationsStrings.numberOfRooms,
                    numberOfRooms, AppLocalizationsStrings.roomLabel),
                const SizedBox(
                  height: kSize10,
                ),
                _getNumberOfGuests(context),
                if (guestName != null)
                  const SizedBox(
                    height: kSize10,
                  ),
                if (guestName != null)
                  _getGuestName(
                      context, AppLocalizationsStrings.guestName, guestName!)
              ],
            ),
            const SizedBox(
              height: kSize22,
            ),
            if (showDivider)
              const OtaHorizontalDivider(
                dividerColor: AppColors.kGrey10,
                height: kSize1,
              ),
          ],
        ),
      ),
    );
  }

  Widget _getGuestName(
      BuildContext context, String leftText, String rightText) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslated(context, leftText),
          style: AppTheme.kBodyRegular,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(width: kSize16),
        Expanded(
          child: Text(
            rightText,
            style: AppTheme.kBodyMedium,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _getRow(
      BuildContext context, String leftText, int count, String rightText) {
    return Row(
      children: [
        Expanded(
            child: Text(
          getTranslated(context, leftText),
          style: AppTheme.kBodyRegular,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        )),
        Text(
            count.toString().addTrailingSpace() +
                getTranslated(context, rightText),
            style: AppTheme.kBodyMedium),
      ],
    );
  }

  Widget _getNumberOfGuests(BuildContext context) {
    int numberOfChild =
        numberOfChildren ?? AppConfig().configModel.defaultChildCount;
    return Row(
      children: [
        Expanded(
            child: Text(
          getTranslated(context, AppLocalizationsStrings.numberOfGuests),
          style: AppTheme.kBodyRegular,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        )),
        RichText(
            text: TextSpan(
                style: AppTheme.kBodyMedium.copyWith(fontFamily: kFontFamily),
                children: [
              TextSpan(
                  text: getTranslated(context, AppLocalizationsStrings.adults)
                          .addTrailingSpace() +
                      numberOfAdults.toString()),
              if (numberOfChild != 0)
                TextSpan(
                    text:
                        getTranslated(context, AppLocalizationsStrings.children)
                                .addLeadingSpace() +
                            numberOfChild.toString().addLeadingSpace())
            ]))
      ],
    );
  }
}
