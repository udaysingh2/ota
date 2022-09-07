import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const String _kLocationPlaceholder =
    'assets/images/icons/location_suggestion.svg';
const String _kRightArrow = 'assets/images/icons/arrow_right.svg';
const int _kMaxLine = 1;
const String _kCarPickUpDropOffWidgetKey = "car_pickup_dropoff_key";

class CarPickUpDropOffWidget extends StatelessWidget {
  final String pickUpLocation;
  final String dropOffLocation;
  final Function()? onPress;

  const CarPickUpDropOffWidget({
    required this.pickUpLocation,
    required this.dropOffLocation,
    this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: kSize24, right: kSize24, top: kSize24),
      child: Column(
        children: [
          GestureDetector(
            key: const Key(_kCarPickUpDropOffWidgetKey),
            onTap: onPress,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    getTranslated(
                        context, AppLocalizationsStrings.pickUpDropOffDetails),
                    style: AppTheme.kHeading1Medium,
                    maxLines: _kMaxLine,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: kSize8),
                SvgPicture.asset(
                  _kRightArrow,
                  color: AppColors.kGrey70,
                ),
              ],
            ),
          ),
          const SizedBox(height: kSize24),
          _getLocationWidget(
            context: context,
            title: AppLocalizationsStrings.carPickupPoint,
            location: pickUpLocation,
          ),
          const SizedBox(height: kSize24),
          _getLocationWidget(
            context: context,
            title: AppLocalizationsStrings.dropOffPoint,
            location: dropOffLocation,
          ),
          if (pickUpLocation != dropOffLocation) _setDropText(context),
          const SizedBox(height: kSize24),
          const OtaHorizontalDivider(
            dividerColor: AppColors.kGrey10,
          ),
        ],
      ),
    );
  }

  _setDropText(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: kSize24),
        Text(
          getTranslated(context, AppLocalizationsStrings.dropOffFeeText),
          style: AppTheme.kSmallRegular,
        ),
      ],
    );
  }

  Widget _getLocationWidget(
      {required BuildContext context,
      required String title,
      required String location}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          _kLocationPlaceholder,
          color: AppColors.kGrey70,
        ),
        const SizedBox(width: kSize12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated(context, title),
                style: AppTheme.kBodyMedium,
                maxLines: _kMaxLine,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                location,
                style: AppTheme.kBodyRegular,
                maxLines: _kMaxLine,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    );
  }
}
