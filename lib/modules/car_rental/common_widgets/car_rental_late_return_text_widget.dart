import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const String _kCircleCheckIcon = "assets/images/icons/purple_circle_check_icon.svg";

class CarRentalLateReturnTextWidget extends StatelessWidget {
  const CarRentalLateReturnTextWidget({
    Key? key,
    required this.allowLateReturn,
  }) : super(key: key);

  final int allowLateReturn;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          _kCircleCheckIcon,
          height: kSize20,
          width: kSize20,
          fit: BoxFit.cover,
        ),
        const SizedBox(width: kSize8),
        Text(
          getTranslated(context, AppLocalizationsStrings.free).addTrailingSpace() +
              allowLateReturn.toString() +
              getTranslated(
                  context, AppLocalizationsStrings.hourLateReturn),
          style:
          AppTheme.kSmallRegular.copyWith(color: AppColors.kSecondary),
        ),
      ],
    );
  }
}
