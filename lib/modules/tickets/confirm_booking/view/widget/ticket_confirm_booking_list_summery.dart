import 'package:flutter/material.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_controller.dart';
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
import 'package:ota/modules/tickets/confirm_booking/view_model/ticket_confirm_booking_model.dart';
import 'package:ota/modules/tickets/reservation/helper/ticket_reservation_helper.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_booking_terms_widget.dart';

const int _kMaxLines = 1;
const String _kTicketMultiplySign = 'x';
const double _kHeadLineHeight = 1.1;
bool isAddPromoTapped = false;
bool isRemovePromoTapped = false;

class TicketConfirmBookingListSummery extends StatelessWidget {
  final double totalServicePrice;
  final double discountAmount;
  final double netPrice;
  final List<TicketTypeViewModel> ticketTypeList;
  final String? cancellationHeader;
  final String? cancellationPolicy;
  final CurrencyUtil _currencyUtil = CurrencyUtil();
  final OtaCancellationPolicyController _controller =
      OtaCancellationPolicyController();
  final PromoWidgetBloc promoBloc;
  final String bookingUrn;
  final Function(double)? updatedPromoDiscount;
  final String merchantId;
  final VirtualPaymentBloc virtualPaymentBloc;
  final double walletAmountTobeDeducted;
  final double grandTotalWithWalletAmount;
  TicketConfirmBookingListSummery({
    Key? key,
    required this.discountAmount,
    required this.netPrice,
    required this.totalServicePrice,
    required this.ticketTypeList,
    this.cancellationHeader,
    this.cancellationPolicy,
    required this.promoBloc,
    required this.bookingUrn,
    required this.merchantId,
    this.updatedPromoDiscount,
    required this.virtualPaymentBloc,
    required this.walletAmountTobeDeducted,
    required this.grandTotalWithWalletAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSize24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _getChildren(context),
        ),
      ),
    );
  }

  List<Widget> _getChildren(BuildContext context) {
    List<Widget> widgetList = [];

    //Ticket Details and Price widget
    widgetList.add(const SizedBox(height: kSize16));
    for (TicketTypeViewModel ticket in ticketTypeList) {
      if (ticket.noOfTickets > 0) {
        widgetList.add(_getDetailsRow(
            context: context,
            name: ticket.name,
            noOfTickets: ticket.noOfTickets,
            price: (ticket.noOfTickets * ticket.price)));
        widgetList.add(const SizedBox(height: kSize16));
      }
    }
    widgetList.add(const OtaHorizontalDivider(dividerColor: AppColors.kGrey10));

    //Ticket Pricing widget
    widgetList.add(const SizedBox(height: kSize16));
    widgetList.add(_getDetailsRow(
        context: context,
        name: getTranslated(context, AppLocalizationsStrings.subtotal),
        price: totalServicePrice));
    widgetList.add(const SizedBox(height: kSize12));
    widgetList.add(BlocBuilder(
        bloc: promoBloc,
        builder: () {
          return OtaPromoWidget(
              isPromoApplied:
                  promoBloc.state.promoState == PromoWidgetState.appliedPromo,
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
        }));
    widgetList.add(const SizedBox(height: kSize16));

    //Virtual wallet
    if (OtaServiceEnabledHelper.isWalletEnabled()) {
      widgetList.add(
        BlocBuilder(
            bloc: virtualPaymentBloc,
            builder: () {
              return OtaVirtualWalletWidget(
                virtualPaymentBloc: virtualPaymentBloc,
                amountToBeDeducted: walletAmountTobeDeducted,
                paymentModel: virtualPaymentBloc.state,
              );
            }),
      );
      widgetList.add(const SizedBox(height: kSize16));
    }
    widgetList.add(const OtaHorizontalDivider(dividerColor: AppColors.kGrey10));

    //Net Price text
    widgetList.add(const SizedBox(height: kSize16));
    widgetList.add(
      BlocBuilder(
          bloc: virtualPaymentBloc,
          builder: () {
            return _getTotalName(
                context,
                getTranslated(context, AppLocalizationsStrings.totalPayment),
                getTranslated(
                    context, AppLocalizationsStrings.includeVatAndFees),
                grandTotalWithWalletAmount);
          }),
    );
    widgetList.add(const SizedBox(height: kSize16));
    widgetList.add(const OtaHorizontalDivider(dividerColor: AppColors.kGrey10));

    //Cancellation Policy
    widgetList.add(PackageBookingTermsWidget(
      controller: _controller,
      showDivider: false,
      padding: EdgeInsets.zero,
      cancellationStatus: cancellationHeader,
      bookingTermsList: TicketReservationHelper.getCancellationPolicy(
          context,
          cancellationPolicy,
          AppConfig().configModel.ticketCancellationPercent),
    ));

    return widgetList;
  }

  Widget _getDetailsRow(
      {required BuildContext context,
      required String name,
      int? noOfTickets,
      required double price}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width - kSize48) * 0.63,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                  child: Text(name,
                      style: AppTheme.kBodyRegular,
                      maxLines: _kMaxLines,
                      overflow: TextOverflow.ellipsis)),
              if (noOfTickets != null)
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return AppColors.gradient1
                        .createShader(Offset.zero & bounds.size);
                  },
                  child: Text(
                    _kTicketMultiplySign + noOfTickets.toString(),
                    style: AppTheme.kBodyRegular
                        .copyWith(color: AppColors.kTrueWhite),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
        Text(
          _currencyUtil.getFormattedPrice(price),
          style: AppTheme.kBodyMedium,
          maxLines: _kMaxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _getTotalName(BuildContext context, String topText, String bottomText,
      double netPrice) {
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getTranslated(context, topText), style: AppTheme.kBodyMedium),
            Text(getTranslated(context, bottomText),
                style: AppTheme.kSmallRegular.copyWith(
                  color: AppColors.kGrey50,
                )),
          ],
        )),
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

  _navigateToPromoSearchScreen(BuildContext context) async {
    var appliedPromo = await Navigator.of(context).pushNamed(
      AppRoutes.promoCodeSearchScreen,
      arguments: PublicPromotionArgument(
        applicationKey: OtaServiceType.ticket,
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
