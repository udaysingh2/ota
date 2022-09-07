import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';
import 'package:ota/modules/tours/reservation/helper/tour_expandable_controller.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_expandable_view_model.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';

const String _arrowUp = "assets/images/icons/arrow_up.svg";
const String _arrowDown = "assets/images/icons/arrow_down.svg";

class TourDetailWidget extends StatelessWidget {
  final String? title;
  final List<TourHighlight>? facilityMap;
  final double? adultPricePerNight;
  final double? childrenPricePerNight;
  final int? childCount;
  final ToursChildInfo? childInfo;
  final TourExpandableController controller;

  const TourDetailWidget(
      {Key? key,
      this.title,
      this.facilityMap,
      this.adultPricePerNight,
      this.childrenPricePerNight,
      this.childCount,
      this.childInfo,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: controller,
        builder: () {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: kSize24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: kSize24),
                if (title != null) _getTitle(title!, AppTheme.kHeading1Medium),
                if (title != null) const SizedBox(height: kSize16),
                Row(
                  children: [
                    Text(
                      getTranslated(
                          context, AppLocalizationsStrings.activityDetail),
                      style: AppTheme.kBodyMedium,
                    ),
                    const Spacer(),
                    _getArrowIcon(controller),
                  ],
                ),
                if (controller.state.state == TourExpandableModelState.expanded)
                  _getExpandedView(context),
                const SizedBox(height: kSize24),
                const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
              ],
            ),
          );
        });
  }

  Widget _getTitle(String title, TextStyle? textStyle) {
    return Text(
      title,
      style: textStyle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getArrowIcon(TourExpandableController controller) {
    return OtaIconButton(
      icon: controller.state.state == TourExpandableModelState.expanded
          ? SvgPicture.asset(
              _arrowUp,
              width: kSize20,
              height: kSize20,
            )
          : SvgPicture.asset(
              _arrowDown,
              width: kSize20,
              height: kSize20,
            ),
      onTap: () {
        controller.toggle();
      },
    );
  }

  Widget _getExpandedView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _getChildrenList(context),
    );
  }

  List<Widget> _getChildrenList(BuildContext context) {
    List<Widget> childrenList = [];
    if (facilityMap != null) {
      childrenList.add(const SizedBox(height: kSize16));
      childrenList.add(_getFacilityView(context, facilityMap));
      childrenList.add(const SizedBox(height: kSize24));
    }

    if (adultPricePerNight != null) {
      if (facilityMap == null) {
        childrenList.add(const SizedBox(height: kSize24));
      }
      childrenList
          .add(const OtaHorizontalDivider(dividerColor: AppColors.kGrey10));
      childrenList.add(const SizedBox(height: kSize24));
      childrenList.add(_getAdultPrice(context));
    }

    if (childrenPricePerNight != null &&
        childCount != null &&
        childCount! > 0) {
      childrenList.add(const SizedBox(height: kSize8));
      childrenList.add(_getChildrenPrice(context));
    }

    return childrenList;
  }

  Widget _getFacilityView(
      BuildContext context, List<TourHighlight>? facilityMap) {
    return Column(
      children: _getFacilityList(context, facilityMap),
    );
  }

  List<Widget> _getFacilityList(
      BuildContext context, List<TourHighlight>? facilityMap) {
    List<Widget> facilityList = [];
    if (facilityMap != null && facilityMap.isNotEmpty) {
      for (TourHighlight facility in facilityMap) {
        if (facility.value != null) {
          facilityList.add(_getService(facility.key!, facility.value!));
          facilityList.add(const SizedBox(
            height: kSize6,
          ));
        }
      }
    }
    return facilityList;
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.kSmallRegular,
          ),
        ),
      ],
    );
  }

  Widget _getAdultPrice(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(getTranslated(context, AppLocalizationsStrings.adults),
            style: AppTheme.kBodyRegular),
        _getPrice(context, adultPricePerNight),
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
        _getPrice(context, childrenPricePerNight),
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
          '${getTranslated(context, AppLocalizationsStrings.ages).addLeadingSpace()}${childInfo!.minAge}-${childInfo!.maxAge}';
    }
    return childAge;
  }

  Widget _getPrice(BuildContext context, num? price) {
    CurrencyUtil currencyUtil = CurrencyUtil();
    return Align(
        alignment: Alignment.centerRight,
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: currencyUtil
                    .getFormattedPrice(price ?? 0)
                    .addTrailingSpace(),
                style: AppTheme.kBodyMedium.copyWith(fontFamily: kFontFamily)),
            TextSpan(
                text: getTranslated(context, AppLocalizationsStrings.pax)
                    .addLeadingSlash(),
                style: AppTheme.kBodyRegularGrey50
                    .copyWith(fontFamily: kFontFamily))
          ]),
        ));
  }
}
