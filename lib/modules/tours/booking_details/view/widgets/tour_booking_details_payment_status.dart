import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_booking_details_wallet_widget/ota_wallet_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';
import 'package:ota/modules/ota_common/helper/ota_service_enabled_helper.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/promo_code_view_model.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_detail_payment_list.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_booking_details_gradient_text_with_svg.dart';
import 'package:ota/modules/tours/booking_details/view/widgets/tour_payment_card_item.dart';
import 'package:ota/modules/tours/booking_details/view_model/tour_booking_details_view_model.dart';

class TourBookingDetailsPaymentStatus extends StatelessWidget {
  final String paymentStatus;
  final double netPrice;
  final double totalPrice;
  final double discount;
  final PaymentMethodType? paymentType;
  final String? cardNickname;
  final String? cardNo;
  final TourAndTicketBookingStatus status;
  final PromoCodeData? appliedPromo;
  final bool isTour;
  final bool isWalletAvailable;
  final String? walletAmount;
  final String? walletName;
  final bool isCardAvailable;

  const TourBookingDetailsPaymentStatus({
    Key? key,
    required this.paymentStatus,
    required this.netPrice,
    required this.totalPrice,
    required this.discount,
    this.paymentType,
    this.cardNickname,
    this.cardNo,
    this.appliedPromo,
    required this.status,
    required this.isTour,
    this.isWalletAvailable = false,
    this.isCardAvailable = false,
    this.walletAmount,
    this.walletName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kSize16),
        Text(
          getTranslated(context, AppLocalizationsStrings.paymentDetails),
          style: AppTheme.kHeading1Medium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: kSize16),
        if (status == TourAndTicketBookingStatus.unsuccessfulPayment)
          Text(
              getTranslated(context,
                  AppLocalizationsStrings.tourBookingUnsuccessfulPayment),
              style:
                  AppTheme.kBodyMedium.copyWith(color: AppColors.kSystemWrong)),
        if (status != TourAndTicketBookingStatus.unsuccessfulPayment)
          TourBookingDetailsWithGradient(gradientText: paymentStatus),
        const SizedBox(height: kSize16),
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        TourBookingDetailPaymentList(
          netPrice: netPrice,
          grandTotal: totalPrice,
          discountAmount: discount,
          appliedPromo: appliedPromo,
          isTour: isTour,
          isWalletAvailable: isWalletAvailable,
          walletAmount: walletAmount,
        ),
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        const SizedBox(height: kSize16),
        Container(
          color: AppColors.kLight100,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  getTranslated(
                    context,
                    AppLocalizationsStrings.activityTicketPaymentMethod,
                  ),
                  style: AppTheme.kBodyMedium
                      .copyWith(color: AppColors.kBlackColor),
                ),
              ),
              isWalletAvailable && OtaServiceEnabledHelper.isWalletEnabled()
                  ? OtaWalletWidget(
                      padding: const EdgeInsets.only(top: kSize16),
                      walletTitle: walletName,
                    )
                  : const SizedBox.shrink(),
              if (isCardAvailable)
                TourPaymentCardItem(
                  cardName: cardNickname,
                  cardNumber: cardNo ?? '',
                  paymentType: paymentType,
                  padding: const EdgeInsets.symmetric(vertical: kSize16),
                ),
              const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
            ],
          ),
        ),
      ],
    );
  }
}
