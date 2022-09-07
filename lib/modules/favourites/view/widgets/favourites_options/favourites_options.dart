import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/favourites/helper/favourite_helper.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options_controller.dart';

const _kArrowDown = "assets/images/icons/arrow_down.svg";
const _kArrowUp = "assets/images/icons/arrow_up.svg";
const Duration _kAnimationDuration = Duration(milliseconds: 200);
const String _kFilterOptionsKey = 'filter_options_key';

class FavouritesOptions extends StatelessWidget {
  final FavouritesOptionsController favouritesOptionsController;

  const FavouritesOptions({Key? key, required this.favouritesOptionsController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: favouritesOptionsController,
        builder: () {
          return InkWell(
              onTap: () {
                favouritesOptionsController.toggle();
              },
              child: Row(
                children: [
                  _buildOptionsList(context),
                  AnimatedSwitcher(
                    duration: _kAnimationDuration,
                    child: favouritesOptionsController.isExpanded()
                        ? OtaIconButton(icon: SvgPicture.asset(_kArrowUp))
                        : OtaIconButton(icon: SvgPicture.asset(_kArrowDown)),
                  ),
                ],
              ));
        });
  }

  Widget _buildOptionsList(BuildContext context) {
    return SizedBox(
      key: const Key(_kFilterOptionsKey),
      width: kSize140,
      child: Text(
        getTranslated(
            context,
            FavouriteHelper.getServiceTitle(
                favouritesOptionsController.state.chosenOption)),
        style: AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey50),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.right,
      ),
    );
  }
}
