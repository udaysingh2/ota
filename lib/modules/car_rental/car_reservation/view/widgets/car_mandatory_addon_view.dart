import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/appflyer/car_rental/car_click_review_reservation_parameters.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_reservation/bloc/car_reservation_bloc.dart';
import 'package:ota/modules/car_rental/car_reservation/helpers/car_app_flyer_helper.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_add_on_view_model.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';
import 'package:provider/provider.dart';

class CarMandatoryAddonView extends StatelessWidget {
  final List<ExtraChargeData>? _extraCharges;
  final CarReservationBloc carReservationBloc;
  const CarMandatoryAddonView(this._extraCharges, this.carReservationBloc,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CarReservationAddOnViewModel>(builder: (_, value, child) {
      List<ExtraChargeData> mandatoryAddon = _extraCharges!
          .where((element) => element.isCompulsory == true)
          .toList();

      if (mandatoryAddon.isEmpty) {
        return const SizedBox.shrink();
      }
      return Column(
        children: [
          const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          const SizedBox(height: kSize24),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              getTranslated(
                  context, AppLocalizationsStrings.additionalServicesRequired),
              style: AppTheme.kHeading1Medium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: kSize16),
            child: Text(
                getTranslated(context,
                    AppLocalizationsStrings.additionalServicesSubtitle),
                style: AppTheme.kSmallerRegular
                    .copyWith(fontSize: kSize14, color: AppColors.kGrey50)),
          ),
          mandatoryAddon.isNotEmpty
              ? _mandatoryAddOnView(context, mandatoryAddon, carReservationBloc)
              : const SizedBox.shrink(),
        ],
      );
    });
  }
}

Widget _mandatoryAddOnView(BuildContext context,
    List<ExtraChargeData> extraCharges, CarReservationBloc carReservationBloc) {
  return Consumer<CarReservationAddOnViewModel>(builder: (_, value, child) {
    List<ExtraChargeData> selectedAddOns = extraCharges
        .where((element) => (element.isCompulsory == true))
        .toList();
    return ListView.builder(
        itemCount: selectedAddOns.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return _buildAddOnInfo(
              selectedAddOns[index],
              _,
              value.getQuantityForMandatoryAddOn(
                  selectedAddOns[index].extraChargeGroup?.id),
              extraCharges,
              carReservationBloc,
              index,
              selectedAddOns.length);
        });
  });
}

String _setText(ExtraChargeData? extraCharge, BuildContext context) {
  if (extraCharge != null && extraCharge.isCompulsory!) {
    return getTranslated(context, AppLocalizationsStrings.instantPayment);
  }
  return getTranslated(context, AppLocalizationsStrings.payWhenPickingCar);
}

final CurrencyUtil _currencyUtil = CurrencyUtil();

int _totalAddonPrice(ExtraChargeData extraCharge, BuildContext context,
    CarReservationBloc carReservationBloc, int quantity, int? chargeType) {
  return chargeType == 1
      ? (extraCharge.addonPriceToDisplay! * quantity)
      : (extraCharge.addonPriceToDisplay! *
          carReservationBloc.state.carDetailInfoModel!.numberofDays!.toInt() *
          quantity);
}

Widget _buildAddOnInfo(
    ExtraChargeData extraCharge,
    BuildContext context,
    int quantity,
    List<ExtraChargeData> extraCharges,
    CarReservationBloc carReservationBloc,
    int index,
    int length) {
  CarAppFlyerHelper().getAddOnsList(CarClickReservationAppFlyer.addOnList,
      extraCharge.extraChargeGroup?.name ?? '');

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                extraCharge.extraChargeGroup?.name ?? "",
                style: AppTheme.kBodyRegular,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: _currencyUtil.getFormattedPrice(
                        extraCharge.addonPriceToDisplay ?? 0),
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
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getTranslated(context, AppLocalizationsStrings.noOfServices),
              style: AppTheme.kBodyRegular,
            ),
            Text(
              quantity.toString(),
              style: AppTheme.kHeading1,
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getTranslated(context, AppLocalizationsStrings.totalPriceFor)
                          .addTrailingSpace() +
                      carReservationBloc.state.carDetailInfoModel!.numberofDays
                          .toString() +
                      getTranslated(context, AppLocalizationsStrings.days)
                          .addLeadingSpace(),
                  style: AppTheme.kBodyRegular,
                ),
                Text(
                  _setText(extraCharge, context).addParenthesis(),
                  style:
                      AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
                )
              ],
            )),
            Text(
              _currencyUtil.getFormattedPrice(_totalAddonPrice(
                  extraCharge,
                  context,
                  carReservationBloc,
                  quantity,
                  extraCharge.chargeType)),
              style: AppTheme.kBodyMedium,
            ),
          ],
        ),
      ),
      InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.addAdditionalAddons,
              arguments: [extraCharges, extraCharge.extraChargeGroup?.id]);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            getTranslated(context, AppLocalizationsStrings.edit),
            style: AppTheme.kBodyRegular.copyWith(color: AppColors.kSecondary),
          ),
        ),
      ),
      index != (length - 1)
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: kSize16),
              child: OtaHorizontalDivider(
                dividerColor: AppColors.kGrey10,
              ),
            )
          : const SizedBox(height: kSize8),
    ],
  );
}
