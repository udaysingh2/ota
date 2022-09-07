import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';
import 'package:ota/modules/tours/reservation/view_model/tour_review_reservation_view_model.dart';

const String _kPlaceholderImage =
    'assets/images/icons/suggetion_card_palceholder.svg';
const double _kImageHeight = 152.0;

class PackageReservationInfo extends StatelessWidget {
  final String? imageUrl;
  final String? tourName;
  final String? packageName;
  final List<TourHighlight>? facilityMap;
  final double? adultPricePerNight;
  final double? childrenPricePerNight;
  final int? childCount;
  final ToursChildInfo? childInfo;
  const PackageReservationInfo({
    Key? key,
    this.imageUrl,
    this.tourName,
    this.packageName,
    this.facilityMap,
    this.adultPricePerNight,
    this.childrenPricePerNight,
    this.childCount,
    this.childInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: _getChildrenList(context),
      ),
    );
  }

  List<Widget> _getChildrenList(BuildContext context) {
    List<Widget> childrenList = [];

    childrenList.add(_getHeading(context));
    childrenList.add(const SizedBox(height: kSize16));
    childrenList.add(_getImageCard(context));
    childrenList.add(const SizedBox(height: kSize16));

    if (tourName != null) {
      childrenList.add(_getName(tourName!, AppTheme.kHeading1Medium));
      childrenList.add(const SizedBox(height: kSize4));
    }

    if (packageName != null) {
      childrenList.add(_getName(packageName!, AppTheme.kHeading1Medium));
      childrenList.add(const SizedBox(height: kSize16));
    }

    if (facilityMap != null) {
      childrenList.add(_getFacilityView(context, facilityMap));
      childrenList.add(const SizedBox(height: kSize8));
    }

    if (adultPricePerNight != null) {
      childrenList.add(_getAdultPrice(context));
    }

    if (childrenPricePerNight != null &&
        childCount != null &&
        childCount! > 0) {
      childrenList.add(const SizedBox(height: kSize8));
      childrenList.add(_getChildrenPrice(context));
    }

    childrenList.add(const SizedBox(height: kSize16));
    childrenList
        .add(const OtaHorizontalDivider(dividerColor: AppColors.kGrey10));

    return childrenList;
  }

  Widget _getHeading(BuildContext context) {
    return Text(
      getTranslated(context, AppLocalizationsStrings.yourReservation),
      style: AppTheme.kHeading1Medium,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getImageCard(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
      child: SizedBox(
        height: _kImageHeight,
        width: double.infinity,
        child: imageUrl != null
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => _getDefaultImage(context),
                placeholder: (context, url) => _getDefaultImage(context))
            : _getDefaultImage(context),
      ),
    );
  }

  Widget _getDefaultImage(BuildContext context) {
    return SvgPicture.asset(_kPlaceholderImage,
        fit: BoxFit.cover, width: MediaQuery.of(context).size.width - kSize48);
  }

  Widget _getName(String name, TextStyle? textStyle) {
    return Text(
      name,
      style: textStyle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
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
