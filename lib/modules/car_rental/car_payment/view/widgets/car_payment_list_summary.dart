import 'package:flutter/material.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/bloc/promo_widget_bloc.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/view/ota_promo_widget.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/view_model/promo_widget_view_model.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/ota_common/helper/ota_service_enabled_helper.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/promo_code_view_model.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promotion_argument.dart';

import '../../../../../core_pack/custom_widgets/ota_virtual_wallet/bloc/virtual_payment_bloc.dart';
import '../../../../../core_pack/custom_widgets/ota_virtual_wallet/view/ota_virtual_wallet_widget.dart';

const int _kMaxLines = 1;
bool isAddPromoTapped = false;
bool isRemovePromoTapped = false;

class CarPaymentListSummery extends StatelessWidget {
  final bool showDivider;
  final double carRental;
  final double additionalServicePayOnline;
  final double additionalServicePayAtPickUpPoint;
  final double subTotalPrice;
  final double discountAmount;
  final double grandTotal;
  final double payOnline;
  final double payPickUpPoint;
  final CurrencyUtil _currencyUtil = CurrencyUtil();
  final String? pickupPoint;
  final String? dropOffPoint;
  final double? returnExtraCharge;
  final PromoWidgetBloc promoBloc;
  final String bookingUrn;
  final String mechantId;
  final Function(double)? updateDiscount;
  final VirtualPaymentBloc virtualPaymentBloc;
  final double walletAmountTobeDeducted;
  final double grandTotalWithWalletAmount;

  CarPaymentListSummery({
    Key? key,
    this.showDivider = true,
    required this.discountAmount,
    required this.grandTotal,
    required this.subTotalPrice,
    required this.additionalServicePayOnline,
    required this.additionalServicePayAtPickUpPoint,
    required this.carRental,
    required this.payOnline,
    required this.payPickUpPoint,
    required this.bookingUrn,
    required this.promoBloc,
    required this.mechantId,
    this.updateDiscount,
    required this.pickupPoint,
    required this.dropOffPoint,
    required this.returnExtraCharge,
    required this.virtualPaymentBloc,
    required this.walletAmountTobeDeducted,
    required this.grandTotalWithWalletAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kSize24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: kSize10,
                ),
                _getGuestName(
                    context,
                    AppLocalizationsStrings.carRentalFee,
                    _currencyUtil.getFormattedPrice(
                        carRental - returnExtraCharge!.toInt())),
                if (returnExtraCharge! > 0)
                  _getExtraChargeView(
                      context,
                      getTranslated(context,
                          AppLocalizationsStrings.returnTheCarToDifferentPlace),
                      _currencyUtil
                          .getFormattedPrice(returnExtraCharge ?? 0.0)),
                const SizedBox(
                  height: kSize10,
                ),
                if (additionalServicePayOnline > 0)
                  _getAdditionalServices(
                      context,
                      AppLocalizationsStrings.additionalService,
                      ("(${getTranslated(context, AppLocalizationsStrings.payOnlineNow)})"),
                      _currencyUtil
                          .getFormattedPrice(additionalServicePayOnline)),
                if (additionalServicePayOnline > 0)
                  const SizedBox(
                    height: kSize10,
                  ),
                if (additionalServicePayAtPickUpPoint > 0)
                  _getAdditionalServices(
                      context,
                      AppLocalizationsStrings.additionalService,
                      ("(${getTranslated(context, AppLocalizationsStrings.payAtPickupPoint)})"),
                      _currencyUtil.getFormattedPrice(
                          additionalServicePayAtPickUpPoint)),
                if (additionalServicePayAtPickUpPoint > 0)
                  const SizedBox(
                    height: kSize14,
                  ),
                const OtaHorizontalDivider(
                  dividerColor: AppColors.kGrey10,
                  height: 1,
                ),
                const SizedBox(
                  height: kSize14,
                ),
                _getGuestName(context, AppLocalizationsStrings.subtotal,
                    _currencyUtil.getFormattedPrice(subTotalPrice)),
                const SizedBox(
                  height: kSize10,
                ),
                BlocBuilder(
                    bloc: promoBloc,
                    builder: () {
                      return OtaPromoWidget(
                          promoCode: promoBloc.state.data,
                          isPromoApplied: promoBloc.state.promoState ==
                              PromoWidgetState.appliedPromo,
                          onAddPromo: () async {
                            if (!isAddPromoTapped) {
                              isAddPromoTapped = true;
                              await _isInternetConnected()
                                  ? _navigateToPromoSearchScreen(context)
                                  : _showNoInternetAlert(context);
                            }
                          },
                          onRemovePromo: () async {
                            if (!isRemovePromoTapped) {
                              isRemovePromoTapped = true;
                              await _isInternetConnected()
                                  ? _navigateToPromoCodeDetailScreen(context)
                                  : _showNoInternetAlert(context);
                            }
                          });
                    }),
                const SizedBox(height: kSize14),
                if (OtaServiceEnabledHelper.isWalletEnabled())
                  BlocBuilder(
                      bloc: virtualPaymentBloc,
                      builder: () {
                        return OtaVirtualWalletWidget(
                          virtualPaymentBloc: virtualPaymentBloc,
                          amountToBeDeducted: walletAmountTobeDeducted,
                          paymentModel: virtualPaymentBloc.state,
                        );
                      }),
                if (OtaServiceEnabledHelper.isWalletEnabled())
                  const SizedBox(height: kSize14),
                const OtaHorizontalDivider(
                  dividerColor: AppColors.kGrey10,
                  height: kSize1,
                ),
                const SizedBox(height: kSize14),
                BlocBuilder(
                    bloc: promoBloc,
                    builder: () {
                      return _getTotalName(
                          context,
                          AppLocalizationsStrings.paymentTotal,
                          AppLocalizationsStrings.includeVatAndFees,
                          _currencyUtil
                              .getFormattedPrice(grandTotalWithWalletAmount));
                    }),
                const SizedBox(
                  height: kSize10,
                ),
                if (payPickUpPoint > 0)
                  _getPayOnline(context, AppLocalizationsStrings.payOnlineNow,
                      _currencyUtil.getFormattedPrice(payOnline)),
                if (payPickUpPoint > 0)
                  const SizedBox(
                    height: kSize10,
                  ),
                if (payPickUpPoint > 0)
                  _getPayOnline(
                      context,
                      AppLocalizationsStrings.payAtPickupPoint,
                      _currencyUtil.getFormattedPrice(payPickUpPoint)),
              ],
            ),
            const SizedBox(
              height: kSize16,
            ),
            if (showDivider)
              const OtaHorizontalDivider(
                dividerColor: AppColors.kGrey10,
                height: 1,
              ),
          ],
        ),
      ),
    );
  }

  // double getGrandTotalValue(double value) {
  //   if (virtualPaymentBloc.state.walletState == WalletState.on) {
  //     return value - walletAmountTobeDeducted;
  //   } else {
  //     return value;
  //   }
  // }

  _navigateToPromoSearchScreen(BuildContext context) async {
    var appliedPromo = await Navigator.of(context).pushNamed(
      AppRoutes.promoCodeSearchScreen,
      arguments: PublicPromotionArgument(
        applicationKey: OtaServiceType.carRental,
        bookingUrn: bookingUrn,
        merchantId: mechantId,
      ),
    );
    isAddPromoTapped = false;
    if (appliedPromo is PromoCodeData && appliedPromo.isPromotionApplied) {
      promoBloc.emitAppliedPromoData(appliedPromo);
      if (updateDiscount != null) {
        updateDiscount!(appliedPromo.priceViewModel!.effectiveDiscount);
      }
    }
  }

  void _navigateToPromoCodeDetailScreen(BuildContext context) async {
    var response = await Navigator.pushNamed(
        context, AppRoutes.promoDetailScreen,
        arguments: promoBloc.state.data);
    isRemovePromoTapped = false;
    if (response is PromoCodeData && !response.isPromotionApplied) {
      promoBloc.removePromodata();
      if (updateDiscount != null) {
        updateDiscount!(response.priceViewModel!.effectiveDiscount);
      }
    }
  }

  Widget _getTotalName(
    BuildContext context,
    String topText,
    String bottomText,
    String totalText,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated(context, topText),
                style: AppTheme.kBodyMedium,
              ),
              Text(getTranslated(context, bottomText),
                  style: AppTheme.kSmallRegular.copyWith(
                    color: AppColors.kGrey50,
                  )),
            ],
          ),
        ),
        OtaGradientText(
          gradientText: totalText,
          gradientTextStyle: AppTheme.kHeading1Medium
            ..copyWith(color: AppColors.kSecondary),
        ),
      ],
    );
  }

  Widget _getAdditionalServices(
    BuildContext context,
    String topText,
    String bottomText,
    String totalText,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated(context, topText),
                style: AppTheme.kBodyMedium,
              ),
              Text(getTranslated(context, bottomText),
                  style: AppTheme.kSmallRegular.copyWith(
                    color: AppColors.kGrey50,
                  )),
            ],
          ),
        ),
        Text(totalText, style: AppTheme.kBodyMedium),
      ],
    );
  }

  Widget _getGuestName(
      BuildContext context, String leftText, String rightText) {
    return Row(
      children: [
        Expanded(
            child: Text(
          getTranslated(context, leftText),
          style: AppTheme.kBodyRegular,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        )),
        Text(rightText, style: AppTheme.kBodyMedium),
      ],
    );
  }

  Widget _getPayOnline(
      BuildContext context, String leftText, String rightText) {
    return Row(
      children: [
        Expanded(
            child: Text(
          getTranslated(context, leftText),
          style: AppTheme.kBodyMedium,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        )),
        Text(rightText, style: AppTheme.kBodyMedium),
      ],
    );
  }

  Widget _getExtraChargeView(
      BuildContext context, String leftText, String rightText) {
    return Column(
      children: [
        const SizedBox(
          height: kSize10,
        ),
        Row(
          children: [
            Expanded(
                child: Text(
              getTranslated(context, leftText),
              style: AppTheme.kBodyRegular,
              maxLines: _kMaxLines,
              overflow: TextOverflow.ellipsis,
            )),
            Text(rightText, style: AppTheme.kBodyMedium),
          ],
        )
      ],
    );
  }

  Future<bool> _isInternetConnected() async {
    InternetConnectionInfo internetConnectionInfo =
        InternetConnectionInfoImpl();
    return await internetConnectionInfo.isConnected;
  }

  void _showNoInternetAlert(BuildContext context) {
    OtaNoInternetAlertDialog().showAlertDialog(context);
    isAddPromoTapped = false;
    isRemovePromoTapped = false;
  }
}
