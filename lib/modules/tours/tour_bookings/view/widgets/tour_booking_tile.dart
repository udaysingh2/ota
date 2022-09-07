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
import 'package:ota/modules/tours/tour_bookings/view_model/tour_booking_view_model.dart';

const _kTourSuggestionIcon = 'assets/images/icons/tour_icon.svg';
const _kTicketSuggestionIcon = 'assets/images/icons/ticket_icon.svg';
const _maxLines = 1;
const _kTourKey = "TOUR";

class TourBookingTile extends StatelessWidget {
  final TourBookingViewModel tourBookings;
  final Function()? onTap;
  const TourBookingTile({
    Key? key,
    required this.tourBookings,
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
                _buildTourPlaceholder(),
                const SizedBox(width: kSize16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              tourBookings.tourName,
                              style: AppTheme.kBodyMedium,
                              maxLines: _maxLines,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: kSize4),
                          Text(
                            currencyUtil
                                .getFormattedPrice(tourBookings.tourTotalPrice),
                            style: AppTheme.kSmallRegular
                                .copyWith(color: AppColors.kGrey50),
                            maxLines: _maxLines,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: kSize4),
                      Text(
                        '${_getTourBookingDateText()}, ${tourBookings.startTimeAMPM}',
                        style: AppTheme.kSmallRegular.copyWith(
                          color: AppColors.kGrey50,
                        ),
                        maxLines: _maxLines,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (tourBookings.bookingId.isNotEmpty)
                        const SizedBox(height: kSize4),
                      if (tourBookings.bookingId.isNotEmpty)
                        Text(
                          '${getTranslated(
                            context,
                            AppLocalizationsStrings.reservationId,
                          )} : ${tourBookings.bookingId}',
                          style: AppTheme.kSmallRegular,
                        ),
                      const SizedBox(height: kSize4),
                      _buildStatusText(context),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: kSize16),
            const OtaHorizontalDivider(
              dividerColor: AppColors.kGrey10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusText(BuildContext context) {
    String status = _getStatusText(context);
    return status.isEmpty
        ? const SizedBox.shrink()
        : Text(
            status,
            style: AppTheme.kSmallRegular.copyWith(
              color: AppColors.kSecondary,
            ),
          );
  }

  String _getStatusText(BuildContext context) {
    switch (tourBookings.tourBookingStatus) {
      case TourBookingStatus.bookingCompleted:
        return getTranslated(context, AppLocalizationsStrings.completedLabel);
      case TourBookingStatus.bookingConfirmed:
        return getTranslated(
            context, AppLocalizationsStrings.tourBookingConfirm);
      case TourBookingStatus.bookingCancelled:
        return getTranslated(context, AppLocalizationsStrings.canceledLabel);
      case TourBookingStatus.paymentPending:
        return getTranslated(
            context, AppLocalizationsStrings.activityPaymentPending);
      case TourBookingStatus.cancellationPending:
        return getTranslated(
            context, AppLocalizationsStrings.activityAwaitingCancellation);
      case TourBookingStatus.bookingPending:
        return getTranslated(
            context, AppLocalizationsStrings.activityAwaitingConfirmation);
      case TourBookingStatus.unsuccessfulReservation:
        return getTranslated(
            context, AppLocalizationsStrings.unsuccessfulReservation);
      case TourBookingStatus.unsuccessfulPayment:
        return getTranslated(
            context, AppLocalizationsStrings.tourBookingUnsuccessfulPayment);
      default:
        return '';
    }
  }

  String _getTourBookingDateText() {
    return Helpers.getddMMMyyyy(tourBookings.tourBookingDate);
  }

  Widget _buildTourPlaceholder() {
    return Container(
      width: kSize40,
      height: kSize40,
      decoration: const BoxDecoration(
        color: AppColors.kGrey4,
        borderRadius: BorderRadius.all(Radius.circular(kSize8)),
      ),
      child: Center(
        child: SvgPicture.asset(
          tourBookings.productType == _kTourKey
              ? _kTourSuggestionIcon
              : _kTicketSuggestionIcon,
          height: kSize20,
          width: kSize20,
          color: AppColors.kSecondary,
        ),
      ),
    );
  }
}
