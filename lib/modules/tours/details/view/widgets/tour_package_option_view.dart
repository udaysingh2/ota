import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_next_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/firebase_event.dart';
import 'package:ota/core_pack/ota_firebase/firebase_helper.dart';
import 'package:ota/core_pack/ota_firebase/tours_and_activities/activity_select_parameter.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_view_model.dart';
import 'package:ota/modules/tours/package_detail/view_model/tour_package_detail_view_model.dart';

const String _kPerConstant = '/';
const int roundingOff = 2;
const int _kMaxLines = 1;
const String _kServiceType = 'Tour';

class TourPackageOptionView extends StatefulWidget {
  final TourPackage tourPackage;
  final Function()? onReservePress;
  const TourPackageOptionView({
    Key? key,
    required this.tourPackage,
    this.onReservePress,
  }) : super(key: key);

  @override
  TourPackageOptionViewState createState() => TourPackageOptionViewState();
}

class TourPackageOptionViewState extends State<TourPackageOptionView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSize16),
      child: Container(
        padding: const EdgeInsets.fromLTRB(kSize16, kSize10, kSize16, kSize16),
        decoration: const BoxDecoration(
          borderRadius: kBorderRad12,
          border: Border.symmetric(
            horizontal: BorderSide(
              color: AppColors.kGrey10,
              width: kSize1,
            ),
            vertical: BorderSide(
              color: AppColors.kGrey10,
              width: kSize1,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getCardTopBar(),
            _getCardMiddleBar(),
            const SizedBox(
              height: kSize12,
            ),
            const OtaHorizontalDivider(
              dividerColor: AppColors.kGrey10,
            ),
            const SizedBox(
              height: kSize16,
            ),
            _getCardBottomBar()
          ],
        ),
      ),
    );
  }

  Widget _getCardTopBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: kSize6),
            child: Text(
              widget.tourPackage.packageDetail!.name!,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: AppTheme.kBodyMedium,
            ),
          ),
        ),
        OtaNextButton(
            key: const Key("OtaNextButton"),
            onPress: () {
              _onNextButtonClicked();
            }),
      ],
    );
  }

  void _onNextButtonClicked() {
    Navigator.pushNamed(context, AppRoutes.tourPackageDetailScreen,
        arguments: widget.tourPackage.packageScreen);
  }

  Widget _getCardMiddleBar() {
    List<TourHighlight> highlights =
        widget.tourPackage.packageDetail?.highlights ?? [];
    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: kSize4),
        shrinkWrap: true,
        itemCount: highlights.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (highlights[index].key != null &&
              highlights[index].value != null) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: kSize4),
              child: _getService(
                highlights[index].key!,
                highlights[index].value!,
              ),
            );
          } else {
            return const SizedBox();
          }
        });
  }

  Widget _getService(String assetId, String offerId) {
    String imageName = FacilityHelper.getAssetName(assetId);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          imageName,
          width: kSize20,
          height: kSize20,
          color: AppColors.kGrey70,
        ),
        const SizedBox(
          width: kSize6,
        ),
        Expanded(
          child: Text(
            offerId,
            maxLines: _kMaxLines,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.kSmallRegular,
          ),
        ),
      ],
    );
  }

  Widget _getCardBottomBar() {
    CurrencyUtil currencyUtil = CurrencyUtil(
      currency:
          widget.tourPackage.packageDetail?.currency ?? AppConfig().currency,
      decimalDigits: roundingOff,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: AppTheme.kHeading1.copyWith(
                  fontFamily: kFontFamily,
                ),
                children: [
                  TextSpan(
                      text: currencyUtil
                          .getFormattedPrice(
                              widget.tourPackage.packageDetail!.adultPrice!)
                          .addTrailingSpace(),
                      style: AppTheme.kBodyMedium),
                  TextSpan(
                      text: _kPerConstant +
                          getTranslated(context, AppLocalizationsStrings.pax),
                      style: AppTheme.kBodyRegularGrey50)
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          width: kSize120,
          child: OtaTextButton(
            key: const Key("OtaTextButton"),
            title: getTranslated(context, AppLocalizationsStrings.reserve),
            child: Text(
              getTranslated(context, AppLocalizationsStrings.reserve),
              style: AppTheme.kButtonText.copyWith(fontSize: kSize16),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              if (widget.onReservePress != null) {
                widget.onReservePress!();
                _getReserveClickedFirebase();
                FirebaseHelper.stopCapturingEvent(FirebaseEvent.activitySelect);
              }
            },
          ),
        )
      ],
    );
  }

  void _getReserveClickedFirebase() {
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.activitySelect,
        key: ActivitySelectParameter.activityService,
        value: _kServiceType);
    FirebaseHelper.addKeyValue(
        eventName: FirebaseEvent.activitySelect,
        key: ActivitySelectParameter.activityPackageName,
        value: widget.tourPackage.packageDetail?.name);
    FirebaseHelper.addDoubleValue(
        eventName: FirebaseEvent.activitySelect,
        key: ActivitySelectParameter.activityPricePerPerson,
        value: widget.tourPackage.packageDetail?.adultPrice);
    }
}
