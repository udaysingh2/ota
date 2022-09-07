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

class TourSearchDatePicker extends StatefulWidget {
  final String titleKey;
  final DateTime selectedDate;
  final Function(DateTime checkinDate) onSubmit;
  final Function() onReset;

  const TourSearchDatePicker({
    Key? key,
    this.titleKey = AppLocalizationsStrings.tourSelectDate,
    required this.selectedDate,
    required this.onSubmit,
    required this.onReset,
  }) : super(key: key);

  @override
  TourSearchDatePickerState createState() => TourSearchDatePickerState();
}

class TourSearchDatePickerState extends State<TourSearchDatePicker> {
  DateTime? selectedDate;
  ScrollController? _monthsListScrollController;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() {
    selectedDate = Helpers.getOnlyDateFromDateTime(widget.selectedDate);
    _monthsListScrollController = ScrollController(
        initialScrollOffset:
            (widget.selectedDate.month - DateTime.now().month) * _kMonthHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kSheetHeight + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        borderRadius: AppTheme.kBorderRadiusTop24,
        color: Theme.of(context).canvasColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          _buildSelectedDateText(),
          _buildWeekdaysTitles(),
          const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          _buildCalendarGridView(),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildSelectedDateText() {
    return Padding(
      padding: kPaddingHori24,
      child: Text(
        Helpers.getwwddMMMyyyy(selectedDate!),
        style: AppTheme.kBodyMedium,
      ),
    );
  }

  Widget _buildBottomBar() {
    return OtaBottomButtonBar(
      button1: OtaTextButton(
        title: getTranslated(context, AppLocalizationsStrings.tourFilterReset),
        onPressed: () {
          return widget.onReset();
        },
        backgroundColor: Colors.transparent,
        fontColor: AppColors.kGradientStart,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return AppColors.gradient1.createShader(Offset.zero & bounds.size);
          },
          child: Text(
            getTranslated(context, AppLocalizationsStrings.tourFilterReset),
            style: AppTheme.kButton.copyWith(color: AppColors.kTrueWhite),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      button2: OtaTextButton(
        title: getTranslated(context, AppLocalizationsStrings.agree),
        child: Text(
          getTranslated(context, AppLocalizationsStrings.agree),
          style: AppTheme.kButton.copyWith(color: AppColors.kTrueWhite),
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          return widget.onSubmit(selectedDate!);
        },
      ),
      isExpandedRightButton: true,
      spaceBetweenButton: kSize16,
      containerHeight: kSize88,
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
      checkinDate: selectedDate,
      checkoutDate: null,
      cellWidth: (MediaQuery.of(context).size.width - _kHorizontalPadding * 2) /
              (_kDaysInAWeek * 2) +
          2,
      onDateTap: _onDateTap,
      monthsListScrollController: _monthsListScrollController!,
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

  Widget _buildTitle() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          top: kSize24,
          bottom: kSize8,
          left: kSize24,
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
    setState(() {
      selectedDate = date;
    });
  }
}
