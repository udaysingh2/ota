import 'package:flutter/widgets.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const int _kMaxLine = 1;
const int _kMaxLines = 2;

const String _kCarDeatilPriceWidgetKey = "car_detail_price_widget_key";

class CarDeatilPriceWidget extends StatelessWidget {
  final Function()? onPressed;
  final double pricePerDay;
  final double totalPrice;
  final String? pickupLocation;
  final String? returnLocation;
  final double? returnExtraCharge;

  const CarDeatilPriceWidget(
      {Key? key,
      this.onPressed,
      required this.pricePerDay,
      required this.totalPrice,
      required this.pickupLocation,
      required this.returnLocation,
      required this.returnExtraCharge})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CurrencyUtil currencyUtil = CurrencyUtil();
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      color: AppColors.kLight100.withOpacity(0.94),
      margin: const EdgeInsets.only(top: kSize5),
      child: SafeArea(
        top: false,
        left: false,
        right: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const OtaHorizontalDivider(),
            Padding(
              padding: EdgeInsets.fromLTRB(
                kSize24,
                kSize16,
                kSize24,
                bottomPadding > kSize16 ? 0 : kSize16,
              ),
              child: Row(
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
                                    .getFormattedPrice(pricePerDay)
                                    .addTrailingSpace(),
                                style: AppTheme.kHeading1Medium,
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
                        if (returnExtraCharge != null && returnExtraCharge! > 0)
                          Text(
                            ("${getTranslated(context, AppLocalizationsStrings.returnTheCarToDifferentPlace).addTrailingSpace()}${currencyUtil.getFormattedPrice(returnExtraCharge ?? 0.0)}"),
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
                          style: AppTheme.kSmallRegular
                              .copyWith(color: AppColors.kGrey50),
                          maxLines: _kMaxLine,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: kSize120,
                    child: OtaTextButton(
                      key: const Key(_kCarDeatilPriceWidgetKey),
                      title: getTranslated(
                          context, AppLocalizationsStrings.chooseThisRoom),
                      onPressed: onPressed,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _setPrice() {
    if (pickupLocation != returnLocation) {
      return totalPrice + (returnExtraCharge ?? 0.0);
    } else {
      return totalPrice;
    }
  }
}
