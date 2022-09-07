import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_landing/bloc/hotel_landing_filters_controller.dart';
import 'package:ota/modules/hotel/hotel_landing/view/widgets/hotel_landing_search_icon.dart';

class HotelLandingFilters extends StatelessWidget {
  final String leadingText;
  final HotelLandingFiltersTrailingWidget hotelLandingFiltersTrailingWidget;
  final HotelLandingFiltersController? hotelLandingFiltersController;
  final Function()? onTab;
  const HotelLandingFilters({
    Key? key,
    required this.leadingText,
    this.hotelLandingFiltersController,
    this.hotelLandingFiltersTrailingWidget =
        HotelLandingFiltersTrailingWidget.none,
    this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (hotelLandingFiltersController != null) {
      if (hotelLandingFiltersController!.isEmpty()) {
        hotelLandingFiltersController!.setText(leadingText);
      }
    }
    return buildCheckInOutPeriodWidget(context);
  }

  Widget buildCheckInOutPeriodWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kGrey4,
        borderRadius: BorderRadius.circular(kSize8),
      ),
      child: InkWell(
        key: const Key("showCalender"),
        borderRadius: BorderRadius.circular(kSize8),
        onTap: onTab,
        child: Ink(
          key: const Key("dateRange"),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: AppColors.kGrey4,
            borderRadius: BorderRadius.circular(kSize8),
          ),
          padding: const EdgeInsets.all(kSize10),
          child: Row(
            children: [
              Expanded(
                child: BlocBuilder(
                    bloc: hotelLandingFiltersController ??
                        HotelLandingFiltersController(),
                    builder: () {
                      return Text(
                        hotelLandingFiltersController?.state ?? leadingText,
                        style: getTextStyle(context),
                      );
                    }),
              ),
              getTrailingWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTrailingWidget() {
    switch (hotelLandingFiltersTrailingWidget) {
      case HotelLandingFiltersTrailingWidget.searchIcon:
        return const HotelLandingSearchIcon();
      case HotelLandingFiltersTrailingWidget.none:
        return const SizedBox();
    }
  }

  TextStyle getTextStyle(BuildContext context) {
    return _isSearchWidget && _isPlaceHolderText(context)
        ? AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey20)
        : AppTheme.kBodyRegular;
  }

  bool get _isSearchWidget =>
      hotelLandingFiltersTrailingWidget ==
      HotelLandingFiltersTrailingWidget.searchIcon;

  bool _isPlaceHolderText(BuildContext context) =>
      hotelLandingFiltersController != null &&
      !hotelLandingFiltersController!.isEmpty() &&
      hotelLandingFiltersController!.state ==
          getTranslated(
              context, AppLocalizationsStrings.hotelLandingSearchPlaceholder);
}

enum HotelLandingFiltersTrailingWidget {
  none,
  searchIcon,
}
