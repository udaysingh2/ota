import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_click_payment_parameters.dart';
import 'package:ota/modules/car_rental/car_reservation/helpers/car_app_flyer_helper.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';
import 'package:provider/provider.dart';

import '../../../car_reservation/view_model/car_reservation_add_on_view_model.dart';

const int _kMaxLines = 1;

class CarPaymentMandatoryAddonService extends StatelessWidget {
  final List<ExtraChargeData>? extraCharge;
  final int? numberOfDays;

  final CurrencyUtil _currencyUtil = CurrencyUtil();

  CarPaymentMandatoryAddonService({
    Key? key,
    required this.extraCharge,
    required this.numberOfDays,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ExtraChargeData> mandatoryAddon =
        extraCharge!.where((element) => element.isCompulsory == true).toList();
    if (mandatoryAddon.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: kSize24),
          child: OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        ),
        const SizedBox(
          height: kSize16,
        ),
        _getAdditionalServiceHeader(context),
        ListView.builder(
            itemCount: mandatoryAddon.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return _getAdditionalData(
                  context, mandatoryAddon[index], index, mandatoryAddon.length);
            }),
      ],
    );
  }

  Widget _getAdditionalServices(
    ExtraChargeData extraCharge,
    BuildContext context,
    String topText,
    int totalText,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            getTranslated(context, topText),
            overflow: TextOverflow.ellipsis,
            style: AppTheme.kBodyRegular,
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: _currencyUtil.getFormattedPrice(totalText),
                style: AppTheme.kBodyMedium,
              ),
              extraCharge.chargeType == 0
                  ? TextSpan(
                      text: getTranslated(
                        context,
                        AppLocalizationsStrings.perDayLabel,
                      ).addLeadingSlash(),
                      style: AppTheme.kSmallerRegular.copyWith(
                          fontSize: kSize14, color: AppColors.kGrey50))
                  : TextSpan(
                      text: getTranslated(
                        context,
                        AppLocalizationsStrings.perTripLabel,
                      ).addLeadingSlash(),
                      style: AppTheme.kSmallerRegular.copyWith(
                          fontSize: kSize14, color: AppColors.kGrey50))
            ],
          ),
        ),
      ],
    );
  }

  Widget _getAdditionalServiceHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: kSize24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              getTranslated(
                  context, AppLocalizationsStrings.additionalServicesRequired),
              style: AppTheme.kHeading1Medium),
          const SizedBox(height: kSize8),
          Text(
              getTranslated(
                  context, AppLocalizationsStrings.additionalServicesSubtitle),
              style: AppTheme.kSmallerRegular
                  .copyWith(fontSize: kSize14, color: AppColors.kGrey50)),
          const SizedBox(height: kSize16),
        ],
      ),
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

  int _totalAddonPrice(ExtraChargeData extraCharge, BuildContext context,
      int quantity, int? chargeType, int days) {
    return chargeType == 1
        ? (extraCharge.addonPriceToDisplay! * quantity)
        : (extraCharge.addonPriceToDisplay! * days * quantity);
  }

  Widget _getNumberOfdayPrice(BuildContext context, String word1, String word2,
      int? days, ExtraChargeData extraCharge, int quantity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              getTranslated(context, word1).addTrailingSpace() +
                  days.toString() +
                  getTranslated(context, word2).addLeadingSpace(),
              style: AppTheme.kBodyRegular,
              maxLines: _kMaxLines,
              overflow: TextOverflow.ellipsis,
            )),
            Text(
                _currencyUtil.getFormattedPrice(_totalAddonPrice(extraCharge,
                    context, quantity, extraCharge.chargeType, days!)),
                style: AppTheme.kBodyMedium),
          ],
        ),
        Text(_setText(extraCharge, context).addParenthesis(),
            style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50)),
      ],
    );
  }

  String _setText(ExtraChargeData? extraCharge, BuildContext context) {
    if (extraCharge != null && extraCharge.isCompulsory!) {
      return getTranslated(context, AppLocalizationsStrings.payOnlineNow);
    }
    return getTranslated(context, AppLocalizationsStrings.payAtPickupPoint);
  }

  Widget _getAdditionalData(
    BuildContext context,
    ExtraChargeData extraCharge,
    int index,
    int length,
  ) {
    final value =
        Provider.of<CarReservationAddOnViewModel>(context, listen: false);
    int quantity = value.getQuantityForAddOn(extraCharge.extraChargeGroup?.id);

    CarAppFlyerHelper().getAddOnsList(CarClickPaymentFirebase.addOnList,
        extraCharge.extraChargeGroup?.name ?? '');
    CarAppFlyerHelper().getAddOnsList(
        CarClickPaymentFirebase.addOnPricesList,
        _totalAddonPrice(extraCharge, context, quantity, extraCharge.chargeType,
                numberOfDays!)
            .toString());
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getAdditionalServices(
                extraCharge,
                context,
                extraCharge.extraChargeGroup?.name ?? "",
                extraCharge.addonPriceToDisplay ?? 0),
            const SizedBox(
              height: kSize10,
            ),
            _getGuestName(context, AppLocalizationsStrings.noOfServices,
                quantity.toString()),
            const SizedBox(
              height: kSize16,
            ),
            _getNumberOfdayPrice(
                context,
                AppLocalizationsStrings.totalPriceFor,
                AppLocalizationsStrings.days,
                numberOfDays,
                extraCharge,
                quantity),
            const SizedBox(
              height: kSize16,
            ),
            index != (length - 1)
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: kSize16),
                    child: OtaHorizontalDivider(
                      dividerColor: AppColors.kGrey10,
                    ),
                  )
                : const SizedBox(height: kSize16),
          ],
        ),
      ]),
    );
  }
}
