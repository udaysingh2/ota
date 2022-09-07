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
import 'package:ota/modules/hotel/hotel_booking_details/view_model/hotel_booking_details_view_model.dart';
import 'package:ota/modules/hotel/hotel_bookings/view_model/hotel_bookings_view_model.dart';

const _kHotelSuggestionIcon = 'assets/images/icons/hotel_suggestion.svg';
const _maxLines = 1;

class HotelBookingTile extends StatelessWidget {
  final HotelBookingsViewModel hotelBookings;
  final Function()? onTap;

  const HotelBookingTile({
    Key? key,
    required this.hotelBookings,
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
                _buildHotelPlaceholder(),
                const SizedBox(width: kSize16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              hotelBookings.hotelName,
                              style: AppTheme.kBodyMedium,
                              maxLines: _maxLines,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: kSize16),
                          Text(
                            currencyUtil
                                .getFormattedPrice(hotelBookings.totalPrice),
                            style: AppTheme.kSmallRegular.copyWith(
                              color: AppColors.kGrey50,
                            ),
                            maxLines: _maxLines,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: kSize4),
                      Text(
                        _getCheckInOutPeriodText(),
                        style: AppTheme.kSmallRegular,
                        maxLines: _maxLines,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (hotelBookings.bookingId.trim().isNotEmpty &&
                          _isReservationIdHide())
                        const SizedBox(height: kSize4),
                      if (hotelBookings.bookingId.trim().isNotEmpty &&
                          _isReservationIdHide())
                        Text(
                          '${getTranslated(
                            context,
                            AppLocalizationsStrings.reservationNo,
                          )} : ${hotelBookings.bookingId}',
                          style: AppTheme.kSmallRegular.copyWith(
                            color: AppColors.kGrey50,
                          ),
                        ),
                      _buildStatusText(context),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: kSize17),
            const OtaHorizontalDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusText(BuildContext context) {
    String status = _getStatusText();
    return status.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(top: kSize4),
            child: Text(
              getTranslated(context, status),
              style: AppTheme.kSmallRegular.copyWith(
                color: AppColors.kSecondary,
              ),
            ),
          );
  }

  bool _isReservationIdHide() =>
      !(hotelBookings.activityStatus == ActivityStatus.hotelRejected ||
          hotelBookings.activityStatus == ActivityStatus.paymentPending ||
          hotelBookings.activityStatus == ActivityStatus.awaitingConfirmation);

  String _getStatusText() {
    switch (hotelBookings.activityStatus) {
      case ActivityStatus.bookingSuccess:
        return AppLocalizationsStrings.activitySuccess;
      case ActivityStatus.completed:
        return AppLocalizationsStrings.completedLabel;
      case ActivityStatus.hotelRejected:
        return AppLocalizationsStrings.activityHotelRejected;
      case ActivityStatus.paymentFailed:
        return AppLocalizationsStrings.activityPaymentFailed;
      case ActivityStatus.userCancelled:
        return AppLocalizationsStrings.activityUserCancelled;
      case ActivityStatus.paymentPending:
        return AppLocalizationsStrings.activityPaymentPending;
      case ActivityStatus.awaitingConfirmation:
        return AppLocalizationsStrings.activityAwaitingConfirmation;
      case ActivityStatus.awaitingCancellation:
        return AppLocalizationsStrings.activityAwaitingCancellation;
      default:
        return '';
    }
  }

  String _getCheckInOutPeriodText() {
    return '${Helpers.getddMMMyyyy(hotelBookings.checkInDate)} - ${Helpers.getddMMMyyyy(hotelBookings.checkOutDate)}';
  }

  Widget _buildHotelPlaceholder() {
    return Container(
      width: kSize40,
      height: kSize40,
      decoration: const BoxDecoration(
        color: AppColors.kGrey4,
        borderRadius: BorderRadius.all(Radius.circular(kSize8)),
      ),
      child: Center(
        child: SvgPicture.asset(
          _kHotelSuggestionIcon,
          height: kSize20,
          width: kSize20,
          color: AppColors.kSecondary,
        ),
      ),
    );
  }
}
