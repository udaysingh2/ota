import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/package_detail_helper.dart';
import 'package:ota/core_pack/appflyer/car_rental/car_click_review_reservation_parameters.dart';
import 'package:ota/modules/car_rental/car_reservation/helpers/car_app_flyer_helper.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_add_on_view_model.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_row/plus_minus_button.dart';
import 'package:provider/provider.dart';

import '../../../../../common/utils/app_colors.dart';
import '../../../../../common/utils/app_localization_strings.dart';
import '../../../../../common/utils/app_theme.dart';
import '../../../../../core_pack/custom_widgets/ota_text_button.dart';
import '../../../../../core_pack/i18n/language_constants.dart';

const _kPadding = 24.0;
const _kButtonSize = 40.0;
const _kPaddingText = 16.0;

class CarReservationAddOnBottomSheet extends StatefulWidget {
  final ExtraChargeData? extraCharge;
  final bool isEdit;

  const CarReservationAddOnBottomSheet(
      {Key? key, required this.extraCharge, required this.isEdit})
      : super(key: key);

  @override
  State<CarReservationAddOnBottomSheet> createState() =>
      _CarReservationAddOnBottomSheetState();
}

class _CarReservationAddOnBottomSheetState
    extends State<CarReservationAddOnBottomSheet> {
  final CurrencyUtil _currencyUtil = CurrencyUtil();

  int quantity = 1;

  @override
  void initState() {
    quantity = Provider.of<CarReservationAddOnViewModel>(context, listen: false)
        .getQuantityForAddOn(widget.extraCharge?.extraChargeGroup?.id);
    if (quantity == 0) {
      quantity = 1;
    }
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CarReservationAddOnViewModel>(
      builder: (BuildContext _, value, Widget? child) {
        return SafeArea(
          child: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(_kPadding)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBottomSheetHeader(context, value),
                const Divider(
                  color: AppColors.kGrey10,
                  thickness: 1,
                ),
                _buildAddOnTitleWithPrice(context),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: _kPadding),
                    child: ListView(padding: EdgeInsets.zero, children: [
                      _buildAdOnDescription(widget.extraCharge),
                      const Divider(
                        color: AppColors.kGrey10,
                        thickness: 1,
                      ),
                      _buildAddOnDisclaimer()
                    ]),
                  ),
                ),
                _buildAddOnCounter(value),
                const Divider(
                  color: AppColors.kGrey4,
                  thickness: 1,
                ),
                _buildButton(
                    value.shouldDeleteAddOn(
                        widget.extraCharge?.extraChargeGroup?.id, quantity),
                    () {
                  _onButtonClick(value, context);
                })
              ],
            ),
          ),
        );
      },
    );
  }

  _buildBottomSheetHeader(context, CarReservationAddOnViewModel carViewModel) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 18.0, horizontal: _kPadding),
      child: Row(
        children: [
          Expanded(child: Container()),
          Center(
            child: Text(
              getTranslated(
                  context, AppLocalizationsStrings.selectAdditionalServices),
              style: AppTheme.kHeading1Medium,
            ),
          ),
          Expanded(child: Container()),
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.close)),
        ],
      ),
    );
  }

  _buildAddOnTitleWithPrice(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          _kPadding, _kPaddingText, _kPadding, _kPaddingText),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.extraCharge?.extraChargeGroup?.name ?? "",
                    style: AppTheme.kHeading1Medium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    _setText(widget.extraCharge, context),
                    style: AppTheme.kSmallRegular
                        .copyWith(color: AppColors.kSecondary),
                  )
                ],
              ),
            ),
            widget.extraCharge?.chargeType == 0
                ? RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText1,
                      children: <TextSpan>[
                        TextSpan(
                          text: (_currencyUtil.getFormattedPrice(
                              widget.extraCharge?.price ?? 0)),
                          style: AppTheme.kHeading1Medium,
                        ),
                        TextSpan(
                          text:
                              ' /${getTranslated(context, AppLocalizationsStrings.perDayLabel)}',
                          style: AppTheme.kBodyRegularGrey50,
                        )
                      ],
                    ),
                  )
                : widget.extraCharge?.chargeType == 1
                    ? RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyText1,
                          children: <TextSpan>[
                            TextSpan(
                              text: (_currencyUtil.getFormattedPrice(
                                  widget.extraCharge?.price ?? 0)),
                              style: AppTheme.kBodyMedium,
                            ),
                            TextSpan(
                              text:
                                  ' /${getTranslated(context, AppLocalizationsStrings.perTripLabel)}',
                              style: AppTheme.kBodyRegularGrey50,
                            )
                          ],
                        ),
                      )
                    : Text(
                        _currencyUtil
                            .getFormattedPrice(widget.extraCharge?.price ?? 0),
                        style: AppTheme.kHeading1,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
          ]),
    );
  }

  _buildAdOnDescription(ExtraChargeData? extraCharge) {
    return extraCharge?.extraChargeGroup?.description?.isNotEmpty ?? false
        ? Padding(
            padding: const EdgeInsets.only(bottom: _kPaddingText),
            child: Html(
              data: extraCharge?.extraChargeGroup?.description ?? "",
              style: PackageDetailHelper.getHtmlStyleMapWithoutPadding,
            ),
          )
        : const SizedBox();
  }

  String _setText(ExtraChargeData? extraCharge, BuildContext context) {
    if (extraCharge != null && extraCharge.isCompulsory!) {
      return getTranslated(context, AppLocalizationsStrings.instantPayment);
    }
    return getTranslated(context, AppLocalizationsStrings.payWhenPickingCar);
  }

  _buildAddOnDisclaimer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: _kPadding),
          child: Text(
              getTranslated(context, AppLocalizationsStrings.addOnDisclaimer),
              style: AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey70)),
        ),
        //const SizedBox(height: _kPadding),
        Text(
          getTranslated(
              context, AppLocalizationsStrings.additionalServiceDescription),
          style: AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey70),
        ),
        const SizedBox(height: _kPadding),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
              "${getTranslated(context, AppLocalizationsStrings.selectNumberOf)}${widget.extraCharge!.extraChargeGroup!.name?.toLowerCase()}${getTranslated(context, AppLocalizationsStrings.thatYouWant)}",
              style: AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey70)),
        ),
        const SizedBox(height: _kPadding),
      ],
    );
  }

  _buildAddOnCounter(
      CarReservationAddOnViewModel carReservationAddOnViewModel) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: Text(
              "${getTranslated(context, AppLocalizationsStrings.numberOf)}${widget.extraCharge!.extraChargeGroup!.name?.toLowerCase()}",
              style: AppTheme.kSmallRegular,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                _onMinusPressed();
              },
              icon: _shouldDisableMinusButton()
                  ? SvgPicture.asset(
                      kMinusIcon,
                      width: kSize36,
                      height: kSize36,
                      color: AppColors.kGrey10,
                    )
                  : ShaderMask(
                      shaderCallback: (Rect bounds) => AppColors.gradient1
                          .createShader(Offset.zero & bounds.size),
                      child: SvgPicture.asset(
                        kMinusIcon,
                        width: kSize36,
                        height: kSize36,
                        color: AppColors.kWhiteColor,
                      ),
                    ),
              color: AppColors.kSecondary,
              iconSize: _kButtonSize,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: _kPaddingText),
              child: Text(
                quantity.toString(),
                style: AppTheme.kHeading1Medium
                    .copyWith(color: AppColors.kSecondary),
              ),
            ),
            IconButton(
              onPressed: () {
                quantity++;
                setState(() {});
              },
              icon: ShaderMask(
                shaderCallback: (Rect bounds) =>
                    AppColors.gradient1.createShader(Offset.zero & bounds.size),
                child: SvgPicture.asset(
                  kPlusIcon,
                  width: kSize36,
                  height: kSize36,
                  color: AppColors.kWhiteColor,
                ),
              ),
              color: AppColors.kSecondary,
              iconSize: _kButtonSize,
            )
          ],
        ),
      ],
    );
  }

  _buildButton(bool isDelete, Function()? onPressed) {
    return Padding(
      padding: const EdgeInsets.only(
          top: _kPaddingText,
          right: _kPadding,
          left: _kPadding,
          bottom: _kPaddingText),
      child: SizedBox(
          width: double.maxFinite,
          child: OtaTextButton(
            key: const Key('CarOtaReservationButton'),
            title: isDelete
                ? getTranslated(context, AppLocalizationsStrings.delete)
                : getTranslated(context, AppLocalizationsStrings.ok),
            backgroundColor:
                isDelete ? AppColors.kCancelColor : AppColors.kSecondary,
            onPressed: onPressed,
          )),
    );
  }

  _onButtonClick(CarReservationAddOnViewModel carReservationAddOnViewModel,
      BuildContext context) {
    if (carReservationAddOnViewModel.shouldDeleteAddOn(
        widget.extraCharge?.extraChargeGroup?.id, quantity)) {
      carReservationAddOnViewModel
          .deleteAddOn(widget.extraCharge?.extraChargeGroup?.id);

      CarAppFlyerHelper().removeDeletedAddOns(
          CarClickReservationAppFlyer.addOnList,
          widget.extraCharge?.extraChargeGroup?.name ?? '');

      Navigator.pop(context);
    } else {
      carReservationAddOnViewModel.putAddOn(
          widget.extraCharge?.extraChargeGroup?.id, quantity);
      CarAppFlyerHelper().getAddOnsList(CarClickReservationAppFlyer.addOnList,
          widget.extraCharge?.extraChargeGroup?.name ?? '');

      Navigator.pop(context);
    }
    // Navigator.pop(context);
  }

  _onMinusPressed() {
    bool isChargeOptional = widget.extraCharge!.isCompulsory == false;
    if (widget.isEdit) {
      if (isChargeOptional && quantity >= 1) {
        setState(() {
          quantity--;
        });
      } else if (!isChargeOptional && quantity > 1) {
        setState(() {
          quantity--;
        });
      }
    } else {
      if (quantity > 1) {
        setState(() {
          quantity--;
        });
      }
    }
  }

  bool _shouldDisableMinusButton() {
    bool isChargeOptional = widget.extraCharge!.isCompulsory == false;
    if (widget.isEdit) {
      if (isChargeOptional && quantity < 1) {
        return true;
      } else if (!isChargeOptional && quantity <= 1) {
        return true;
      }
    } else {
      if (quantity <= 1) {
        return true;
      }
    }
    return false;
  }
}
