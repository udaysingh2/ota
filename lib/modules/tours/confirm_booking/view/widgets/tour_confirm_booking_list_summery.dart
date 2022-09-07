import 'package:flutter/material.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_no_internet_alert_dialog.dart';
import 'package:ota/core_pack/custom_widgets/ota_virtual_wallet/bloc/virtual_payment_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_virtual_wallet/view/ota_virtual_wallet_widget.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/bloc/promo_widget_bloc.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/view/ota_promo_widget.dart';
import 'package:ota/core_pack/custom_widgets/promo_widget/view_model/promo_widget_view_model.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/ota_common/helper/ota_service_enabled_helper.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/promo_code_view_model.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promotion_argument.dart';

const int _kMaxLines = 1;
const double _kBodyLineHeight = 1.25;
const double _kHeadLineHeight = 1.1;
const double _kDefaultHeight = 1;
const String _kTicketMultiplySign = 'x';
const int _kFlexLeft = 7;
const int _kFlexRight = 3;
bool isAddPromoTapped = false;
bool isRemovePromoTapped = false;

class TourConfirmBookingListSummery extends StatelessWidget {
  final double adultTourPrice;
  final double childTourPrice;
  final int adultCount;
  final int childCount;
  final double subTotal;
  final double discountAmount;
  final double grandTotal;
  final CurrencyUtil _currencyUtil = CurrencyUtil();
  final PromoWidgetBloc promoBloc;
  final String bookingUrn;
  final String merchantId;
  final Function(double)? updatedPromoDiscount;
  final VirtualPaymentBloc virtualPaymentBloc;
  final double walletAmountTobeDeducted;
  final double grandTotalWithWalletAmount;

  TourConfirmBookingListSummery({
    Key? key,
    required this.adultTourPrice,
    required this.childTourPrice,
    required this.adultCount,
    required this.childCount,
    required this.subTotal,
    required this.discountAmount,
    required this.grandTotal,
    this.updatedPromoDiscount,
    required this.promoBloc,
    required this.bookingUrn,
    required this.merchantId,
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
                  height: kSize16,
                ),
                _getTotalSelectedPrice(context, AppLocalizationsStrings.adults,
                    adultCount, adultTourPrice),
                if (childCount > 0)
                  const SizedBox(
                    height: kSize8,
                  ),
                if (childCount > 0)
                  _getTotalSelectedPrice(
                      context,
                      AppLocalizationsStrings.children,
                      childCount,
                      childTourPrice),
                const SizedBox(
                  height: kSize16,
                ),
                const OtaHorizontalDivider(
                  dividerColor: AppColors.kGrey10,
                  height: _kDefaultHeight,
                ),
                const SizedBox(
                  height: kSize16,
                ),
                _getRow(context, AppLocalizationsStrings.subtotal,
                    _currencyUtil.getFormattedPrice(subTotal)),
                const SizedBox(
                  height: kSize12,
                ),
                BlocBuilder(
                    bloc: promoBloc,
                    builder: () {
                      return OtaPromoWidget(
                          isPromoApplied: promoBloc.state.promoState ==
                              PromoWidgetState.appliedPromo,
                          promoCode: promoBloc.state.data,
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
                const SizedBox(height: kSize16),
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
                  const SizedBox(height: kSize16),
                const OtaHorizontalDivider(
                  dividerColor: AppColors.kGrey10,
                  height: _kDefaultHeight,
                ),
                const SizedBox(
                  height: kSize16,
                ),
                BlocBuilder(
                    bloc: virtualPaymentBloc,
                    builder: () {
                      return _getTotal(
                          context,
                          getTranslated(
                              context, AppLocalizationsStrings.totalPayment),
                          getTranslated(context,
                              AppLocalizationsStrings.includeVatAndFees),
                          grandTotalWithWalletAmount);
                    }),
              ],
            ),
            const SizedBox(
              height: kSize16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTotal(
    BuildContext context,
    String topText,
    String bottomText,
    double totalText,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(getTranslated(context, topText),
                  style: AppTheme.kBodyMedium),
              Text(
                getTranslated(context, bottomText),
                style:
                    AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
              ),
            ],
          ),
        ),
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return AppColors.gradient1.createShader(Offset.zero & bounds.size);
          },
          child: Text(
            _currencyUtil.getFormattedPrice((grandTotalWithWalletAmount)),
            style: AppTheme.kHeading1Medium.copyWith(
                color: AppColors.kTrueWhite, height: _kHeadLineHeight),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _getRow(BuildContext context, String leftText, String rightText) {
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

  /*
  * Created on 25 Jan 2022
  * Use this function to get the total price of particular selections.
  * selected tour type price * number of selection.
  * For Adult and For Child.
  * use flex int value to adjust the area acquired by the Expanded widget
  * in horizontal manner, as wrapped by Row parent widget.
  * here flex:7 acquires the 70% of the width.
  * flex:3 acquires the 30% of the width.
  * */

  Widget _getTotalSelectedPrice(
      BuildContext context, String name, int selectedCount, double price) {
    return Row(
      children: [
        Expanded(
          flex: _kFlexLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslated(context, name),
                style: AppTheme.kBodyRegular,
                maxLines: _kMaxLines,
                overflow: TextOverflow.ellipsis,
              ),
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return AppColors.gradient1
                      .createShader(Offset.zero & bounds.size);
                },
                child: Text(
                  _kTicketMultiplySign + selectedCount.toString(),
                  style: AppTheme.kBodyRegular.copyWith(
                      color: AppColors.kTrueWhite, height: _kBodyLineHeight),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: _kFlexRight,
          child: Text(
            _currencyUtil.getFormattedPrice(price * selectedCount),
            style: AppTheme.kBodyMedium,
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }

  _navigateToPromoSearchScreen(BuildContext context) async {
    var appliedPromo = await Navigator.of(context).pushNamed(
      AppRoutes.promoCodeSearchScreen,
      arguments: PublicPromotionArgument(
        applicationKey: OtaServiceType.tour,
        bookingUrn: bookingUrn,
        merchantId: merchantId,
      ),
    );
    isAddPromoTapped = false;
    if (appliedPromo is PromoCodeData && appliedPromo.isPromotionApplied) {
      promoBloc.emitAppliedPromoData(appliedPromo);
      if (updatedPromoDiscount != null) {
        updatedPromoDiscount!(appliedPromo.priceViewModel!.effectiveDiscount);
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
      if (updatedPromoDiscount != null) {
        updatedPromoDiscount!(response.priceViewModel!.effectiveDiscount);
      }
    }
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
