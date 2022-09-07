import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';

class TourBookingInfo extends StatelessWidget {
  final double adultPricePerNight;
  final double? childrenPricePerNight;
  final int? childCount;
  final ToursChildInfo? childInfo;
  const TourBookingInfo({
    Key? key,
    required this.adultPricePerNight,
    this.childrenPricePerNight,
    this.childCount,
    this.childInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: _getChildrenList(context),
    );
  }

  List<Widget> _getChildrenList(BuildContext context) {
    List<Widget> childrenList = [];

    childrenList.add(const SizedBox(height: kSize16));
    childrenList
        .add(const OtaHorizontalDivider(dividerColor: AppColors.kGrey10));
    childrenList.add(const SizedBox(height: kSize16));
    childrenList.add(_getAdultPrice(context));

    if (childrenPricePerNight != null && childCount! >= 0 && childCount! >= 0) {
      childrenList.add(const SizedBox(height: kSize8));
      childrenList.add(_getChildrenPrice(context));
    }

    childrenList.add(const SizedBox(height: kSize24));
    childrenList
        .add(const OtaHorizontalDivider(dividerColor: AppColors.kGrey10));

    return childrenList;
  }

  Widget _getAdultPrice(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(getTranslated(context, AppLocalizationsStrings.adults),
            style: AppTheme.kBodyRegular),
        _getPrice(context, adultPricePerNight, AppLocalizationsStrings.pax),
      ],
    );
  }

  Widget _getChildrenPrice(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
            text:
                TextSpan(style: DefaultTextStyle.of(context).style, children: [
          TextSpan(
              text: getTranslated(context, AppLocalizationsStrings.children)
                  .addTrailingSpace(),
              style: AppTheme.kBodyRegular),
          TextSpan(
              text: _getChildInfoText(context),
              style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50))
        ])),
        _getPrice(context, childrenPricePerNight, AppLocalizationsStrings.pax),
      ],
    );
  }

  String? _getChildInfoText(BuildContext context) {
    String? childAge;
    if (childInfo != null &&
        childInfo!.maxAge != null &&
        childInfo!.minAge != null &&
        (childInfo!.maxAge! > childInfo!.minAge!)) {
      childAge =
          '${getTranslated(context, AppLocalizationsStrings.ages).addLeadingSpace().addTrailingSpace()}${childInfo!.minAge}-${childInfo!.maxAge}';
    }
    return childAge;
  }

  Widget _getPrice(BuildContext context, num? price, String perKey) {
    CurrencyUtil currencyUtil = CurrencyUtil();
    return Align(
      alignment: Alignment.centerRight,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: currencyUtil
                    .getFormattedPrice(price ?? 0)
                    .addTrailingSpace(),
                style: AppTheme.kBodyMedium.copyWith(fontFamily: kFontFamily)),
            TextSpan(
                text: getTranslated(context, perKey).addLeadingSlash(),
                style: AppTheme.kBodyMedium.copyWith(
                    fontFamily: kFontFamily, color: AppColors.kGrey50))
          ],
        ),
      ),
    );
  }
}
