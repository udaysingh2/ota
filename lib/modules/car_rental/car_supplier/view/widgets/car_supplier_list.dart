import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/common_widgets/car_rental_late_return_text_widget.dart';

const String _kRightArrow = 'assets/images/icons/arrow_right.svg';
const int _kMaxLine = 1;
const String _kNoOfSeatIcon = 'assets/images/icons/users_alt.svg';
const String _kNoOfDoorsIcon = 'assets/images/icons/car_door_icon.svg';
const String _kAutomaticIcon = 'assets/images/icons/car_automatic_icon.svg';
const String _kNoOfBagsIcon = 'assets/images/icons/car_bag_icon.svg';
const String _kAotomaticType = 'A';
const double kSize98 = 98;
const String supplierListArrowKey = 'supplierListArrowKey';

class CarSupplierList extends StatelessWidget {
  final Function()? onPress;
  final String noOfSeats;
  final String gear;
  final String noOfDoors;
  final String noOfLargeBag;
  final String noOfSmallBag;
  final String? imageUrl;
  final EdgeInsetsGeometry kPadding;
  final String carBrandName;
  final int allowLateReturn;

  const CarSupplierList({
    this.onPress,
    required this.noOfSeats,
    required this.gear,
    required this.noOfDoors,
    required this.noOfLargeBag,
    required this.noOfSmallBag,
    this.imageUrl,
    this.kPadding =
        const EdgeInsets.only(left: kSize24, right: kSize24, top: kSize24),
    required this.carBrandName,
    this.allowLateReturn = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPadding,
      child: Column(
        children: [
          Row(
            children: [
              if (imageUrl != null) _getImageCard(),
              if (imageUrl != null)
                const SizedBox(
                  width: kSize4,
                ),
              Expanded(
                child: Text(
                  carBrandName,
                  style: AppTheme.kBodyMedium,
                  maxLines: _kMaxLine,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: kSize8),
              GestureDetector(
                key: const Key(supplierListArrowKey),
                onTap: onPress,
                child: SvgPicture.asset(
                  _kRightArrow,
                  color: AppColors.kGrey70,
                ),
              ),
            ],
          ),
          const SizedBox(height: kSize16),
          _getCarDetailList(context),
          const SizedBox(height: kSize4),
        ],
      ),
    );
  }

  Widget _getCarDetailList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getCarDetailListItem(
          context: context,
          icon: _kNoOfSeatIcon,
          title: noOfSeats.toString() +
              getTranslated(context, AppLocalizationsStrings.carRentalOnlySeats)
                  .addLeadingSpace(),
        ),
        _getCarDetailListItem(
          context: context,
          icon: _kNoOfDoorsIcon,
          title: noOfDoors.toString() +
              getTranslated(context, AppLocalizationsStrings.doors)
                  .addLeadingSpace(),
        ),
        noOfLargeBag != "0"
            ? _getCarDetailListItem(
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
        _getCarDetailListItem(
          context: context,
          icon: _kAutomaticIcon,
          title: getTranslated(
              context,
              gear == _kAotomaticType
                  ? AppLocalizationsStrings.automatic
                  : AppLocalizationsStrings.manual),
        ),
        if (allowLateReturn >= 1)
          CarRentalLateReturnTextWidget(allowLateReturn: allowLateReturn),
      ],
    );
  }

  Widget _getCarDetailListItem({
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
              style: AppTheme.kSmallRegular,
              maxLines: _kMaxLine,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getImageCard() {
    return Container(
      width: 35,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(35 / 2)),
        border: Border.all(
          color: AppColors.kGrey10,
          width: 1.0,
        ),
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          errorWidget: (context, url, error) => const SizedBox(),
          placeholder: (context, url) => const SizedBox(),
        ),
      ),
    );
  }
}
