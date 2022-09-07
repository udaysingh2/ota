import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double _kWidth = 304;
const String _replacementString = ". ";
const String _nextLineString = ".\n";

class OtaNoInternetAlertDialog {
  Future<void> showAlertDialog(BuildContext context, {Function()? onOkClick}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Dialog(
            backgroundColor: AppColors.kLight100,
            elevation: kSize0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kSize20),
            ), //this right here
            child: SizedBox(
              width: _kWidth,
              child: Padding(
                padding: kPaddingAll24,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      getTranslated(
                          context, AppLocalizationsStrings.unableToProceed),
                      style: AppTheme.kHeading1Medium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: kSize8,
                    ),
                    Text(
                      getTranslated(context,
                              AppLocalizationsStrings.noInternetConnection)
                          .replaceAll(_replacementString, _nextLineString),
                      style: AppTheme.kSmallRegular
                          .copyWith(color: AppColors.kGrey50),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: kSize24,
                    ),
                    SizedBox(
                      height: kSize44,
                      width: kSize120,
                      child: OtaChipButton(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(kSize24)),
                          titleWidget: Center(
                            child: Text(
                              getTranslated(
                                  context, AppLocalizationsStrings.ok),
                              style: AppTheme.kButton
                                  .copyWith(color: AppColors.kLight100),
                            ),
                          ),
                          isSelected: true,
                          showShadow: false,
                          onPressed:
                              onOkClick ?? () => Navigator.of(context).pop()),
                    ),
                    const SizedBox(
                      width: kSize16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
