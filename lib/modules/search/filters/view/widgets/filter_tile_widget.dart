import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_row/counter_bloc.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_row/filter_row_widget.dart';

const String _kRightArrowAsset = 'assets/images/icons/arrow_right_24.svg';

class FilterTileWidget extends StatelessWidget {
  final int roomNumber;
  final List<int> childAgeList;
  final int? adults;
  final String? bedTypeKey;
  final ValueChanged<int>? onAdultAdded;
  final ValueChanged<int>? onAdultRemoved;
  final ValueChanged<int>? onChildAdded;
  final ValueChanged<int>? onChildRemoved;
  final ValueChanged<int>? onChildAgeUpdate;
  final ValueChanged<String>? onBedTypeUpdate;

  const FilterTileWidget({
    Key? key,
    required this.roomNumber,
    required this.childAgeList,
    this.adults,
    this.bedTypeKey,
    this.onAdultAdded,
    this.onAdultRemoved,
    this.onChildAdded,
    this.onChildRemoved,
    this.onChildAgeUpdate,
    this.onBedTypeUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: kSize24),
        Text(
          '${getTranslated(context, AppLocalizationsStrings.room)} $roomNumber',
          style: AppTheme.kHeading1Medium,
        ),
        FilterRowWidget(
          key: Key(FilterRowType.adult.toString() + key.toString()),
          title: getTranslated(context, AppLocalizationsStrings.adults),
          initialValue: adults ?? AppConfig().configModel.defaultAdultCount,
          filterRowWidgetType: FilterRowType.adult,
          onValueAdded: (value) => onAdultAdded!(value),
          onValueRemoved: onAdultRemoved,
        ),
        FilterRowWidget(
          key: Key(FilterRowType.child.toString() + key.toString()),
          title: getTranslated(context, AppLocalizationsStrings.children),
          initialValue: childAgeList.length,
          filterRowWidgetType: FilterRowType.child,
          onValueAdded: onChildAdded,
          onValueRemoved: onChildRemoved,
        ),
        Column(
          children: _getChildWidgets(context, childAgeList),
        ),
        if (bedTypeKey != null) _buildBedTypeRowWidget(context),
        const SizedBox(height: kSize16),
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10)
      ],
    );
  }

  Widget _buildBedTypeRowWidget(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.only(left: kSize0, right: kSize0),
            title: Text(
              getTranslated(context, AppLocalizationsStrings.bedType),
              style: AppTheme.kBodyRegular,
            ),
            subtitle: Text(
              getTranslated(context, AppLocalizationsStrings.bedTypeSubTitle),
              style: AppTheme.kSmall1,
            ),
          ),
        ),
        Text(
          getTranslated(context, bedTypeKey!),
          style: AppTheme.kBodyRegular,
        ),
        OtaIconButton(
          icon: SvgPicture.asset(
            _kRightArrowAsset,
            width: kSize24,
            height: kSize24,
          ),
          onTap: () {
            if (onBedTypeUpdate != null) {
              onBedTypeUpdate!(bedTypeKey!);
            }
          },
        )
      ],
    );
  }

  List<Widget> _getChildWidgets(BuildContext context, List<int> childAgeList) {
    return List<Widget>.generate(
      childAgeList.length,
      (index) => _buildChildAgeRowWidget(context, index, childAgeList[index]),
    );
  }

  Widget _buildChildAgeRowWidget(
      BuildContext context, int index, int childAge) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Text(
            '${getTranslated(context, AppLocalizationsStrings.ageOfChild)} ${index + 1}',
            style: AppTheme.kBodyRegular,
          ),
        ),
        Container(
          width: kSize32,
          margin: const EdgeInsets.only(right: kSize10),
          child: Text(
            '$childAge ${getTranslated(context, AppLocalizationsStrings.yearsOld)}',
            style: AppTheme.kBodyRegular,
            textAlign: TextAlign.center,
          ),
        ),
        OtaIconButton(
          icon: SvgPicture.asset(
            _kRightArrowAsset,
            width: kSize24,
            height: kSize24,
          ),
          onTap: () {
            if (onChildAgeUpdate != null) onChildAgeUpdate!(index);
          },
        )
      ],
    );
  }
}
