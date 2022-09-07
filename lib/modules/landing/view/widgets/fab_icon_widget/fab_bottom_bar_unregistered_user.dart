import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/landing/view/widgets/fab_icon_widget/fab_widget_controller.dart';

class OtaFabIconUnregistered extends StatelessWidget {
  final double? containerHeight;
  final FabWidgetController fabWidgetController = FabWidgetController();
  final Function()? onTap;
  OtaFabIconUnregistered({
    Key? key,
    this.containerHeight = kSize82,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(gradient: AppColors.kPurpleGradient),
          height: containerHeight,
          child: Align(
              alignment: Alignment.center,
              child: Text(
                getTranslated(context, AppLocalizationsStrings.createAnAccount),
                style: AppTheme.kButton3,
              )),
        ),
      ),
    );
  }
}
