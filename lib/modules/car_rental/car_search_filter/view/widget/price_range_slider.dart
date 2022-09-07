import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/ota_slider/ota_slider.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/ota_slider/ota_slider_controller.dart';

const int _kMaxLines = 1;

class PriceRangeSlider extends StatelessWidget {
  final double minPrice;
  final double maxPrice;
  final SliderController sliderController;

  const PriceRangeSlider({
    Key? key,
    required this.minPrice,
    required this.maxPrice,
    required this.sliderController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslated(context, AppLocalizationsStrings.priceRange),
          overflow: TextOverflow.ellipsis,
          maxLines: _kMaxLines,
          style: AppTheme.kBodyMedium,
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: kSize8),
        _getSliderRange(),
        _getSlider(),
        const SizedBox(height: kSize24),
      ],
    );
  }

  Widget _getSliderRange() {
    CurrencyUtil currencyUtil = CurrencyUtil();
    return BlocBuilder(
      bloc: sliderController,
      builder: () {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              currencyUtil
                  .getFormattedPrice(sliderController.state.rangeValues.start),
              style:
                  AppTheme.kBodyRegular.copyWith(color: AppColors.kGreyScale),
            ),
            Text(
              currencyUtil
                  .getFormattedPrice(sliderController.state.rangeValues.end),
              style:
                  AppTheme.kBodyRegular.copyWith(color: AppColors.kGreyScale),
            )
          ],
        );
      },
    );
  }

  Widget _getSlider() {
    return OtaSlider(
      min: minPrice,
      max: maxPrice,
      sliderController: sliderController,
      onChanged: (value) {
        if (value.start == value.end) {
          return;
        }
        sliderController.updateRange(value);
      },
    );
  }
}
