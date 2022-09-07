import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const int _kMaxLines = 1;
const String _kNoOfSeatIcon = 'assets/images/icons/users_alt.svg';
const String _kNoOfDoorsIcon = 'assets/images/icons/car_door_icon.svg';
const String _kAutomaticIcon = 'assets/images/icons/car_automatic_icon.svg';
const String _kNoOfBagsIcon = 'assets/images/icons/car_bag_icon.svg';
const String _kAotomaticType = 'A';

class CarPaymentSuccessDetailList extends StatelessWidget {
  final int? noOfSeats;
  final String? gear;
  final int? noOfDoors;
  final int? noOfLargeBag;
  final int? noOfSmallBag;

  const CarPaymentSuccessDetailList({
    this.noOfSeats,
    this.gear,
    this.noOfDoors,
    this.noOfLargeBag,
    this.noOfSmallBag,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getCarDetails(context),
      ],
    );
  }

  Widget _getCarDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [_getCarReservationDetailList(context)],
    );
  }

  Widget _getCarReservationDetailList(BuildContext context) {
    return Column(
      children: [
        _getCarReservationDetailListItem(
          context: context,
          icon: _kNoOfSeatIcon,
          title: noOfSeats.toString() +
              getTranslated(context, AppLocalizationsStrings.carRentalOnlySeats)
                  .addLeadingSpace(),
        ),
        _getCarReservationDetailListItem(
          context: context,
          icon: _kNoOfDoorsIcon,
          title: noOfDoors.toString() +
              getTranslated(context, AppLocalizationsStrings.doors)
                  .addLeadingSpace(),
        ),
        noOfLargeBag != 0
            ? _getCarReservationDetailListItem(
                context: context,
                icon: _kNoOfBagsIcon,
                title: getTranslated(
                        context, AppLocalizationsStrings.bagsOnly) +
                    noOfLargeBag.toString() +
                    getTranslated(
                            context, AppLocalizationsStrings.carRentalOnlyBags)
                        .addLeadingSpace(),
              )
            : const SizedBox.shrink(),
        _getCarReservationDetailListItem(
          context: context,
          icon: _kAutomaticIcon,
          title: getTranslated(
              context,
              gear == _kAotomaticType
                  ? AppLocalizationsStrings.automatic
                  : AppLocalizationsStrings.manual),
        ),
      ],
    );
  }

  Widget _getCarReservationDetailListItem({
    required BuildContext context,
    required String icon,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSize12),
      child: Row(
        children: [
          SizedBox(
            height: kSize20,
            width: kSize20,
            child: Center(
              child: SvgPicture.asset(
                icon,
                color: AppColors.kGrey70,
              ),
            ),
          ),
          const SizedBox(width: kSize8),
          Expanded(
            child: Text(
              title,
              style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey70),
              maxLines: _kMaxLines,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
