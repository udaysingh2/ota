import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/modules/car_rental/car_reservation/view/widgets/car_reservation_add_on_bottomsheet.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../../common/utils/consts.dart';
import '../../../../../core_pack/custom_widgets/ota_app_bar.dart';
import '../../../../../core_pack/i18n/language_constants.dart';
import '../../view_model/car_reservation_add_on_view_model.dart';

const _kMaxLine = 1;
const _kBorderRadius = 20.0;
const String _kTicketMultiplySign = 'x';
CurrencyUtil _currencyUtil = CurrencyUtil();

class AddAdditionalService extends StatefulWidget {
  const AddAdditionalService({Key? key}) : super(key: key);

  @override
  State<AddAdditionalService> createState() => _AddAdditionalServiceState();
}

class _AddAdditionalServiceState extends State<AddAdditionalService> {
  Future openBottomSheetForEdit(context, extraCharges) async {
    Future.delayed(const Duration(milliseconds: 10), () {
      int? selectedAddOn =
          (ModalRoute.of(context)?.settings.arguments as List)[1];
      if (selectedAddOn != null) {
        final height = MediaQuery.of(context).size.height;
        showModalBottomSheet(
          context: context,
          builder: (_) => CarReservationAddOnBottomSheet(
              extraCharge: extraCharges
                  ?.where((element) =>
                      element.extraChargeGroup?.id == selectedAddOn)
                  .first,
              isEdit: true),
          isDismissible: false,
          isScrollControlled: true,
          constraints: BoxConstraints(maxHeight: height * 0.75),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(_kBorderRadius),
              topRight: Radius.circular(_kBorderRadius),
            ),
          ),
        );
      }
    });
  }

  List<ExtraChargeData>? _extraCharges;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _extraCharges = (ModalRoute.of(context)?.settings.arguments as List)[0];
      openBottomSheetForEdit(context, _extraCharges);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OtaAppBar(
        title:
            getTranslated(context, AppLocalizationsStrings.additionalServices),
      ),
      body: _body(_extraCharges, context),
    );
  }
}

_body(List<ExtraChargeData>? extraCharges, BuildContext context) {
  if (extraCharges != null && extraCharges.isNotEmpty) {
    return Column(children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(
              left: kSize32, top: kSize16, bottom: kSize8),
          child: Text(
              getTranslated(
                  context, AppLocalizationsStrings.selectAdditionalServices),
              style: AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey50)),
        ),
      ),
      Expanded(
        child: ListView.builder(
            itemCount: extraCharges.length,
            itemBuilder: (context, index) {
              return _addOnItem(extraCharges[index], context);
            }),
      )
    ]);
  }
}

Widget _addOnItem(ExtraChargeData? extraCharge, BuildContext context) {
  return GestureDetector(
    key: const Key("addOn_tile"),
    onTap: () {
      final height = MediaQuery.of(context).size.height;
      int currentQuantity =
          Provider.of<CarReservationAddOnViewModel>(context, listen: false)
              .getQuantityForAddOn(extraCharge?.extraChargeGroup?.id);
      showModalBottomSheet(
        backgroundColor: AppColors.kLight100,
        context: context,
        builder: (_) => CarReservationAddOnBottomSheet(
            extraCharge: extraCharge, isEdit: currentQuantity >= 1),
        isDismissible: false,
        isScrollControlled: true,
        constraints: BoxConstraints(maxHeight: height * 0.75),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_kBorderRadius),
            topRight: Radius.circular(_kBorderRadius),
          ),
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(kSize16),
      margin: const EdgeInsets.symmetric(horizontal: kSize32, vertical: kSize8),
      decoration: BoxDecoration(
          border: Border.all(
            width: kSize1,
            color: AppColors.kBorderGrey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(kSize8))),
      child: Column(
        children: [
          Consumer<CarReservationAddOnViewModel>(
            builder: (_, value, child) => _getAddonsRow(
              context: context,
              name: extraCharge?.extraChargeGroup?.name,
              noOfAddons:
                  value.getQuantityForAddOn(extraCharge?.extraChargeGroup?.id),

              ///TODO: Need to check if charge type 0 or 1 to show per day or per trip.
              price: extraCharge?.price,
              chargeType: extraCharge?.chargeType,
            ),
          ),
          const SizedBox(height: kSize4),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _setText(extraCharge, context),
                style: AppTheme.kSmallRegular
                    .copyWith(color: AppColors.kSecondary),
              ))
        ],
      ),
    ),
  );
}

String _setText(ExtraChargeData? extraCharge, BuildContext context) {
  if (extraCharge != null && extraCharge.isCompulsory!) {
    return getTranslated(context, AppLocalizationsStrings.instantPayment);
  }
  return getTranslated(context, AppLocalizationsStrings.payWhenPickingCar);
}

Widget _getAddonsRow({
  required BuildContext context,
  required String? name,
  int? noOfAddons,
  required int? price,
  required int? chargeType,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
          child: Padding(
        padding: const EdgeInsets.only(right: kSize8),
        child: Text(name ?? '',
            style: AppTheme.kBodyMedium,
            maxLines: _kMaxLine,
            overflow: TextOverflow.ellipsis),
      )),
      if (noOfAddons != null && noOfAddons != 0)
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return AppColors.gradient1.createShader(Offset.zero & bounds.size);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: kSize8),
            child: Text(
              noOfAddons.toString() + _kTicketMultiplySign,
              style: AppTheme.kBodyMedium.copyWith(color: AppColors.kTrueWhite),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      chargeType == 0
          ? RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText1,
                children: <TextSpan>[
                  TextSpan(
                    text: (_currencyUtil.getFormattedPrice(price!)),
                    style: AppTheme.kBodyMedium,
                  ),
                  TextSpan(
                    text:
                        ' /${getTranslated(context, AppLocalizationsStrings.perDayLabel)}',
                    style: AppTheme.kBodyRegularGrey50,
                  )
                ],
              ),
            )
          : chargeType == 1
              ? RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText1,
                    children: <TextSpan>[
                      TextSpan(
                        text: (_currencyUtil.getFormattedPrice(price!)),
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
                  _currencyUtil.getFormattedPrice(price!),
                  style: AppTheme.kBodyMedium,
                  maxLines: _kMaxLine,
                  overflow: TextOverflow.ellipsis,
                ),
    ],
  );
}
