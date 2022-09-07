import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_gradient_text_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/core_pack/ota_firebase/car_rental/car_search_result_parameters.dart';
import 'package:ota/modules/car_rental/car_rental_search_result/view_model/car_search_result_view_model.dart';
import 'package:ota/modules/car_rental/car_search_filter/view/widget/multi_selection_filter_widget/multi_selection_filter_controller.dart';

import 'multi_selection_filter_model.dart';

const int _kMaxLines = 1;
const double _kCollapsedHeight = 106;

class MultiSelectionFilter extends StatelessWidget {
  const MultiSelectionFilter({
    Key? key,
    required this.title,
    this.description,
    required this.filterModel,
    required this.multiSelectionFilterController,
    this.spacePadding = kSize16,
    this.bottomPadding = kSize24,
    this.isBrand = false,
    this.isSupplier = false,
    this.isCarType = false,
  }) : super(key: key);
  final String title;
  final String? description;
  final List<FilterViewModel> filterModel;
  final MultiSelectionFilterController multiSelectionFilterController;
  final double spacePadding;
  final double bottomPadding;
  final bool? isSupplier;
  final bool? isBrand;
  final bool? isCarType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          maxLines: _kMaxLines,
          style: AppTheme.kBodyMedium,
          textAlign: TextAlign.left,
        ),
        if (description != null)
          Text(
            description!,
            overflow: TextOverflow.ellipsis,
            maxLines: _kMaxLines,
            style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
            textAlign: TextAlign.left,
          ),
        SizedBox(height: spacePadding),
        _buildChipList(context),
        SizedBox(height: bottomPadding),
      ],
    );
  }

  _buildChipList(BuildContext context) {
    return BlocBuilder(
      bloc: multiSelectionFilterController,
      builder: () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: multiSelectionFilterController.state.viweState ==
                      SelectionViewState.collapsed
                  ? _kCollapsedHeight
                  : null,
              child: Wrap(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                spacing: kSize16,
                runSpacing: kSize8,
                children: filterModel
                    .map(
                      (filter) => _buildButton(
                        filter: filter,
                        onTap: () {
                          multiSelectionFilterController
                              .updateIdsState(filter.id ?? '');
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
            if (multiSelectionFilterController.state.viweState !=
                SelectionViewState.none)
              TextButton(
                child: OtaGradientText(
                  gradientText: getTranslated(
                    context,
                    multiSelectionFilterController.state.viweState ==
                            SelectionViewState.collapsed
                        ? AppLocalizationsStrings.viewAll
                        : AppLocalizationsStrings.viewLess,
                  ),
                  gradientTextStyle: AppTheme.kButton,
                ),
                onPressed: () =>
                    multiSelectionFilterController.updateViewState(),
              )
          ],
        );
      },
    );
  }

  Widget _buildButton(
      {required Function() onTap, required FilterViewModel filter}) {
    bool isSelected = multiSelectionFilterController.state.selectedFilterIds
        .contains(filter.id);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppTheme.kBorderRadiusAll24,
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: kSize8, vertical: kSize4),
          decoration: isSelected
              ? const BoxDecoration(
                  gradient: AppColors.kPurpleGradient,
                  borderRadius: AppTheme.kBorderRadiusAll24,
                )
              : const BoxDecoration(
                  color: AppColors.kGrey4,
                  borderRadius: AppTheme.kBorderRadiusAll24,
                ),
          height: kSize30,
          child: Text(
            filter.name ?? '',
            overflow: TextOverflow.ellipsis,
            style: AppTheme.kSmallRegular.copyWith(
              color: isSelected ? AppColors.kTrueWhite : AppColors.kGrey50,
            ),
            maxLines: _kMaxLines,
            textAlign: TextAlign.center,
          ),
        ),
        onTap: () {
          onTap();
          if (!isSelected) {
            _getListOfAllStrings(CarSearchResultFirebase.supplierFilterList,
                filter.name ?? '', isSupplier);
            _getListOfAllStrings(CarSearchResultFirebase.carTypeFilterList,
                filter.name ?? '', isCarType);
            _getListOfAllStrings(CarSearchResultFirebase.brandFilterList,
                filter.name ?? '', isBrand);
          } else {
            _checkAndRemoveDuplicates(
                CarSearchResultFirebase.supplierFilterList, filter.name ?? '');
            _checkAndRemoveDuplicates(
                CarSearchResultFirebase.carTypeFilterList, filter.name ?? '');
            _checkAndRemoveDuplicates(
                CarSearchResultFirebase.brandFilterList, filter.name ?? '');
          }
        },
      ),
    );
  }

  _getListOfAllStrings(
      List<String> parameterList, String filterName, bool? isFilterAvailable) {
    if (isFilterAvailable == true) {
      parameterList.add(filterName);
    }
  }

  _checkAndRemoveDuplicates(List<String> parameterList, String filterName) {
    if (parameterList.contains(filterName)) {
      parameterList.remove(filterName);
    }
  }
}
