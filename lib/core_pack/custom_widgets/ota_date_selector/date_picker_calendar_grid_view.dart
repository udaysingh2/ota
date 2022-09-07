import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';

const _daysInAWeek = 7;
const _daysInAMonth = 31;
const _cellHeight = 44.0;
const _kHorizontalPadding = 24.0;
const _innerCellHeight = 32.0;

class DatePickerCalendarGridView extends StatelessWidget {
  final DateTime checkinDate;
  final DateTime checkoutDate;
  final DateTime currentMonth;
  final DateTime? currentSelection;
  final List<DateTime> preselectedDates;
  final Function(DateTime selectedDate) onDateTap;
  const DatePickerCalendarGridView({
    Key? key,
    required this.checkinDate,
    required this.checkoutDate,
    required this.onDateTap,
    required this.currentMonth,
    required this.currentSelection,
    required this.preselectedDates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayOffset = currentMonth.weekday - 1;

    return _buildMonth(currentMonth.month, dayOffset, currentMonth.year);
  }

  Widget _buildMonth(int monthIndex, int dateOffset, int year) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _daysInAWeek,
        mainAxisExtent: _cellHeight,
      ),
      shrinkWrap: true,
      itemCount: _daysInAMonth + dateOffset,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: _kHorizontalPadding,
        vertical: kSize18,
      ),
      itemBuilder: (context, index) {
        final date = DateTime(year, monthIndex, 1)
            .add(Duration(days: index - dateOffset));

        if (monthIndex == date.month) {
          return _buildDayCell(
            date,
            _getCalendarType(date),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildDayCell(DateTime date, CalenderCellType calenderCellType) {
    Color textColor = AppColors.kGrey70; // Set text color

    switch (calenderCellType) {
      case CalenderCellType.disabled:
        textColor = AppColors.kGrey10;
        break;
      case CalenderCellType.selected:
        textColor = AppColors.kLight100;
        break;
      case CalenderCellType.enabled:
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

    return InkWell(
      key: Key(date.toString()),
      onTap: calenderCellType == CalenderCellType.disabled
          ? null
          : () => onDateTap(date),
      child: Container(
        height: _innerCellHeight,
        width: _innerCellHeight,
        decoration: calenderCellType == CalenderCellType.selected
            ? const BoxDecoration(
                color: AppColors.kSecondary,
                shape: BoxShape.circle,
              )
            : const BoxDecoration(),
        child: centeredText,
      ),
    );
  }

  CalenderCellType _getCalendarType(
    DateTime date,
  ) {
    if (date.isBefore(checkinDate) || date.isAfter(checkoutDate)) {
      return CalenderCellType.disabled;
    } else {
      if (preselectedDates.contains(date)) {
        return CalenderCellType.disabled;
      } else {
        if (date == currentSelection) {
          return CalenderCellType.selected;
        } else {
          return CalenderCellType.enabled;
        }
      }
    }
  }
}

enum CalenderCellType {
  disabled,
  enabled,
  selected,
}
