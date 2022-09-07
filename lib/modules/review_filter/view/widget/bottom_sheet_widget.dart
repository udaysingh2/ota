import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radion_option_list.dart';
import 'package:ota/modules/review_filter/view_model/review_filter_view_model.dart';

const double _kOpacity = 0.94;

class BottomSheetWidget extends StatelessWidget {
  final List<FilterModel> filterModel;
  final Function(String)? onPressed;
  final String title;

  const BottomSheetWidget(
      {Key? key,
      required this.filterModel,
      this.onPressed,
      required this.title})
      : super(key: key);

  List<String> _getLabelList(List<FilterModel> modelList) {
    final List<String> labelList = [];
    for (FilterModel model in modelList) {
      labelList.add(model.name);
    }
    return labelList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(kSize20),
                  topRight: Radius.circular(kSize20)),
              color: AppColors.kLight100.withOpacity(_kOpacity),
            ),
            child: Column(
              children: [
                Padding(
                  padding: kPaddingAll24,
                  child: Text(
                    title,
                    style: AppTheme.kHeading1,
                  ),
                ),
                const Divider(
                  thickness: kSize2,
                ),
                OtaRadioButtonList(
                  labelList: _getLabelList(filterModel),
                  onPressed: (selectedItem) {
                    onPressed!(selectedItem);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
