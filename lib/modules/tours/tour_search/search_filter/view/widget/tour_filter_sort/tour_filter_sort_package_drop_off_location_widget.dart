import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/search_sort.dart';
import 'package:ota/modules/tours/tour_search/search_filter/helper/tour_filter_helper.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view/widget/tour_filter_sort/tour_filter_sort_controller.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_view_model.dart';

const String _dropDownWidget = "assets/images/icons/arrow_down.svg";
const int _kMaxLines = 1;

const BorderRadius _kBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(20),
  topRight: Radius.circular(20),
);

class TourFilterSortWidget extends StatelessWidget {
  final List<TourFilterCategoryViewModel> labelList;
  final TourFilterSortController tourFilterSortController;
  final Function(int)? onPressed;
  const TourFilterSortWidget({
    Key? key,
    required this.labelList,
    required this.tourFilterSortController,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: _kBorderRadius,
          ),
          builder: (context) {
            return SearchSort(
                selectedIndex: tourFilterSortController.state.chosenOption,
                onPressed: (selectedOption) {
                  int index = TourFilterHelper.getIndex(TourFilterHelper.getSortInfoTitle(labelList), selectedOption);
                  tourFilterSortController.updateChosenOption(index);
                  if (onPressed != null) onPressed!(index);
                },
                title: getTranslated(
                    context, AppLocalizationsStrings.sortByFilter),
                labelList: TourFilterHelper.getSortInfoTitle(labelList));
          },
        );
      },
      child: Ink(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(kSize8)),
          color: AppColors.kGrey4,
        ),
        child: BlocBuilder(
          bloc: tourFilterSortController,
          builder: () {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kSize12, vertical: kSize12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      labelList[tourFilterSortController.state.chosenOption]
                          .displayTitle,
                      style: AppTheme.kBody,
                      overflow: TextOverflow.ellipsis,
                      maxLines: _kMaxLines,
                    ),
                  ),
                  OtaIconButton(
                    height: kSize20,
                    width: kSize20,
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(_dropDownWidget),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
