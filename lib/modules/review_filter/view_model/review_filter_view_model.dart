import 'package:ota/common/utils/app_localization_strings.dart';

enum ReviewSortKey {
  sortOf,
  roomType,
  travellerType,
}

class FilterModel {
  String name;
  bool isSelected;

  FilterModel({required this.name, required this.isSelected});

  /* Do not change its filterId value it is use in api Callback*/
  static List<FilterModel> listSortOf = [
    FilterModel(
      name: AppLocalizationsStrings.recommend,
      isSelected: true,
    ),
    FilterModel(
      name: AppLocalizationsStrings.latest,
      isSelected: false,
    ),
    FilterModel(
      name: AppLocalizationsStrings.scoreHighLow,
      isSelected: false,
    ),
    FilterModel(
      name: AppLocalizationsStrings.scoreLowHigh,
      isSelected: false,
    )
  ];

  static List<FilterModel> listRoomType = [
    FilterModel(
      name: AppLocalizationsStrings.superior,
      isSelected: true,
    ),
    FilterModel(
      name: AppLocalizationsStrings.delux,
      isSelected: false,
    ),
    FilterModel(
      name: AppLocalizationsStrings.master,
      isSelected: false,
    )
  ];

  static List<FilterModel> listTravelerType = [
    FilterModel(
      name: AppLocalizationsStrings.allReviews,
      isSelected: true,
    ),
    FilterModel(
      name: AppLocalizationsStrings.businessman,
      isSelected: false,
    ),
    FilterModel(
      name: AppLocalizationsStrings.couple,
      isSelected: false,
    ),
    FilterModel(
      name: AppLocalizationsStrings.soloTraveler,
      isSelected: false,
    )
  ];
}
