import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view/widget/tour_filter_sort/tour_filter_sort_radio_widget.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_view_model.dart';

const Duration _duration = Duration(milliseconds: 100);
const double _maxScreenFraction = 0.65;

class TourFilterSortBottomSheetWidget extends StatelessWidget {
  final List<TourFilterCategoryViewModel> labelList;
  final Function(int)? onPressed;
  final String title;
  final int selectedIndex;

  const TourFilterSortBottomSheetWidget({
    Key? key,
    required this.labelList,
    this.onPressed,
    required this.title,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeaderView(context),
              const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
              _buildPickupPointView(context),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildHeaderView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kSize24),
      child: Text(
        title,
        style: AppTheme.kHeading1Medium,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildPickupPointView(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height * _maxScreenFraction;
    double totalTileHeight = labelList.length * kSize44;

    return SizedBox(
      height: totalTileHeight > maxHeight ? maxHeight : totalTileHeight,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: kSize8),
        itemCount: labelList.length,
        itemBuilder: (context, index) {
          return Material(
            color: Colors.transparent,
            child: TourFilterSortRadioWidget(
              label: labelList[index].displayTitle,
              onClicked: () {
                onPressed!(index);
                Future.delayed(_duration, () {
                  Navigator.pop(context, labelList[index]);
                });
              },
              isSelected: selectedIndex == index,
            ),
          );
        },
      ),
    );
  }
}
