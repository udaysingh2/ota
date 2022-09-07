import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_pack/custom_widgets/ota_button_bottom_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_period_selector/calendar_grid_view.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const _kDaysInAWeek = 7;
const _kHorizontalPadding = 24.0;
const _kMonthHeight = 304.0;

class OTAGridVScrollDateRangePicker extends StatefulWidget {
  final String headerKey;
  final DateTime preSelectedDate;
  final Function(DateTime selectedDate) onSubmit;

  const OTAGridVScrollDateRangePicker({
    Key? key,
    this.headerKey = AppLocalizationsStrings.selectedDate,
    required this.preSelectedDate,
    required this.onSubmit,
  }) : super(key: key);

  @override
  OTAGridVScrollDateRangePickerState createState() =>
      OTAGridVScrollDateRangePickerState();
}

class OTAGridVScrollDateRangePickerState
    extends State<OTAGridVScrollDateRangePicker> {
  DateTime? _selectedDate;
  ScrollController? _monthsListScrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        _buildSelectedDateText(),
        _buildWeekdaysTitles(),
        const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        _buildCalendarGridView(),
        _buildBottomBar(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    _selectedDate = Helpers.getOnlyDateFromDateTime(widget.preSelectedDate);
    _monthsListScrollController = ScrollController(
        initialScrollOffset:
            (widget.preSelectedDate.month - DateTime.now().month) *
                _kMonthHeight);
  }

  Widget _buildBottomBar() {
    return OtaBottomButtonBar(
      containerHeight: kSize88,
      showHorizontalDivider: true,
      button1: OtaTextButton(
        key: const Key('OtaTextButtonTemp'),
        title: getTranslated(context, AppLocalizationsStrings.ok),
        isSelected: true,
        isDisabled: false,
        onPressed: () {
          if (_selectedDate == null) {
            return widget.onSubmit(widget.preSelectedDate);
          } else {
            return widget.onSubmit(_selectedDate!);
          }
        },
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Expanded(
      child: Text(
        text,
        style: AppTheme.kBodyRegularGrey50,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCalendarGridView() {
    return CalendarGridView(
      checkinDate: _selectedDate,
      checkoutDate: null,
      cellWidth: (MediaQuery.of(context).size.width - _kHorizontalPadding * 2) /
              (_kDaysInAWeek * 2) +
          2,
      onDateTap: (date) => setState(() {
        _selectedDate = date;
      }),
      monthsListScrollController: _monthsListScrollController!,
    );
  }

  Widget _buildWeekdaysTitles() {
    return Padding(
      padding: const EdgeInsets.only(
          left: kSize24, right: kSize24, top: kSize20, bottom: kSize12),
      child: Row(
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

  Widget _buildSelectedDateText() {
    return Padding(
      padding: kPaddingHori24,
      child: Text(
        Helpers.getwwddMMMyyyy(_selectedDate ?? widget.preSelectedDate),
        style: AppTheme.kBodyMedium,
      ),
    );
  }

  Widget _buildHeader() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          top: kSize24,
          bottom: kSize8,
          left: kSize24,
        ),
        child: Text(
          getTranslated(context, widget.headerKey),
          style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
        ),
      ),
    );
  }
}
