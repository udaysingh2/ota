import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button_list.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/drop_down_menu_widget.dart';
import 'package:ota/modules/review_filter/view/widget/bottom_sheet_widget.dart';

import '../../view_model/review_filter_view_model.dart';

class ReviewFilterScreen extends StatefulWidget {
  const ReviewFilterScreen({Key? key}) : super(key: key);

  @override
  ReviewFilterScreenState createState() => ReviewFilterScreenState();
}

class ReviewFilterScreenState extends State<ReviewFilterScreen> {
  String _sortFilterTitle = 'Score from high to low ( 10 -1 )';
  String _roomTypeFilterTitle = 'Superior';
  String _travelerTypeFilterTitle = 'All Reviews';

  final List<String> labelList = [];

  Widget _getFilterOptions(String title, String buttonTitle,
      List<FilterModel> filtermodel, ReviewSortKey type) {
    return Container(
      padding: const EdgeInsets.fromLTRB(kSize24, kSize16, kSize24, kSize8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.kHeading3,
          ),
          const SizedBox(
            height: kSize8,
          ),
          DropDownMenuButton(
            buttonText: buttonTitle,
            onButtonPressed: () {
              showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return BottomSheetWidget(
                      title: title,
                      filterModel: filtermodel,
                      onPressed: (selectedItem) {
                        setState(() {
                          switch (type) {
                            case ReviewSortKey.sortOf:
                              _sortFilterTitle = selectedItem;
                              break;
                            case ReviewSortKey.roomType:
                              _roomTypeFilterTitle = selectedItem;
                              break;
                            case ReviewSortKey.travellerType:
                              _travelerTypeFilterTitle = selectedItem;
                              break;
                          }
                        });
                      },
                    );
                  });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kLight100,
      appBar: OtaAppBar(
        title:
            getTranslated(context, AppLocalizationsStrings.reviewFilterTitle),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _getFilterOptions(
                  AppLocalizationsStrings.sortOf,
                  _sortFilterTitle,
                  FilterModel.listSortOf,
                  ReviewSortKey.sortOf),
              _getFilterOptions(
                  AppLocalizationsStrings.roomType,
                  _roomTypeFilterTitle,
                  FilterModel.listRoomType,
                  ReviewSortKey.roomType),
              _getFilterOptions(
                  AppLocalizationsStrings.travelerType,
                  _travelerTypeFilterTitle,
                  FilterModel.listTravelerType,
                  ReviewSortKey.travellerType),
              Padding(
                padding: const EdgeInsets.only(top: kSize8, left: kSize24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(AppLocalizationsStrings.reviewType,
                        style: AppTheme.kHeading3),
                    const SizedBox(
                      height: kSize8,
                    ),
                    OtaChipButtonList(
                      labelList: labelList,
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
          const OtaBottomButtonBar(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            button1: OtaTextButton(
              title: AppLocalizationsStrings.reset,
              backgroundColor: AppColors.kLight100,
              fontColor: AppColors.kGradientStart,
            ),
            button2: OtaTextButton(title: AppLocalizationsStrings.noOfReviews),
            containerHeight: kSize88,
          ),
        ],
      ),
    );
  }
}
