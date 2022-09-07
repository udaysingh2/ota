import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_supplier/view/widgets/car_supplier_list.dart';

const int _kMaxLine = 1;
const int _kMaxLines = 2;

const String kRightArrowButton = 'supplierCardArrowClick';

class CarSupplierCardWidget extends StatelessWidget {
  final String seats;
  final String gear;
  final String doors;
  final String largeBags;
  final double totalPrice;
  final double perDayPrice;
  final String smallBags;
  final String? imageUrl;
  final String supplierName;
  final int? allowLateReturn;
  final Function()? onPressed;
  final Function()? onReserveButtonPressed;
  final String? pickupLocation;
  final String? returnLocation;
  final String? returnExtraCharge;
  const CarSupplierCardWidget(
      {Key? key,
      required this.seats,
      required this.gear,
      required this.doors,
      required this.largeBags,
      required this.smallBags,
      required this.totalPrice,
      required this.perDayPrice,
      this.allowLateReturn = 0,
      this.imageUrl,
      required this.supplierName,
      this.onPressed,
      this.onReserveButtonPressed,
      required this.pickupLocation,
      required this.returnExtraCharge,
      required this.returnLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSize24),
      child: Container(
        margin: kPaddingHori24,
        padding: const EdgeInsets.fromLTRB(kSize16, kSize8, kSize16, kSize16),
        decoration: const BoxDecoration(
          borderRadius: kBorderRad12,
          border: Border.symmetric(
            horizontal: BorderSide(
              color: AppColors.kGrey10,
              width: kSize1,
            ),
            vertical: BorderSide(
              color: AppColors.kGrey10,
              width: kSize1,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getCardMiddleBar(),
            const OtaHorizontalDivider(
              dividerColor: AppColors.kGrey10,
              height: kSize16,
            ),
            const SizedBox(
              height: kSize8,
            ),
            _getCardBottomBar(context)
          ],
        ),
      ),
    );
  }

  Widget _getCardMiddleBar() {
    return CarSupplierList(
      key: const Key(kRightArrowButton),
      noOfSeats: seats,
      gear: gear,
      noOfDoors: doors,
      noOfLargeBag: largeBags,
      noOfSmallBag: smallBags,
      kPadding: const EdgeInsets.all(0),
      imageUrl: imageUrl,
      carBrandName: supplierName,
      onPress: onPressed,
      allowLateReturn: allowLateReturn ?? 0,
    );
  }

  Widget _getCardBottomBar(BuildContext context) {
    final CurrencyUtil currencyUtil = CurrencyUtil();
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: currencyUtil
                          .getFormattedPrice(perDayPrice)
                          .addTrailingSpace(),
                      style: AppTheme.kBodyMedium,
                    ),
                    TextSpan(
                      text: getTranslated(
                        context,
                        AppLocalizationsStrings.day,
                      ).addLeadingSlash(),
                      style: AppTheme.kBodyRegular
                          .copyWith(color: AppColors.kGrey50),
                    ),
                  ],
                ),
                maxLines: _kMaxLine,
                overflow: TextOverflow.ellipsis,
              ),
              if (returnExtraCharge != null &&
                  returnExtraCharge!.isNotEmpty &&
                  double.parse(returnExtraCharge!) > 0)
                Text(
                  ("${getTranslated(context, AppLocalizationsStrings.returnTheCarToDifferentPlace).addTrailingSpace()}${currencyUtil.getFormattedPrice(double.parse(returnExtraCharge ?? "0.0"))}"),
                  style: AppTheme.kSmallerRegular
                      .copyWith(color: AppColors.kGrey20),
                  maxLines: _kMaxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              Text(
                getTranslated(
                      context,
                      AppLocalizationsStrings.totalPrice,
                    ).addTrailingSpace() +
                    currencyUtil.getFormattedPrice(_setPrice()),
                style:
                    AppTheme.kSmallerRegular.copyWith(color: AppColors.kGrey50),
                maxLines: _kMaxLine,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
        SizedBox(
          width: kSize100,
          child: OtaTextButton(
            key: const Key('ReserveButton'),
            title:
                getTranslated(context, AppLocalizationsStrings.chooseThisRoom),
            onPressed: onReserveButtonPressed,
          ),
        ),
      ],
    );
  }

  double _setPrice() {
    if (returnExtraCharge != null &&
        returnExtraCharge!.isNotEmpty &&
        double.parse(returnExtraCharge!) > 0) {
      return totalPrice + double.parse(returnExtraCharge!);
    } else {
      return totalPrice;
    }
  }
}
