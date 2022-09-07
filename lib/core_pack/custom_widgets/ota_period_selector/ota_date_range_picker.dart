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

const _kSheetHeight = 630.0;
const _kDaysInAWeek = 7;
const _kHorizontalPadding = 24.0;
const _kMonthHeight = 304.0;

class OTADateRangePicker extends StatefulWidget {
  final String titleKey;
  final DateTime preSetCheckinDate;
  final DateTime preSetCheckoutDate;
  final String? buttonText;
  final bool isBottomSheet;
  final double titleTopPadding;
  final Function(DateTime checkinDate, DateTime checkoutDate) onSumbit;

  const OTADateRangePicker({
    Key? key,
    this.titleKey = AppLocalizationsStrings.pickADay,
    required this.preSetCheckinDate,
    required this.preSetCheckoutDate,
    required this.onSumbit,
    this.isBottomSheet = true,
    this.buttonText,
    this.titleTopPadding = kSize0,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  OTADateRangePickerState createState() => OTADateRangePickerState(
      checkinDate: preSetCheckinDate, checkoutDate: preSetCheckoutDate);
}

class OTADateRangePickerState extends State<OTADateRangePicker> {
  DateTime? _checkinDate;
  DateTime? _checkoutDate;
  bool _isSubmitDisabled = false;
  late ScrollController _monthsListScrollController;
  OTADateRangePickerState({
    required DateTime checkinDate,
    required DateTime checkoutDate,
  }) {
    _checkinDate = Helpers.getOnlyDateFromDateTime(checkinDate);
    _checkoutDate = Helpers.getOnlyDateFromDateTime(checkoutDate);
    _monthsListScrollController = ScrollController(
        initialScrollOffset:
            (checkinDate.month - DateTime.now().month) * _kMonthHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.isBottomSheet
          ? _kSheetHeight + MediaQuery.of(context).padding.bottom
          : double.infinity,
      decoration: BoxDecoration(
        borderRadius: AppTheme.kBorderRadiusTop24,
        color: Theme.of(context).canvasColor,
      ),
      child: Column(
        children: [
          _buildTitle(),
          _buildPeriodHeader(),
          _buildWeekdaysTitles(),
          const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          _buildCalendarGridView(),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return OtaBottomButtonBar(
      containerHeight: kSize74,
      showHorizontalDivider: true,
      padding: const EdgeInsets.only(
        left: kSize24,
        right: kSize24,
        top: kSize16,
      ),
      button1: OtaTextButton(
        key: const Key('OtaTextButtonTemp'),
        title: widget.buttonText ??
            getTranslated(context, AppLocalizationsStrings.ok),
        isSelected: true,
        isDisabled: _isSubmitDisabled,
        onPressed: () {
          if (_checkinDate == null || _checkoutDate == null) {
            return widget.onSumbit(
              widget.preSetCheckinDate,
              widget.preSetCheckoutDate,
            );
          } else {
            return widget.onSumbit(_checkinDate!, _checkoutDate!);
          }
        },
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
    return CalendarGridView(
      checkinDate: _checkinDate,
      checkoutDate: _checkoutDate,
      cellWidth: (MediaQuery.of(context).size.width - _kHorizontalPadding * 2) /
              (_kDaysInAWeek * 2) +
          2,
      onDateTap: _onDateTap,
      monthsListScrollController: _monthsListScrollController,
    );
  }

  Widget _buildWeekdaysTitles() {
    return Padding(
      padding: const EdgeInsets.only(
        left: kSize24,
        right: kSize24,
        top: kSize20,
        bottom: kSize12,
      ),
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

  Widget _buildPeriodHeader() {
    return Padding(
      padding: kPaddingHori24,
      child: Row(
        children: [
          _buildSubHeader(
            title: getTranslated(
              context,
              AppLocalizationsStrings.checkIn,
            ),
            subtitle: _checkinDate,
          ),
          _buildSubHeader(
            title: getTranslated(
              context,
              AppLocalizationsStrings.checkOut,
            ),
            subtitle: _checkoutDate,
          ),
        ],
      ),
    );
  }

  Widget _buildSubHeader({
    required String title,
    required DateTime? subtitle,
  }) {
    String subtitleText = '';
    if (subtitle == null) {
      subtitleText = getTranslated(
        context,
        AppLocalizationsStrings.selectDateLabel,
      );
    } else {
      subtitleText = Helpers.getwwddMMMyy(subtitle);
    }
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
          ),
          const SizedBox(height: kSize2),
          Text(
            subtitleText,
            style: AppTheme.kBodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: kSize8,
          left: kSize24,
          top: widget.titleTopPadding,
        ),
        child: Text(
          getTranslated(
            context,
            widget.titleKey,
          ),
          style: AppTheme.kHeading1Medium,
        ),
      ),
    );
  }

  void _onDateTap(DateTime date) {
    // No dates Selected
    setState(() {
      if (_checkinDate != null) {
        if (_checkoutDate == null) {
          if (date.isAfter(_checkinDate!)) {
            // Checkin already set, checkout being selected
            _checkoutDate = date;
            _isSubmitDisabled = false;
          } else {
            // Date Selected is before checkin date, resetting to checkin date
            _checkoutDate = null;
            _checkinDate = date;
            _isSubmitDisabled = true;
          }
        } else {
          // Both checkin and checkout selected, resetting and chosing new dates
          _checkoutDate = null;
          _checkinDate = date;
          _isSubmitDisabled = true;
        }
      }
    });
  }
}
