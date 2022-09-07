import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/custom_widgets/ota_date_selector/date_picker_calendar_grid_view.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_codes.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const _kHeight = 330.0;
const kOtaDatePickerNextButtonKey = Key('nextButtonKey');
const kOtaDatePickerPreviousButtonKey = Key('previousButtonKey');
const _cellHeight = 44.0;
const _daysInAWeek = 7;
const _monthRows = 5;
const _daysInAMonth = 31;
const _days = 30;

class OTADatePicker extends StatefulWidget {
  final DateTime? selectedDate;
  final DateTime checkinDate;
  final DateTime checkoutDate;
  final List<DateTime> preselectedDates;
  final Function(DateTime date) onDateChange;
  final bool? isSameDateSelectionDisabled;
  const OTADatePicker({
    Key? key,
    required this.selectedDate,
    required this.checkinDate,
    required this.checkoutDate,
    required this.preselectedDates,
    required this.onDateChange,
    this.isSameDateSelectionDisabled = false,
  }) : super(key: key);

  @override
  OTADatePickerState createState() => OTADatePickerState();
}

class OTADatePickerState extends State<OTADatePicker> {
  late DateTime _currentMonth;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _currentMonth =
        Helpers.getOnlyMonthFromDateTime(_selectedDate ?? widget.checkinDate);
  }

  int _getDaysInMonth(int monthNumber) {
    if (monthNumber == 2 ||
        monthNumber == 4 ||
        monthNumber == 6 ||
        monthNumber == 9 ||
        monthNumber == 11) return _days;
    return _daysInAMonth;
  }

  @override
  Widget build(BuildContext context) {
    final totalRows =
        (_currentMonth.weekday - 1 + _getDaysInMonth(_currentMonth.month));
    return Container(
      height: totalRows > _monthRows * _daysInAWeek
          ? _kHeight + _cellHeight
          : _kHeight,
      decoration: BoxDecoration(
        borderRadius: AppTheme.kBorderRadiusTop24,
        color: Theme.of(context).canvasColor,
      ),
      child: Column(
        children: [
          _buildHeader(),
          _buildWeekdaysTitles(),
          const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          _buildCalendarGridView(),
          const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Expanded(
      child: Text(
        text,
        style: AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey50),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCalendarGridView() {
    return Expanded(
      child: DatePickerCalendarGridView(
        checkinDate: Helpers.getOnlyDateFromDateTime(widget.checkinDate),
        checkoutDate: Helpers.getOnlyDateFromDateTime(widget.checkoutDate),
        currentMonth: _currentMonth,
        currentSelection: _selectedDate,
        preselectedDates: widget.preselectedDates,
        onDateTap: (date) {
          bool isSameDateDisabled = widget.isSameDateSelectionDisabled ?? false;
          if (!isSameDateDisabled) {
            setState(() => _selectedDate = date);
            widget.onDateChange(date);
          } else if (!date.isAtSameMomentAs(_selectedDate!)) {
            setState(() => _selectedDate = date);
            widget.onDateChange(date);
          }
        },
      ),
    );
  }

  Widget _buildWeekdaysTitles() {
    return Container(
      height: kSize44,
      padding: const EdgeInsets.only(
        left: kSize24,
        right: kSize24,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildHeaderCell(
              getTranslated(context, AppLocalizationsStrings.mondayShort)),
          _buildHeaderCell(
              getTranslated(context, AppLocalizationsStrings.tuesdayShort)),
          _buildHeaderCell(
              getTranslated(context, AppLocalizationsStrings.wednesdayShort)),
          _buildHeaderCell(
              getTranslated(context, AppLocalizationsStrings.thursdayShort)),
          _buildHeaderCell(
              getTranslated(context, AppLocalizationsStrings.fridayShort)),
          _buildHeaderCell(
              getTranslated(context, AppLocalizationsStrings.saturdayShort)),
          _buildHeaderCell(
              getTranslated(context, AppLocalizationsStrings.sundayShort)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final yearOffset =
        (AppConfig().appLocale.languageCode == LanguageCodes.thai.code
            ? kBuddhistYearOffsetCalendar
            : 0);
    final monthString = getTranslated(
      context,
      getTranslated(context, Helpers.getMonthKey(_currentMonth.month)),
    );
    final yearString = _currentMonth.year + yearOffset;

    return Container(
      height: kSize36,
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              '$monthString $yearString',
              style: AppTheme.kBodyMedium,
            ),
          ),
          _buildPreviousButton(),
          _buildNextButton(),
        ],
      ),
    );
  }

  OtaIconButton _buildPreviousButton() {
    final previousMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month - 1,
      _currentMonth.day,
    );
    final isPreviousDisabled = previousMonth.month < widget.checkinDate.month &&
            previousMonth.year <= widget.checkinDate.year ||
        previousMonth.year < widget.checkinDate.year;

    return OtaIconButton(
      key: kOtaDatePickerPreviousButtonKey,
      icon: isPreviousDisabled
          ? const Icon(
              Icons.chevron_left_rounded,
              color: AppColors.kGrey10,
            )
          : const Icon(
              Icons.chevron_left_rounded,
              color: AppColors.kGrey70,
            ),
      onTap: isPreviousDisabled
          ? null
          : () => setState(
                () => _currentMonth = previousMonth,
              ),
    );
  }

  OtaIconButton _buildNextButton() {
    final nextMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      _currentMonth.day,
    );
    final isNextDisabled = (nextMonth.month > widget.checkoutDate.month &&
            nextMonth.year >= widget.checkoutDate.year) ||
        nextMonth.year > widget.checkoutDate.year;

    return OtaIconButton(
      key: kOtaDatePickerNextButtonKey,
      icon: isNextDisabled
          ? const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.kGrey10,
            )
          : const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.kGrey70,
            ),
      onTap: isNextDisabled
          ? null
          : () => setState(
                () => _currentMonth = nextMonth,
              ),
    );
  }
}
