import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_booking_list/view_model/car_booking_list_view_model.dart';

const _kCarSuggestionIcon = 'assets/images/icons/car_suggestion.svg';

const _maxLines = 1;

class CarBookingListTile extends StatelessWidget {
  final CarBookingViewModel carBookings;
  final Function()? onTap;
  const CarBookingListTile({
    Key? key,
    required this.carBookings,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CurrencyUtil currencyUtil = CurrencyUtil(decimalDigits: 2);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(
            left: kSize24, right: kSize24, bottom: kSize16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCarPlaceholder(),
                const SizedBox(width: kSize16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              carBookings.carName,
                              style: AppTheme.kHBody,
                              maxLines: _maxLines,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: kSize16),
                          Text(
                            currencyUtil
                                .getFormattedPrice(carBookings.carTotalPrice),
                            style: AppTheme.kSmall1,
                            maxLines: _maxLines,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: kSize4),
                      Text(
                        carBookings.carSupplierName,
                        style: AppTheme.kSmallRegular,
                        maxLines: _maxLines,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: kSize4),
                      Text(
                        _getCarBookingDateText(),
                        style: AppTheme.kSmall1.copyWith(
                          color: AppColors.kGrey70,
                        ),
                        maxLines: _maxLines,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (carBookings.bookingId.isNotEmpty &&
                          (carBookings.bookingStatus ==
                                  CarBookingListStatus.confirmed ||
                              carBookings.bookingStatus ==
                                  CarBookingListStatus.awatingCancellation ||
                              carBookings.bookingStatus ==
                                  CarBookingListStatus.completed ||
                              carBookings.bookingStatus ==
                                  CarBookingListStatus.cancelled))
                        Padding(
                          padding: const EdgeInsets.only(top: kSize4),
                          child: Text(
                            '${getTranslated(
                              context,
                              AppLocalizationsStrings.reservationId,
                            )} : ${carBookings.bookingId}',
                            style: AppTheme.kSmall1,
                          ),
                        ),
                      const SizedBox(height: kSize4),
                      _buildStatusText(context),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: kSize17),
            const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusText(BuildContext context) {
    String status = carBookings.carBookingStatus;
    return status.isEmpty
        ? const SizedBox.shrink()
        : Text(
            status,
            style: AppTheme.kSmall1.copyWith(
              color: AppColors.kSecondary,
            ),
          );
  }

  String _getCarBookingDateText() {
    return '${Helpers.getddMMMyyyy(carBookings.pickupDateTime)}, ${Helpers.gethhmm(carBookings.pickupDateTime)} - ${Helpers.getddMMMyyyy(carBookings.returnDateTime)}, ${Helpers.gethhmm(carBookings.returnDateTime)}';
  }

  Widget _buildCarPlaceholder() {
    return Container(
      width: kSize40,
      height: kSize40,
      decoration: const BoxDecoration(
        color: AppColors.kGrey4,
        borderRadius: BorderRadius.all(Radius.circular(kSize8)),
      ),
      child: Center(
        child: SvgPicture.asset(
          _kCarSuggestionIcon,
          height: kSize20,
          width: kSize20,
        ),
      ),
    );
  }
}
