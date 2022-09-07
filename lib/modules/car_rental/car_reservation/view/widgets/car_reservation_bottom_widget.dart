import 'package:flutter/widgets.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const int _kMaxLine = 1;

class CarReservationBottomWidget extends StatelessWidget {
  final Function()? onPressed;
  final double pricePerDay;
  final bool isWarningVisible;
  final String? pickupLocation;
  final String? dropLocation;
  final int? returnExtraCharge;

  const CarReservationBottomWidget(
      {Key? key,
      this.onPressed,
      required this.pricePerDay,
      this.isWarningVisible = true,
      required this.pickupLocation,
      required this.dropLocation,
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
                                text:
                                    currencyUtil.getFormattedPrice(_setPrice()),
                                style: AppTheme.kHeading1Medium,
                              ),
                            ],
                          ),
                          maxLines: _kMaxLine,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          getTranslated(
                            context,
                            AppLocalizationsStrings.total,
                          ),
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
                      isDisabled: isWarningVisible,
                      title: getTranslated(
                          context, AppLocalizationsStrings.confirm),
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
    if (returnExtraCharge != null && returnExtraCharge! > 0) {
      return pricePerDay + (returnExtraCharge ?? 0);
    } else {
      return pricePerDay;
    }
  }
}
