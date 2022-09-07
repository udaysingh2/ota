import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radio_option_list_bloc.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/favourites/helper/favourite_helper.dart';
import 'package:ota/modules/favourites/view/widgets/favourites_options/favourites_options_controller.dart';

class FavouritesOptionList extends StatelessWidget {
  final OtaRadioOptionListBloc otaRadioOptionListBloc =
      OtaRadioOptionListBloc();
  final FavouritesOptionsController favouritesOptionsController;
  final Function() onTap;
  FavouritesOptionList({
    Key? key,
    required this.favouritesOptionsController,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> optionsList =
        FavouriteHelper.getFavouritesOptionsKeyList(
            FavouriteHelper.getFavouriteOptionString());
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: optionsList.length,
      itemBuilder: (BuildContext context, int index) {
        final OtaRadioButtonController otaRadioButtonController =
            OtaRadioButtonController();
        return BlocBuilder(
          bloc: otaRadioButtonController,
          builder: () {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  key: Key(optionsList[index]),
                  onTap: () {
                    otaRadioOptionListBloc.unSelect();
                    otaRadioButtonController.setSelected();
                    otaRadioOptionListBloc.setSelected(
                        index, otaRadioButtonController);
                    favouritesOptionsController
                        .updateSelectedOption(optionsList[index]);
                    favouritesOptionsController.setCollapsed();
                    onTap();
                  },
                  child: Ink(
                    padding: const EdgeInsets.symmetric(
                        vertical: kSize8, horizontal: kSize56),
                    child: (optionsList[index] ==
                                favouritesOptionsController
                                    .state.chosenOption ||
                            OtaRadioButtonState.selected ==
                                otaRadioButtonController
                                    .state.otaRadioButtonState)
                        ? ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return AppColors.gradient1
                                  .createShader(Offset.zero & bounds.size);
                            },
                            child: Text(
                              getTranslated(
                                  context,
                                  FavouriteHelper.getServiceTitle(
                                      optionsList[index])),
                              style: AppTheme.kBodyRegular
                                  .copyWith(color: AppColors.kTrueWhite),
                            ),
                          )
                        : Text(
                            getTranslated(
                                context,
                                FavouriteHelper.getServiceTitle(
                                    optionsList[index])),
                            style: AppTheme.kBodyRegular,
                          ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
