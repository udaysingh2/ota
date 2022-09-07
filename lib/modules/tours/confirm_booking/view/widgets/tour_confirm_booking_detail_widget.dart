import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_banner_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_free_food_banner/ota_free_food_promotion_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double _kDefaultHeightThickness = 1;
const int _kMaxLines = 1;
const double _kContentHeight = 1.42;
const String _kOpenTravellersInfoKey = "OpenTravellersInfoKey";

class TourConfirmBookingDetailsWidget extends StatelessWidget {
  final DateTime bookingDate;
  final String numberOfDays;
  final String durationText;
  final int numberOfAdults;
  final int numberOfChild;
  final String contactPerson;
  final bool showTravellersInfo;
  final bool showPromotionTag;
  final List<OtaFreeFoodPromotionModel> promotionData;
  final Function()? openTravellersInfo;
  final Function(String) openWebView;

  const TourConfirmBookingDetailsWidget(
      {Key? key,
      required this.bookingDate,
      required this.numberOfDays,
      required this.durationText,
      required this.numberOfAdults,
      required this.numberOfChild,
      required this.contactPerson,
      this.showTravellersInfo = false,
      required this.showPromotionTag,
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
                const SizedBox(
                  height: kSize16,
                ),
                _getRowWithString(context, AppLocalizationsStrings.numberOfdays,
                    numberOfDays, AppLocalizationsStrings.days),
                if (durationText.isNotEmpty)
                  const SizedBox(
                    height: kSize8,
                  ),
                if (durationText.isNotEmpty)
                  _getRow(
                      context, AppLocalizationsStrings.duration, durationText),
                const SizedBox(
                  height: kSize8,
                ),
                _getNumberOfTravellers(context),
                const SizedBox(
                  height: kSize8,
                ),
                _getContactPersonName(context,
                    AppLocalizationsStrings.contactPersonName, contactPerson),
                if (showTravellersInfo)
                  const SizedBox(
                    height: kSize8,
                  ),
                if (showTravellersInfo)
                  _getTravellersInfo(
                      context,
                      AppLocalizationsStrings.travellersInformation,
                      AppLocalizationsStrings.seeDetails),
                if (showPromotionTag) _getPromotionTagWidget(context),
              ],
            ),
            const SizedBox(
              height: kSize16,
            ),
          ],
        ),
      ),
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
          style: AppTheme.kBody,
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
        OtaFreeFoodBannerWidget(
          freeFoodPromotionList: promotionData,
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

  Widget _getNumberOfTravellers(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          getTranslated(context, AppLocalizationsStrings.numberOfTravellers),
          style: AppTheme.kBodyRegular,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        )),
        RichText(
          text: TextSpan(
            style: AppTheme.kRichTextStyle(AppTheme.kBodyMedium),
            children: [
              TextSpan(
                  text: getTranslated(context, AppLocalizationsStrings.adults)
                          .addTrailingSpace() +
                      numberOfAdults.toString()),
              if (numberOfChild != 0)
                TextSpan(
                  text: getTranslated(context, AppLocalizationsStrings.children)
                          .addLeadingSpace() +
                      numberOfChild.toString().addLeadingSpace(),
                )
            ],
          ),
        )
      ],
    );
  }
}
