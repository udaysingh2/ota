import 'package:flutter/cupertino.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

class FavoritesEmptyDataWidget extends StatelessWidget {
  const FavoritesEmptyDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: kSize140),
        child: Text(
          getTranslated(
            context,
            AppLocalizationsStrings.noFavouritesAvialable,
          ),
          style: AppTheme.kSmallerRegular.copyWith(
            fontSize: kSize14,
            color: AppColors.kGrey50,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
