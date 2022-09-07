import 'package:flutter/material.dart';
import 'package:ota/channels/booking_customer_register_invoke/models/booking_customer_register_argument_model_channel.dart';
import 'package:ota/channels/booking_customer_register_invoke/usecases/booking_customer_register_use_cases.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_alert_bottom_sheet.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/authentication/helper/auth_navigtor_helper.dart';
import 'package:ota/modules/authentication/model/login_model.dart';

class OtaDialogHelper {
  static guestUserDialog(BuildContext context, String dialogMessage) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kSize24),
          topRight: Radius.circular(kSize24),
        ),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: AppColors.kLight100,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kSize24),
                      topRight: Radius.circular(kSize24))),
              child: OtaAlertBottomSheet(
                leftButtonText: getTranslated(
                  context,
                  AppLocalizationsStrings.insuranceAlertCancel,
                ),
                rightButtonText: getTranslated(
                  context,
                  AppLocalizationsStrings.alertRegister,
                ),
                textWidget: Text(
                  dialogMessage,
                  textAlign: TextAlign.center,
                  style: AppTheme.kBody,
                ),
                alertTitle: getTranslated(
                  context,
                  AppLocalizationsStrings.alertRegister,
                ),
                onLeftButtonTap: () {
                  Navigator.pop(context);
                },
                onRightButtonTap: () {
                  BookingCustomerRegisterUseCases
                      landingCustomerRegisterUseCases =
                      BookingCustomerRegisterUseCasesImpl();
                  LoginModel loginModel = getLoginProvider();
                  landingCustomerRegisterUseCases.invokeExampleMethod(
                    methodName: "bookingCustomerRegister",
                    arguments: BookingCustomerRegisterArgumentModelChannel(
                      userType: loginModel.userType.getSuperAppString(),
                      env: loginModel.getEnv(),
                      language: loginModel.getLanguage(),
                      userId: loginModel.userId,
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
