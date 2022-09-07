import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view/widget/tour_filter_chip_button/tour_chip_button_controller.dart';
import 'package:ota/modules/tours/tour_search/search_filter/view_model/tour_search_filter_view_model.dart';

const _kBorderRadius20 = BorderRadius.all(Radius.circular(kSize20));

class TourChipButton extends StatelessWidget {
  final Function()? onPressed;
  final TourStyleViewModel filterStyle;
  final ValueChanged<bool>? onSelected;
  final TourChipButtonController _controller = TourChipButtonController();
  TourChipButton({
    Key? key,
    this.onPressed,
    required this.filterStyle,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.state.isSelected = filterStyle.isSelected;
    return Material(
      child: BlocBuilder(
          bloc: _controller,
          builder: () {
            return InkWell(
              onTap: () {
                _controller.selectionToggle(filterStyle);
              },
              borderRadius: const BorderRadius.all(Radius.circular(kSize20)),
              child: Ink(
                padding: const EdgeInsets.symmetric(
                    horizontal: kSize8, vertical: kSize4),
                decoration: _controller.state.isSelected
                    ? const BoxDecoration(
                        gradient: AppColors.kPurpleGradient,
                        borderRadius: _kBorderRadius20,
                      )
                    : const BoxDecoration(
                        color: AppColors.kGrey4,
                        borderRadius: _kBorderRadius20,
                      ),
                child: Text(
                  filterStyle.styleName,
                  style: AppTheme.kSmallRegular.copyWith(
                    color: _controller.state.isSelected
                        ? AppColors.kTrueWhite
                        : AppColors.kGrey50,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: DefaultTextStyle.of(context).maxLines,
                ),
              ),
            );
          }),
    );
  }
}
