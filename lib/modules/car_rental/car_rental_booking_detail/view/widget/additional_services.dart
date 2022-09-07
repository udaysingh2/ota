import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/bloc/car_booking_detail_bloc.dart';
import 'package:ota/modules/car_rental/car_rental_booking_detail/view_model/car_booking_detail_view_model.dart';

const int _kMaxLine = 1;

class AdditionalServices extends StatelessWidget {
  final CarBookingDetailBloc carBookingDetailBloc;

  final CurrencyUtil _currencyUtil = CurrencyUtil();

  AdditionalServices({
    Key? key,
    required this.carBookingDetailBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ExtraChargesModel> extraCharges = carBookingDetailBloc
            .state.bookingDetail?.carBookingDetails?.extraCharges ??
        [];
    List<ExtraChargesModel> additionalAddon =
        extraCharges.where((element) => element.isCompulsory == false).toList();

    if (additionalAddon.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const OtaHorizontalDivider(
          dividerColor: AppColors.kGrey10,
        ),
        const SizedBox(height: kSize24),
        Text(
          getTranslated(context, AppLocalizationsStrings.additionalServices),
          style: AppTheme.kHeading1Medium,
        ),
        const SizedBox(height: kSize16),
        _getAllAdditionalServicesChild(
            context: context, extraChargesModel: additionalAddon),
      ],
    );
  }

  double _totalAddonPrice(ExtraChargesModel extraCharge, BuildContext context,
      int quantity, int chargeType, int days) {
    return chargeType == 1
        ? (extraCharge.price! * quantity)
        : (extraCharge.price! * days * quantity);
  }

  Widget _getDetailOption({
    required BuildContext context,
    required int index,
    required List<ExtraChargesModel> extraChargeModel,
  }) {
    ExtraChargesModel extraCharge = extraChargeModel[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                extraCharge.name ?? '',
                style: AppTheme.kBodyRegular,
                maxLines: _kMaxLine,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: kSize20),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: _currencyUtil
                        .getFormattedPrice(extraCharge.price!.toInt()),
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
//TODO-3
        // Text(
        //   '(${extraCharge.isCompulsory ?? false ? getTranslated(context, AppLocalizationsStrings.payOnlineNow) : getTranslated(context, AppLocalizationsStrings.payAtPickupPoint)})',
        //   style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
        //   maxLines: _kMaxLine,
        // ),
        const SizedBox(height: kSize8),
        Row(
          children: [
            Expanded(
              child: Text(
                getTranslated(context, AppLocalizationsStrings.noOfServices),
                style: AppTheme.kBodyRegular,
                maxLines: _kMaxLine,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: kSize20),
            Text(
              (extraCharge.quantity ?? 0).toString(),
              style: AppTheme.kBodyMedium,
              textAlign: TextAlign.end,
              maxLines: _kMaxLine,
            ),
          ],
        ),
        const SizedBox(height: kSize8),
        Row(
          children: [
            Expanded(
                child: Text(
              getTranslated(context, AppLocalizationsStrings.totalPriceFor)
                      .addTrailingSpace() +
                  carBookingDetailBloc
                      .state.bookingDetail!.carBookingDetails!.rentalDays
                      .toString() +
                  getTranslated(context, AppLocalizationsStrings.days)
                      .addLeadingSpace(),
              style: AppTheme.kBodyRegular,
              maxLines: _kMaxLine,
              overflow: TextOverflow.ellipsis,
            )),
            Text(
                _currencyUtil.getFormattedPrice(_totalAddonPrice(
                    extraCharge,
                    context,
                    extraCharge.quantity ?? 0,
                    extraCharge.chargeType ?? 0,
                    carBookingDetailBloc
                        .state.bookingDetail!.carBookingDetails!.rentalDays!)),
                style: AppTheme.kBodyMedium),
          ],
        ),
        Text(
          (extraCharge.isCompulsory ?? true
              ? getTranslated(context, AppLocalizationsStrings.payOnlineNow)
                  .addParenthesis()
              : getTranslated(context, AppLocalizationsStrings.payAtPickupPoint)
                  .addParenthesis()),
          style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
          maxLines: _kMaxLine,
        ),
        index != (extraChargeModel.length - 1)
            ? const Padding(
                padding: EdgeInsets.symmetric(vertical: kSize16),
                child: OtaHorizontalDivider(
                  dividerColor: AppColors.kGrey10,
                ),
              )
            : const SizedBox(height: kSize24),
      ],
    );
  }

  Widget _getAllAdditionalServicesChild(
      {required BuildContext context,
      required List<ExtraChargesModel> extraChargesModel}) {
    List<ExtraChargesModel> extraCharges = extraChargesModel;
    List<Widget> additionalServicesChildren = [];
    for (int i = 0; i < extraCharges.length; i++) {
      additionalServicesChildren.add(
        _getDetailOption(
            context: context, index: i, extraChargeModel: extraChargesModel),
      );
    }

    return Column(
      children: additionalServicesChildren,
    );
  }
}
