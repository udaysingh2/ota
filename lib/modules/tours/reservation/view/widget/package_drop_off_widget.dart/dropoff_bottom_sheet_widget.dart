import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_cupertino_picker/ota_cupertino_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tours/reservation/view_model/pickup_point_view_model.dart';

const double _kHeaderHeight = 68.0;
const double _kContainerHeight = 246;
const double _kListCacheExtent = 10000;

class DropOffBottomSheetWidget extends StatelessWidget {
  final List<PickupPointData> labelList;
  final Function(int)? onPressed;
  final String title;
  final int selectedIndex;
  final OtaCupertinoController _bloc = OtaCupertinoController();

  DropOffBottomSheetWidget({
    Key? key,
    required this.labelList,
    this.onPressed,
    required this.title,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _bloc.setSelectedIndex(selectedIndex);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: kSize4,
          width: kSize58,
          margin: const EdgeInsets.only(bottom: kSize4),
          decoration: BoxDecoration(
            color: AppColors.kWhiteColor,
            borderRadius: BorderRadius.circular(kSize2),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: AppColors.kWhiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kSize24),
              topRight: Radius.circular(kSize24),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeaderView(context),
                const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
                _buildCupertinoPicker(),
                const OtaHorizontalDivider(dividerColor: AppColors.kGrey4),
                _buildBottomBar(context)
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildHeaderView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      height: _kHeaderHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Text(
            title,
            style: AppTheme.kHeading1Medium,
          ),
          IconButton(
            key: const Key('childAgePopUp'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            iconSize: kSize20,
            splashRadius: kSize14,
            icon: const Icon(
              Icons.close_rounded,
              color: AppColors.kGrey50,
              size: kSize20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCupertinoPicker() {
    double totalTileHeight = labelList.length * kSize56;
    return BlocBuilder(
        bloc: _bloc,
        builder: () {
          return SizedBox(
            height: totalTileHeight < _kContainerHeight
                ? totalTileHeight
                : _kContainerHeight,
            child: ListView.separated(
              padding: const EdgeInsets.only(
                  top: kSize0, bottom: kSize0, left: kSize24, right: kSize24),
              cacheExtent: _kListCacheExtent,
              scrollDirection: Axis.vertical,
              itemCount: labelList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    child: OtaTextButton(
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      title: " ${index + 1}",
                      backgroundColor: Colors.transparent,
                      child: Text(labelList[index].name,
                          textAlign: TextAlign.center,
                          style: _bloc.getSelectedIndex() == index
                              ? AppTheme.kBodyMedium
                                  .copyWith(color: AppColors.kSecondary)
                              : AppTheme.kBodyRegular
                                  .copyWith(color: AppColors.kGrey20)),
                    ),
                  ),
                  onTap: () {
                    _bloc.setSelectedIndex(index);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const OtaHorizontalDivider(
                  height: kSize12,
                  dividerColor: AppColors.kGrey10,
                );
              },
            ),
          );
        });
  }

  Widget _buildBottomBar(BuildContext context) {
    return OtaBottomButtonBar(
      containerHeight: kSize88,
      safeAreaBottom: false,
      showHorizontalDivider: false,
      button1: OtaTextButton(
        title: getTranslated(context, AppLocalizationsStrings.agree),
        isSelected: true,
        onPressed: () {
          if (_bloc.getSelectedIndex() >= 0) {
            onPressed!(_bloc.getSelectedIndex());
            Navigator.pop(context, labelList[_bloc.getSelectedIndex()]);
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
