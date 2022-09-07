import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_row/counter_bloc.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_row/filter_row_widget.dart';

const _kArrowIcon = 'assets/images/icons/arrow_right.svg';

class BookingTileWidget extends StatelessWidget {
  final String title;
  final double? price;
  final String? currency;
  final String? postTitle;
  final String? ageRange;
  final int? value;
  final int? minValue;
  final int? maxValue;
  final List<int>? childAgeList;
  final ValueChanged<int>? onValueAdded;
  final ValueChanged<int>? onValueRemoved;
  final ValueChanged<int>? onChildAgeUpdate;

  const BookingTileWidget({
    Key? key,
    required this.title,
    required this.price,
    required this.currency,
    this.postTitle,
    this.ageRange,
    this.value,
    this.minValue,
    this.maxValue,
    this.childAgeList,
    this.onValueAdded,
    this.onValueRemoved,
    this.onChildAgeUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CurrencyUtil currencyUtil = CurrencyUtil(currency: currency);
    return Padding(
      padding:
          const EdgeInsets.only(top: kSize16, left: kSize24, right: kSize24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterRowWidget(
            title: title,
            titleStyle: AppTheme.kBodyRegular,
            subTitleWidget: _buildPriceWidget(currencyUtil),
            postTitleWidget: _buildPostTitleWidget(),
            filterRowWidgetType: FilterRowType.bookingCalendar,
            initialValue: value ?? 0,
            minValue: minValue,
            maxValue: maxValue,
            onValueAdded: onValueAdded,
            onValueRemoved: onValueRemoved,
          ),
          if (childAgeList != null && childAgeList!.isNotEmpty)
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: childAgeList!.length,
              itemBuilder: (context, index) =>
                  _buildChildAgeRowWidget(context, index, childAgeList![index]),
            ),
        ],
      ),
    );
  }

  Widget _buildPriceWidget(CurrencyUtil currencyUtil) => Text(
        currencyUtil.getFormattedPrice(price ?? 0),
        style: AppTheme.kBodyMedium,
        textAlign: TextAlign.center,
      );

  Widget? _buildPostTitleWidget() => postTitle != null && ageRange != null
      ? Text(
          '$postTitle $ageRange',
          style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
        )
      : null;

  Widget _buildChildAgeRowWidget(
      BuildContext context, int index, int childAge) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kSize8),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Text(
                '${getTranslated(context, AppLocalizationsStrings.ageOfChild)} ${index + 1}',
                style: AppTheme.kBodyRegular,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: kSize10),
              width: kSize32,
              child: Text(
                '$childAge ${getTranslated(context, AppLocalizationsStrings.yearsOld)}',
                textAlign: TextAlign.center,
                style: AppTheme.kSmallRegular,
              ),
            ),
            OtaIconButton(
              icon: SvgPicture.asset(
                _kArrowIcon,
                width: kSize24,
                height: kSize24,
              ),
              onTap: () {
                if (onChildAgeUpdate != null) onChildAgeUpdate!(index);
              },
            )
          ],
        ),
        const SizedBox(height: kSize8),
        const OtaHorizontalDivider()
      ],
    );
  }
}
