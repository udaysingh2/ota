import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/bloc/car_booking_detail_bloc.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view_model/car_booking_detail_view_model.dart';

import 'car_details_view_controller.dart';

const String _kUpArrowIcon = "assets/images/icons/arrow_up.svg";
const String _kDownArrowIcon = "assets/images/icons/arrow_down.svg";
const int _kMaxLine = 1;
const String _kNoOfSeatIcon = 'assets/images/icons/users_alt.svg';
const String _kNoOfDoorsIcon = 'assets/images/icons/car_door_icon.svg';
const String _kAutomaticIcon = 'assets/images/icons/car_automatic_icon.svg';
const String _kNoOfBagsIcon = 'assets/images/icons/car_bag_icon.svg';
const String _kAotomaticType = 'A';
const String _kCarDetailViewlKey = "car_detail_view_key";

class CarDetailView extends StatelessWidget {
  final CarBookingDetailBloc carBookingDetailBloc;
  final CarDetailsViewController carDetailsViewController;

  const CarDetailView({
    Key? key,
    required this.carBookingDetailBloc,
    required this.carDetailsViewController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: carDetailsViewController,
      builder: () {
        return Column(
          children: [
            const OtaHorizontalDivider(
              dividerColor: AppColors.kGrey10,
            ),
            const SizedBox(height: kSize15),
            Row(
              children: [
                Expanded(
                  child: Text(
                    getTranslated(context, AppLocalizationsStrings.carDetails),
                    style: AppTheme.kBodyMedium,
                  ),
                ),
                OtaIconButton(
                  key: const Key(_kCarDetailViewlKey),
                  icon: SvgPicture.asset(
                    carDetailsViewController.isViewOpen
                        ? _kUpArrowIcon
                        : _kDownArrowIcon,
                  ),
                  onTap: () => carDetailsViewController.updateState(),
                )
              ],
            ),
            if (carDetailsViewController.isViewOpen) _getCarDetailList(context),
            SizedBox(
                height: carDetailsViewController.isViewOpen ? kSize8 : kSize15),
            const OtaHorizontalDivider(
              dividerColor: AppColors.kGrey10,
            ),
          ],
        );
      },
    );
  }

  Widget _getCarDetailList(BuildContext context) {
    CarModel? car =
        carBookingDetailBloc.state.bookingDetail?.carBookingDetails?.car;
    return Column(
      children: [
        _getCarDetailListItem(
          context: context,
          icon: _kNoOfSeatIcon,
          title: (car?.seatNbr ?? '') +
              getTranslated(context, AppLocalizationsStrings.carRentalOnlySeats)
                  .addLeadingSpace(),
        ),
        _getCarDetailListItem(
          context: context,
          icon: _kNoOfDoorsIcon,
          title: (car?.doorNbr ?? '') +
              getTranslated(context, AppLocalizationsStrings.doors)
                  .addLeadingSpace(),
        ),
        if (car?.bagLargeNbr != "0")
          _getCarDetailListItem(
            context: context,
            icon: _kNoOfBagsIcon,
            title: getTranslated(context, AppLocalizationsStrings.bagsOnly) +
                (car?.bagLargeNbr ?? '') +
                getTranslated(
                        context, AppLocalizationsStrings.carRentalOnlyBags)
                    .addLeadingSpace(),
          ),
        _getCarDetailListItem(
          context: context,
          icon: _kAutomaticIcon,
          title: getTranslated(
              context,
              (car?.gear ?? '') == _kAotomaticType
                  ? AppLocalizationsStrings.automatic
                  : AppLocalizationsStrings.manual),
        ),
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
}
