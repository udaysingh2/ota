import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double _kDatePickerHeight = 316.0;

// ignore: must_be_immutable
class DatePickerWidget extends StatelessWidget {
  final DateTime maximumDate;
  final DateTime minimumDate;
  final DateTime initialDateTime;

  DatePickerWidget({
    Key? key,
    required this.maximumDate,
    required this.minimumDate,
    required this.initialDateTime,
  }) : super(key: key);

  DateTime? _selectedDateTime;
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
            children: [
              _buildHeaderView(context),
              const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
              _buildDatePickerView(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kSize18),
      child: Row(
        children: [
          OtaIconButton(
            icon: const Icon(
              Icons.close_rounded,
              size: kSize20,
            ),
            onTap: () => Navigator.pop(context),
          ),
          Expanded(
            child: Text(
              getTranslated(context, AppLocalizationsStrings.selectDate),
              style: AppTheme.kHeading1,
              textAlign: TextAlign.center,
            ),
          ),
          TextButton(
            onPressed: () => _selectedDateTime == null
                ? Navigator.pop(context, initialDateTime)
                : Navigator.pop(context, _selectedDateTime),
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return AppColors.gradient1
                    .createShader(Offset.zero & bounds.size);
              },
              child: Text(
                getTranslated(context, AppLocalizationsStrings.ok),
                style: AppTheme.kButton.copyWith(color: AppColors.kTrueWhite),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDatePickerView(BuildContext context) {
    return SizedBox(
      height: _kDatePickerHeight,
      child: CupertinoDatePicker(
        initialDateTime: initialDateTime,
        maximumDate: maximumDate,
        minimumDate: minimumDate,
        dateOrder: DatePickerDateOrder.mdy,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (dateTime) {
          _selectedDateTime = dateTime;
        },
      ),
    );
  }
}
