import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/main.dart';

import '../ota_horizontal_divider.dart';

const _daysInAWeek = 7;
const _daysInAMonth = 31;
const _cellHeight = 44.0;
const _innerCellHeight = 32.0;
const _additionalPadding = -1.0;
const _kSheetHeight = 630.0;

class CalendarGridView extends StatelessWidget {
  final DateTime? checkinDate;
  final DateTime? checkoutDate;
  final double cellWidth;
  final ScrollController monthsListScrollController;
  final Function(DateTime selectedDate) onDateTap;
  const CalendarGridView({
    Key? key,
    required this.checkinDate,
    required this.checkoutDate,
    required this.cellWidth,
    required this.onDateTap,
    required this.monthsListScrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final today = Helpers.getOnlyDateFromDateTime(DateTime.now());
    final yearOffset =
        (MyApp.getLocal(context).languageCode.toLowerCase() == 'th'
            ? kBuddhistYearOffsetCalendar
            : 0);
    return Expanded(
      child: ListView.builder(
        controller: monthsListScrollController,
        cacheExtent: _kSheetHeight * 2,
        itemBuilder: (context, index) {
          final firstDay = DateTime(today.year, today.month + index, 1);
          final monthString = getTranslated(
            context,
            getTranslated(context, Helpers.getMonthKey(firstDay.month)),
          );
          final yearString = firstDay.year + yearOffset;
          final dayOffset = firstDay.weekday - 1;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '$monthString $yearString',
                  style: AppTheme.kBodyMedium,
                ),
              ),
              _buildMonth(firstDay.month, dayOffset, firstDay.year),
              const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
              const SizedBox(height: kSize16),
            ],
          );
        },
        padding: kPaddingHori24Vert16,
        itemCount:
            (AppConfig().configModel.calendarMinDate / _daysInAMonth).ceil() +
                1,
      ),
    );
  }

  Widget _buildMonth(int monthIndex, int dateOffset, int year) {
    final today = Helpers.getOnlyDateFromDateTime(DateTime.now());
    final daysLimit =
        today.add(Duration(days: AppConfig().configModel.calendarMinDate - 1));
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _daysInAWeek,
        mainAxisExtent: _cellHeight,
      ),
      shrinkWrap: true,
      itemCount: _daysInAMonth + dateOffset,
      physics: const NeverScrollableScrollPhysics(),
      padding: kPaddingVert16,
      itemBuilder: (context, index) {
        final date = DateTime(year, monthIndex, 1)
            .add(Duration(days: index - dateOffset));

        if (monthIndex == date.month) {
          return _buildDayCell(
            date,
            _getCalendarType(date, today, daysLimit),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildDayCell(DateTime date, CalenderCellType calenderCellType) {
    Color textColor = AppColors.kGrey70; // Set text color
    Widget?
        surroundingCircle; // SurroundingCircle for selected checkin and checkout dates
    Widget? fillerLeft; // Leading selected region
    Widget? fillerRight; // Trailing selected region

    switch (calenderCellType) {
      case CalenderCellType.disabled:
        textColor = AppColors.kGrey10;
        break;
      case CalenderCellType.today:
        textColor = AppColors.kPrimaryHighlight;
        break;
      case CalenderCellType.enabled:
        break;
      case CalenderCellType.selectedStart:
        textColor = AppColors.kLight100;
        surroundingCircle = _buildSurroundingCircle();
        if (checkoutDate != null && checkinDate != checkoutDate) {
          fillerRight = _buildFillerRight();
        }
        break;
      case CalenderCellType.filled:
        textColor = AppColors.kLight100;
        fillerLeft = _buildFillerLeft();
        if (checkoutDate != null) fillerRight = _buildFillerRight();
        break;
      case CalenderCellType.unselectedStart:
        break;
      case CalenderCellType.selectedEnd:
        textColor = AppColors.kLight100;
        surroundingCircle = _buildSurroundingCircle();
        fillerLeft = _buildFillerLeft();
        break;
    }

    // Centered date
    final centeredText = Center(
      child: Text(
        date.day.toString(),
        style: AppTheme.kBodyRegular.copyWith(color: textColor),
        textAlign: TextAlign.center,
      ),
    );

    // Trailing selected region

    return InkWell(
      key: Key(date.toString()),
      onTap: calenderCellType == CalenderCellType.disabled
          ? null
          : () => onDateTap(date),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (fillerLeft != null) fillerLeft,
          if (fillerRight != null) fillerRight,
          if (surroundingCircle != null) surroundingCircle,
          centeredText,
        ],
      ),
    );
  }

  CalenderCellType _getCalendarType(
    DateTime date,
    DateTime today,
    DateTime daysLimit,
  ) {
    CalenderCellType calenderCellType = CalenderCellType.enabled;
    if (date.isBefore(today) || date.isAfter(daysLimit)) {
      calenderCellType = CalenderCellType.disabled;
      return calenderCellType;
    } else {
      if (date == today) {
        calenderCellType = CalenderCellType.today;
      }
      if (checkinDate == null) {
        return calenderCellType;
      } else {
        if (date == checkinDate) {
          calenderCellType = CalenderCellType.selectedStart;
          return calenderCellType;
        }
        if (checkoutDate != null) {
          if (date.isAfter(checkinDate!) && date.isBefore(checkoutDate!)) {
            calenderCellType = CalenderCellType.filled;
          }
          if (date == checkoutDate) {
            calenderCellType = CalenderCellType.selectedEnd;
          }
        }
      }
    }
    return calenderCellType;
  }

  Widget _buildFillerLeft() => Positioned(
        top: kSize0,
        bottom: kSize0,
        left: _additionalPadding,
        child: Center(
          child: Container(
            height: _innerCellHeight,
            width: cellWidth,
            padding: EdgeInsets.zero,
            color: AppColors.kPrimary,
          ),
        ),
      );
  Widget _buildFillerRight() => Positioned(
        top: kSize0,
        bottom: kSize0,
        right: _additionalPadding,
        child: Center(
          child: Container(
            height: _innerCellHeight,
            width: cellWidth,
            color: AppColors.kPrimary,
          ),
        ),
      );

  Widget _buildSurroundingCircle() => Center(
        //
        key: const Key('circledDay'),
        child: Container(
          height: _innerCellHeight,
          width: _innerCellHeight,
          decoration: const BoxDecoration(
            color: AppColors.kSecondary,
            shape: BoxShape.circle,
          ),
        ),
      );
}

enum CalenderCellType {
  disabled,
  today,
  enabled,
  selectedStart,
  filled,
  unselectedStart,
  selectedEnd,
}
