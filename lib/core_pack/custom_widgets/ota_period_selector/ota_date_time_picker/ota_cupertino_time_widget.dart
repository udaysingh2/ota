import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

import '../../ota_button_bottom_bar.dart';
import '../../ota_horizontal_divider.dart';
import '../../ota_icon_button.dart';
import '../../ota_text_button.dart';
import 'widget/date_picker.dart';

const double _kPickerHeight = 371;
const double _kTimePickerHeight = 180;
const int _kMinuteInterval0 = 0;
const int _kMinuteInterval30 = 30;
const int _kHourInterval2 = 2;
const int _kHourInterval3 = 3;

class OtaCupertinoTimeWidget extends StatefulWidget {
  final DateTime date;
  final String pickerTitle;
  final Function(
    TimeOfDay selectedTime,
  ) onSumbit;
  final bool isPickup;

  const OtaCupertinoTimeWidget({
    Key? key,
    required this.date,
    required this.pickerTitle,
    required this.onSumbit,
    required this.isPickup,
  }) : super(key: key);

  @override
  OtaCupertinoTimeWidgetState createState() => OtaCupertinoTimeWidgetState();
}

class OtaCupertinoTimeWidgetState extends State<OtaCupertinoTimeWidget> {
  DateTime? time;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kPickerHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: kSize4,
            width: kSize58,
            margin: const EdgeInsets.only(bottom: kSize4),
            decoration: BoxDecoration(
              color: AppColors.kLight100,
              borderRadius: BorderRadius.circular(kSize2),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.kLight100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kSize24),
                  topRight: Radius.circular(kSize24),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeaderView(context),
                  const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
                  buildTimePicker(),
                  _buildBottomBar()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimePicker() {
    DateTime currentDate = DateTime.now();
    return Container(
      height: _kTimePickerHeight,
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: CupertinoDatePicker(
        initialDateTime: widget.date,
        minimumDate: DateTime(
          currentDate.year,
          currentDate.month,
          currentDate.day,
          currentDate.hour +
              (currentDate.minute < _kMinuteInterval30
                  ? _kHourInterval2
                  : _kHourInterval3),
          currentDate.minute < _kMinuteInterval30
              ? _kMinuteInterval30
              : _kMinuteInterval0,
        ),
        mode: CupertinoDatePickerMode.time,
        minuteInterval: _kMinuteInterval30,
        use24hFormat: true,
        onDateTimeChanged: (dateTime) {
          time = dateTime;
        },
      ),
    );
  }

  Widget _buildHeaderView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: kSize16, bottom: kSize16, right: kSize28, left: kSize52),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.pickerTitle,
              style: AppTheme.kHeading1,
              textAlign: TextAlign.center,
            ),
          ),
          OtaIconButton(
            key: const Key('childAgePopUp'),
            icon: const Icon(
              Icons.close_rounded,
              color: AppColors.kGrey70,
              size: kSize20,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: OtaBottomButtonBar(
        safeAreaBottom: true,
        containerHeight: kSize74,
        showHorizontalDivider: true,
        padding: const EdgeInsets.only(
          left: kSize24,
          right: kSize24,
          top: kSize16,
          bottom: kSize9,
        ),
        button1: OtaTextButton(
          key: const Key('OtaTextButtonTemp'),
          title: getTranslated(context, AppLocalizationsStrings.ok),
          isSelected: true,
          onPressed: () {
            Navigator.of(context).pop();
            widget.onSumbit(
              TimeOfDay(
                hour: time == null ? widget.date.hour : time!.hour,
                minute: time == null ? widget.date.minute : time!.minute,
              ),
            );
          },
        ),
      ),
    );
  }
}
