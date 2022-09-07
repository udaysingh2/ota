import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_reservation/bloc/car_reservation_bloc.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../core/app_routes.dart';
import '../../../../../core_pack/custom_widgets/ota_horizontal_divider.dart';
import '../../view_model/car_reservation_add_on_view_model.dart';

const _kImage = 'assets/images/icons/addon.svg';

class CarAddonView extends StatelessWidget {
  final List<ExtraChargeData>? _extraCharges;
  final CarReservationBloc carReservationBloc;
  const CarAddonView(this._extraCharges, this.carReservationBloc, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<CarReservationAddOnViewModel>(builder: (_, value, child) {
      List<ExtraChargeData> mandatoryAddons = _extraCharges!
          .where((element) => (element.isCompulsory == false))
          .toList();
      if (mandatoryAddons.isEmpty) {
        return Column(
          children: const [
            OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
            SizedBox.shrink(),
          ],
        );
      }
      List<ExtraChargeData> optionalAddOns = _extraCharges!
          .where((element) => element.isCompulsory == false)
          .toList();

      List<ExtraChargeData> selectedAddOns = optionalAddOns
          .where((element) =>
              value.addOnServiceMap.containsKey(element.extraChargeGroup?.id))
          .toList();
      return Column(
        children: [
          const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          const SizedBox(height: kSize24),
          _headerText(context, selectedAddOns.isNotEmpty, mandatoryAddons),
          selectedAddOns.isNotEmpty
              ? _addOnSelectedView(
                  context, _extraCharges ?? [], carReservationBloc)
              : _addonSelectionView(context, mandatoryAddons),
          const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        ],
      );
    });
  }
}

Widget _addonSelectionView(
    BuildContext context, List<ExtraChargeData> extraCharges) {
  return Padding(
    padding: const EdgeInsets.only(bottom: kSize24),
    child: GestureDetector(
      key: const Key("add_ons_btn_key"),
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.addAdditionalAddons,
            arguments: [extraCharges, null]);
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: kSize16, top: kSize16, bottom: kSize16),
        margin: const EdgeInsets.only(top: kSize16),
        decoration: BoxDecoration(
            border: Border.all(
              width: kSize2,
              color: AppColors.kGrey40,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(kSize8))),
        child: Row(
          children: [_addonImage(), _addonText(context)],
        ),
      ),
    ),
  );
}

Widget _addOnSelectedView(BuildContext context,
    List<ExtraChargeData> extraCharges, CarReservationBloc carReservationBloc) {
  return Consumer<CarReservationAddOnViewModel>(builder: (_, value, child) {
    List<ExtraChargeData> optionalAddOns = extraCharges
        .where((element) => (element.isCompulsory == false))
        .toList();
    List<ExtraChargeData> selectedAddOns = optionalAddOns
        .where((element) =>
            value.addOnServiceMap.containsKey(element.extraChargeGroup?.id))
        .toList();
    return ListView.builder(
        itemCount: selectedAddOns.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return _buildAddOnInfo(
              selectedAddOns[index],
              _,
              value.getQuantityForAddOn(
                  selectedAddOns[index].extraChargeGroup?.id),
              optionalAddOns,
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
  return chargeType == 0
      ? (extraCharge.addonPriceToDisplay! *
          carReservationBloc.state.carDetailInfoModel!.numberofDays!.toInt() *
          quantity)
      : (extraCharge.addonPriceToDisplay! * quantity);
}

Widget _buildAddOnInfo(
    ExtraChargeData extraCharge,
    BuildContext context,
    int quantity,
    List<ExtraChargeData> extraCharges,
    CarReservationBloc carReservationBloc,
    int index,
    int length) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                extraCharge.extraChargeGroup?.name ?? "",
                style: AppTheme.kBodyRegular,
                //maxLines: 1,
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
                              fontSize: kSize14, color: AppColors.kGrey50)),
                ],
              ),
            ),
          ],
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
                    getTranslated(
                                context, AppLocalizationsStrings.totalPriceFor)
                            .addTrailingSpace() +
                        carReservationBloc
                            .state.carDetailInfoModel!.numberofDays
                            .toString() +
                        getTranslated(context, AppLocalizationsStrings.days)
                            .addLeadingSpace(),
                    style: AppTheme.kBodyRegular,
                  ),
                  Text(
                    "(${_setText(extraCharge, context)})",
                    style: AppTheme.kSmallRegular
                        .copyWith(color: AppColors.kGrey50),
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
              style:
                  AppTheme.kBodyRegular.copyWith(color: AppColors.kSecondary),
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
    ),
  );
}

Widget _headerText(BuildContext context, bool isAddOnSelected,
    List<ExtraChargeData> extraCharges) {
  return Padding(
    padding: const EdgeInsets.only(bottom: kSize16),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getTranslated(context, AppLocalizationsStrings.additionalServices),
            style: AppTheme.kHeading1Medium,
          ),
          isAddOnSelected
              ? InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, AppRoutes.addAdditionalAddons,
                      arguments: [extraCharges, null]),
                  child: Text(
                    getTranslated(context, AppLocalizationsStrings.addItems),
                    style: AppTheme.kBodyRegular
                        .copyWith(color: AppColors.kSecondary),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    ),
  );
}

Widget _addonImage() {
  return Padding(
      padding: const EdgeInsets.only(right: kSize7),
      child: SvgPicture.asset(_kImage));
}

Widget _addonText(BuildContext context) {
  return Text(
      getTranslated(context, AppLocalizationsStrings.selectAdditionalServices),
      style: AppTheme.kBodyRegular);
}
