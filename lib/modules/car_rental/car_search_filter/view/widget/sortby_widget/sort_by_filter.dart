import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/car_rental/car_search_filter/view/widget/sortby_widget/sort_by_controllder.dart';
import 'package:ota/modules/car_rental/car_search_filter/view_model/car_search_filter_view_model.dart';

const int _kMaxLines = 1;
const String _kSearchIconPath = "assets/images/icons/arrow_down.svg";
const String _kCloseIcon = "assets/images/icons/close.svg";
const String _kSortByAgreeKButtonKey = "sort_by_agree_button_key";

class SortByFilterBox extends StatelessWidget {
  const SortByFilterBox({
    Key? key,
    required this.sortInfo,
    required this.sortByController,
  }) : super(key: key);

  final List<CriterionModel> sortInfo;
  final SortByController sortByController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: sortByController,
      builder: () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTranslated(context, AppLocalizationsStrings.sortBy),
              overflow: TextOverflow.ellipsis,
              maxLines: _kMaxLines,
              style: AppTheme.kHeading1Medium,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: kSize8),
            _getSortingBar(context),
          ],
        );
      },
    );
  }

  Widget _getSortingBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBottomSheet(context: context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kSize8),
          color: AppColors.kGrey4,
        ),
        padding:
            const EdgeInsets.symmetric(horizontal: kSize12, vertical: kSize9),
        height: kSize40,
        child: Row(
          children: [
            Expanded(
              child: Text(
                sortByController.state.sortInfo?.displayTitle ?? '',
                style: AppTheme.kBodyRegular,
                maxLines: _kMaxLines,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: kSize6),
            SvgPicture.asset(
              _kSearchIconPath,
              height: kSize20,
              width: kSize16,
              color: AppColors.kGrey20,
            ),
          ],
        ),
      ),
    );
  }

  _showBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        sortByController.resetTemprorySort();
        return SortBySelectionSheet(
          sortInfo: sortInfo,
          sortByController: sortByController,
        );
      },
    );
  }
}

class SortBySelectionSheet extends StatelessWidget {
  const SortBySelectionSheet({
    Key? key,
    required this.sortInfo,
    required this.sortByController,
  }) : super(key: key);
  final List<CriterionModel> sortInfo;
  final SortByController sortByController;

  @override
  Widget build(BuildContext context) {
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kSize24),
          topRight: Radius.circular(kSize24),
        ),
        color: AppColors.kLight100,
      ),
      padding: EdgeInsets.only(
        top: kSize24,
        bottom: bottomPadding + (bottomPadding > 0 ? 0 : kSize24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeaderView(context),
          const SizedBox(height: kSize24),
          const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          _buildListView(context),
          const OtaHorizontalDivider(),
          Padding(
            padding: const EdgeInsets.only(
                left: kSize24, right: kSize24, top: kSize16),
            child: SizedBox(
              width: double.infinity,
              child: OtaTextButton(
                key: const Key(_kSortByAgreeKButtonKey),
                title: getTranslated(context, AppLocalizationsStrings.agree),
                onPressed: () {
                  sortByController.updateSelectedSort();
                  Navigator.of(context).pop();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeaderView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Row(
        children: [
          const SizedBox(width: kSize40),
          Expanded(
            child: Text(
              getTranslated(context, AppLocalizationsStrings.sortBy),
              overflow: TextOverflow.ellipsis,
              maxLines: _kMaxLines,
              style: AppTheme.kHeading1Medium,
              textAlign: TextAlign.center,
            ),
          ),
          OtaIconButton(
            icon: SvgPicture.asset(
              _kCloseIcon,
              height: kSize14,
              width: kSize14,
              color: AppColors.kGrey50,
            ),
            onTap: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height * 0.65;
    double totalSepratorHeight = (sortInfo.length - 1) * kSize20;
    double totalTileHeight = sortInfo.length * kSize25;
    double totalHeight = totalTileHeight + totalSepratorHeight + kSize32;
    return BlocBuilder(
      bloc: sortByController,
      builder: () {
        return SizedBox(
          height: totalHeight > maxHeight ? maxHeight : totalHeight,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: kSize16),
            itemCount: sortInfo.length,
            itemBuilder: (context, index) {
              return Material(
                child: OtaRadioButton(
                  label: sortInfo[index].displayTitle ?? '',
                  isTextFontRegular: true,
                  circledRadio: false,
                  verticalPadding: kSize0,
                  variableCrossAxisAlignment: CrossAxisAlignment.center,
                  onClicked: () {
                    sortByController.updateTemprorySort(sortInfo[index]);
                  },
                  isSelected: sortByController.state.tempSortInfo?.value ==
                      sortInfo[index].value,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: kSize20);
            },
          ),
        );
      },
    );
  }
}
