import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

import '../../../../../core_pack/custom_widgets/ota_free_food_banner/ota_free_food_banner_widget.dart';

const double _kDefaultHeightThickness = 1;
const int _kMaxLines = 1;
const double _kContentHeight = 1.42;
const String _kOpenTravellersInfoKey = "OpenTravellersInfoKey";

class TicketConfirmBookingDetailsWidget extends StatelessWidget {
  final DateTime bookingDate;
  final String? numberOfDays;
  final String? durationText;
  final String contactPerson;
  final bool showTravellersInfo;
  final List<OtaFreeFoodPromotionModel> promotionData;
  final Function()? openTravellersInfo;
  final Function(String url) openWebView;

  const TicketConfirmBookingDetailsWidget(
      {Key? key,
      required this.bookingDate,
      this.numberOfDays,
      this.durationText,
      required this.contactPerson,
      this.showTravellersInfo = false,
      required this.promotionData,
      this.openTravellersInfo,
      required this.openWebView})
      : super(key: key);

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
                  Helpers.getwwddMMMyy(bookingDate),
                  style: AppTheme.kBodyMedium,
                  maxLines: _kMaxLines,
                  overflow: TextOverflow.ellipsis,
                ),
                if (numberOfDays != null && numberOfDays!.isNotEmpty)
                  const SizedBox(height: kSize8),
                if (numberOfDays != null && numberOfDays!.isNotEmpty)
                  _getRowWithString(
                      context,
                      AppLocalizationsStrings.numberOfdays,
                      numberOfDays!,
                      AppLocalizationsStrings.days),
                if (durationText != null && durationText!.isNotEmpty)
                  const SizedBox(height: kSize8),
                if (durationText != null && durationText!.isNotEmpty)
                  _getRow(
                      context, AppLocalizationsStrings.duration, durationText!),
                const SizedBox(height: kSize8),
                _getContactPersonName(context,
                    AppLocalizationsStrings.contactPersonName, contactPerson),
                if (showTravellersInfo) const SizedBox(height: kSize8),
                if (showTravellersInfo)
                  _getTravellersInfo(
                      context,
                      AppLocalizationsStrings.travellersInformation,
                      AppLocalizationsStrings.seeDetails),
                if (promotionData.isNotEmpty) _getPromotionTagWidget(context),
              ],
            ),
            const SizedBox(height: kSize16),
          ],
        ),
      ),
    );
  }

  Widget _getPromotionTagWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kSize16),
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        const SizedBox(height: kSize16),
        Text(
          getTranslated(context, AppLocalizationsStrings.robinhoodSpecialOffer),
          style: AppTheme.kHeading1Medium,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: kSize16),
        OtaFreeFoodBannerWidget(freeFoodPromotionList: promotionData),
      ],
    );
  }

  Widget _getContactPersonName(
      BuildContext context, String leftText, String rightText) {
    return Row(
      children: [
        Expanded(
            child: Text(
          getTranslated(context, leftText),
          style: AppTheme.kBodyRegular,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        )),
        Text(rightText, style: AppTheme.kBodyMedium),
      ],
    );
  }

  Widget _getTravellersInfo(
      BuildContext context, String leftText, String rightText) {
    return Row(
      children: [
        Expanded(
            child: Text(
          getTranslated(context, leftText),
          style: AppTheme.kBodyRegular,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        )),
        InkWell(
          key: const Key(_kOpenTravellersInfoKey),
          onTap: openTravellersInfo,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return AppColors.gradient1
                  .createShader(Offset.zero & bounds.size);
            },
            child: Text(
              getTranslated(context, AppLocalizationsStrings.seeDetails),
              style: AppTheme.kSmall1.copyWith(
                color: AppColors.kTrueWhite,
                fontWeight: FontWeight.w400,
                height: _kContentHeight,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getRow(BuildContext context, String leftText, String rightText) {
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
          rightText,
          style: AppTheme.kBodyMedium,
        ),
      ],
    );
  }

  Widget _getRowWithString(
      BuildContext context, String leftText, String count, String rightText) {
    return Row(
      children: [
        Expanded(
            child: Text(
          getTranslated(context, leftText),
          style: AppTheme.kBodyRegular,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        )),
        Text(count.addTrailingSpace() + getTranslated(context, rightText),
            style: AppTheme.kBodyMedium),
      ],
    );
  }
}
