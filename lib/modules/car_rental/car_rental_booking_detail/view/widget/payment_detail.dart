import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/core_pack/custom_widgets/ota_booking_details_wallet_widget/ota_pay_with_wallet_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_booking_details_wallet_widget/ota_wallet_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/view/ota_promo_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/bloc/car_booking_detail_bloc.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view_model/car_booking_detail_view_model.dart';
import 'package:ota/modules/ota_common/helper/ota_service_enabled_helper.dart';

const _kIconUnionPay = 'assets/images/icons/icon_union.svg';
const _kIconScb = 'assets/images/icons/icon_scb.png';
const _kIconVisa = 'assets/images/icons/icon_visa.svg';
const _kIconJcb = 'assets/images/icons/icon_jcb.png';
const _kIconMastercard = 'assets/images/icons/icon_mastercard.svg';
const _kPlaceholder = 'assets/images/icons/addon_service_placeholder.svg';
const int _kMaxLine = 1;

class PaymentDetail extends StatelessWidget {
  final CarBookingDetailBloc carBookingDetailBloc;

  const PaymentDetail({
    Key? key,
    required this.carBookingDetailBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CarBookingDetailModel? carBookingDetails =
        carBookingDetailBloc.state.bookingDetail?.carBookingDetails;
    double extrasCounterPrice = carBookingDetails?.extrasCounterPrice ?? 0;
    double extrasOnlinePrice = carBookingDetails?.extrasOnlinePrice ?? 0;
    double totalPayablePrice = carBookingDetails?.totalPayablePrice ?? 0;
    double totalPrice = carBookingDetails?.totalPrice ?? 0;
    PaymentDetailsModel? walletPaymentModel =
        carBookingDetailBloc.getWalletPaymentMethod();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OtaHorizontalDivider(
          dividerColor: AppColors.kGrey10,
        ),
        const SizedBox(height: kSize24),
        Text(
          getTranslated(context, AppLocalizationsStrings.paymentDetails),
          style: AppTheme.kHeading1Medium,
        ),
        const SizedBox(height: kSize16),
        carBookingDetailBloc.isPaymentFailed
            ? Text(
                getTranslated(
                    context, AppLocalizationsStrings.unsuccessfulPayment),
                style: AppTheme.kBodyMedium
                    .copyWith(color: AppColors.kSystemWrong),
              )
            : _getSuccessPaymentStatus(context),
        const SizedBox(height: kSize16),
        const OtaHorizontalDivider(
          dividerColor: AppColors.kGrey10,
        ),
        const SizedBox(height: kSize16),
        _getServiceOption(
          title: getTranslated(context, AppLocalizationsStrings.carRentalFee),
          price: carBookingDetails?.netPrice ?? 0,
        ),
        if (carBookingDetailBloc.state.bookingDetail?.carBookingDetails!
                    .returnExtraCharge !=
                null &&
            carBookingDetailBloc.state.bookingDetail!.carBookingDetails!
                    .returnExtraCharge! >
                0)
          _getExtraChargeView(context, carBookingDetails),
        SizedBox(
          height: (extrasOnlinePrice <= 0 && extrasCounterPrice <= 0)
              ? kSize16
              : kSize8,
        ),
        if (extrasOnlinePrice > 0)
          Padding(
            padding: const EdgeInsets.only(bottom: kSize16),
            child: _getServiceOption(
              title: getTranslated(
                  context, AppLocalizationsStrings.carAdditionalServices),
              price: carBookingDetails?.extrasOnlinePrice ?? 0,
              subtitle:
                  '(${getTranslated(context, AppLocalizationsStrings.payOnlineNow)})',
            ),
          ),
        if (extrasCounterPrice > 0)
          Padding(
            padding: const EdgeInsets.only(bottom: kSize16),
            child: _getServiceOption(
              title: getTranslated(
                  context, AppLocalizationsStrings.carAdditionalServices),
              price: carBookingDetails?.extrasCounterPrice ?? 0,
              subtitle:
                  '(${getTranslated(context, AppLocalizationsStrings.payAtPickupPoint)})',
            ),
          ),
        const OtaHorizontalDivider(
          dividerColor: AppColors.kGrey10,
        ),
        const SizedBox(height: kSize16),
        _getServiceOption(
          title: getTranslated(context, AppLocalizationsStrings.subtotal),
          price: totalPrice,
        ),
        if (carBookingDetailBloc.state.bookingDetail?.appliedPromo != null)
          const SizedBox(height: kSize8),
        if (carBookingDetailBloc.state.bookingDetail?.appliedPromo != null)
          OtaPromoWidget(
            isPromoApplied: true,
            promoCode: carBookingDetailBloc.state.bookingDetail!.appliedPromo!,
          ),
        if (walletPaymentModel != null &&
            OtaServiceEnabledHelper.isWalletEnabled())
          OtaPayWithWalletWidget(
            walletPrice:
                double.tryParse(walletPaymentModel.amount ?? '0') ?? 0.00,
          ),
        const SizedBox(height: kSize12),
        const OtaHorizontalDivider(
          dividerColor: AppColors.kGrey10,
        ),
        const SizedBox(height: kSize16),
        _getTotalServiceOption(
          title: getTranslated(context, AppLocalizationsStrings.paymentTotal),
          price: (carBookingDetails?.grandTotal ?? 0),
          subtitle:
              getTranslated(context, AppLocalizationsStrings.includeVatAndFees),
          style: AppTheme.kBodyMedium,
        ),
        const SizedBox(height: kSize16),
        if (extrasCounterPrice > 0 && totalPayablePrice > 0)
          Padding(
            padding: const EdgeInsets.only(bottom: kSize16),
            child: _getServiceOption(
              title:
                  getTranslated(context, AppLocalizationsStrings.payOnlineNow),
              price: totalPayablePrice,
              style: AppTheme.kBodyMedium,
            ),
          ),
        if (extrasCounterPrice > 0 && totalPayablePrice > 0)
          Padding(
            padding: const EdgeInsets.only(bottom: kSize16),
            child: _getServiceOption(
              title: getTranslated(
                  context, AppLocalizationsStrings.payAtPickupPoint),
              price: extrasCounterPrice,
              style: AppTheme.kBodyMedium,
            ),
          ),
        const OtaHorizontalDivider(
          dividerColor: AppColors.kGrey10,
        ),
        const SizedBox(height: kSize16),
        Text(
          getTranslated(context, AppLocalizationsStrings.paymentMethod),
          style: AppTheme.kBodyMedium,
        ),
        const SizedBox(height: kSize16),
        walletPaymentModel != null && OtaServiceEnabledHelper.isWalletEnabled()
            ? OtaWalletWidget(
                padding: const EdgeInsets.only(bottom: kSize16),
                walletTitle: walletPaymentModel.name,
              )
            : const SizedBox.shrink(),
        if (carBookingDetailBloc.getPaymentMethod() != null)
          _getPaymentMethod(context),
        const SizedBox(height: kSize16),
      ],
    );
  }

  Widget _getServiceOption({
    required String title,
    required double price,
    String subtitle = '',
    TextStyle style = AppTheme.kBodyRegular,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: style,
              maxLines: _kMaxLine,
            ),
            const SizedBox(width: kSize20),
            Expanded(
              child: Text(
                CurrencyUtil().getFormattedPrice(price),
                style: AppTheme.kBodyMedium,
                textAlign: TextAlign.end,
                maxLines: _kMaxLine,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        if (subtitle.isNotEmpty)
          Text(
            subtitle,
            style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
            maxLines: _kMaxLine,
          ),
      ],
    );
  }

  Widget _getTotalServiceOption({
    required String title,
    required double price,
    String subtitle = '',
    TextStyle style = AppTheme.kBodyRegular,
  }) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: style,
              maxLines: _kMaxLine,
            ),
            if (subtitle.isNotEmpty)
              Text(
                subtitle,
                style:
                    AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
                maxLines: _kMaxLine,
              ),
          ],
        ),
        const SizedBox(width: kSize20),
        Expanded(
          child: Text(
            CurrencyUtil().getFormattedPrice(price),
            style: AppTheme.kBodyMedium,
            textAlign: TextAlign.end,
            maxLines: _kMaxLine,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _getSuccessPaymentStatus(BuildContext context) {
    return Material(
      child: Row(
        children: [
          Ink(
            height: kSize20,
            width: kSize20,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.kPurpleGradient,
            ),
            child: const Icon(
              Icons.check,
              color: AppColors.kLight100,
              size: kSize14,
            ),
          ),
          const SizedBox(width: kSize12),
          Text(
            getTranslated(context, AppLocalizationsStrings.paymentStatus),
            style: AppTheme.kBodyMedium.copyWith(color: AppColors.kSecondary),
          ),
        ],
      ),
    );
  }

  Widget _getPaymentMethod(BuildContext context) {
    CarPaymentMethodType cardType =
        carBookingDetailBloc.getPaymentMethod()?.cardType ??
            CarPaymentMethodType.unknown;
    String? cardNo = carBookingDetailBloc.getPaymentMethod()?.cardNo ?? '';

    return Row(
      children: [
        _getPaymentTypeImage(cardType),
        const SizedBox(width: kSize8),
        Text(
          cardType == CarPaymentMethodType.scb
              ? getTranslated(context, AppLocalizationsStrings.scbEasyApp)
              : carBookingDetailBloc.getPaymentMethod()?.cardNickName ?? '',
          style: AppTheme.kBodyRegular,
        ),
        if (cardType != CarPaymentMethodType.scb && cardNo.isNotEmpty)
          Expanded(
            child: Text(
              carBookingDetailBloc.getPaymentMethod()?.cardNo ?? "",
              style: AppTheme.kBodyRegular,
              textAlign: TextAlign.end,
            ),
          ),
      ],
    );
  }

  Widget _getPaymentTypeImage(CarPaymentMethodType cardType) {
    switch (cardType) {
      case CarPaymentMethodType.visa:
        return SvgPicture.asset(
          _kIconVisa,
          height: kSize10,
          width: kSize32,
        );
      case CarPaymentMethodType.master:
        return SvgPicture.asset(
          _kIconMastercard,
          height: kSize10,
          width: kSize32,
        );

      case CarPaymentMethodType.jcb:
        return Image.asset(
          _kIconJcb,
          fit: BoxFit.fitWidth,
          height: kSize14,
        );
      case CarPaymentMethodType.scb:
        return Image.asset(
          _kIconScb,
          height: kSize24,
          width: kSize24,
        );
      case CarPaymentMethodType.unionpay:
        return SvgPicture.asset(
          _kIconUnionPay,
          fit: BoxFit.fitWidth,
          height: kSize14,
        );
      default:
        return SvgPicture.asset(
          _kPlaceholder,
          height: kSize10,
          width: kSize32,
        );
    }
  }

  _getExtraChargeView(
      BuildContext context, CarBookingDetailModel? carBookingDetails) {
    return Column(
      children: [
        const SizedBox(height: kSize8),
        _getServiceOption(
          title: getTranslated(
              context, AppLocalizationsStrings.returnTheCarToDifferentPlace),
          price: carBookingDetails?.returnExtraCharge ?? 0,
        ),
      ],
    );
  }
}
