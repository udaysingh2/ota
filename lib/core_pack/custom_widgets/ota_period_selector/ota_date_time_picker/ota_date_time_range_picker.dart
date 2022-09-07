import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_period_selector/calendar_grid_view.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import '../../ota_alert_dialog.dart';
import 'ota_cupertino_time_widget.dart';

const _kSheetHeight = 630.0;
const _kDaysInAWeek = 7;
const _kHorizontalPadding = 24.0;
const _kMonthHeight = 304.0;

class OtaDateTimeRangePicker extends StatefulWidget {
  final String titleKey;
  final DateTime preSetCheckinDate;
  final DateTime preSetCheckoutDate;
  final String? buttonText;
  final bool isBottomSheet;
  final Function(
    DateTime checkinDate,
    DateTime checkoutDate,
  ) onSumbit;

  const OtaDateTimeRangePicker({
    Key? key,
    this.titleKey = AppLocalizationsStrings.pickADay,
    required this.preSetCheckinDate,
    required this.preSetCheckoutDate,
    required this.onSumbit,
    this.isBottomSheet = true,
    this.buttonText,
  }) : super(key: key);

  @override
  OtaDateTimeRangePickerState createState() => OtaDateTimeRangePickerState();
}

class OtaDateTimeRangePickerState extends State<OtaDateTimeRangePicker> {
  DateTime? _checkinDate;
  DateTime? _checkoutDate;
  DateTime _finalCheckinDate = DateTime.now();
  DateTime _finalCheckoutDate = DateTime.now();
  bool _isSubmitDisabled = false;
  late ScrollController _monthsListScrollController;

  @override
  void initState() {
    super.initState();
    _finalCheckinDate = widget.preSetCheckinDate;
    _finalCheckoutDate = widget.preSetCheckoutDate;
    _checkinDate = Helpers.getOnlyDateFromDateTime(widget.preSetCheckinDate);
    _checkoutDate = Helpers.getOnlyDateFromDateTime(widget.preSetCheckoutDate);
    _monthsListScrollController = ScrollController(
      initialScrollOffset:
          (widget.preSetCheckinDate.month - DateTime.now().month) *
              _kMonthHeight,
    );
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
          bottomButton()
        ],
      ),
    );
  }

  Widget bottomButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: kSize24, vertical: kSize24),
        child: OtaTextButton(
          key: const Key('OtaTextButtonTemp'),
          title: widget.buttonText ??
              getTranslated(context, AppLocalizationsStrings.ok),
          isDisabled: _isSubmitDisabled,
          isSelected: true,
          onPressed: () {
            if (_checkinDate == null || _checkoutDate == null) {
              return widget.onSumbit(
                widget.preSetCheckinDate,
                widget.preSetCheckoutDate,
              );
            } else {
              return widget.onSumbit(
                _finalCheckinDate,
                _finalCheckoutDate,
              );
            }
          },
        ),
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
    TimeOfDay checkinTime = Helpers.getOnlyTimeFromDate(_finalCheckinDate);
    TimeOfDay checkoutTime = Helpers.getOnlyTimeFromDate(_finalCheckoutDate);
    return Padding(
      padding: kPaddingHori24,
      child: Row(
        children: [
          _buildSubHeader(
            title: getTranslated(
              context,
              AppLocalizationsStrings.pickUp,
            ),
            subtitle: _checkinDate,
            time: checkinTime,
            onPressed: () {
              _buildTimeViewSheet(
                context: context,
                date: _finalCheckinDate,
                pickerTitle: getTranslated(
                  context,
                  AppLocalizationsStrings.pickUpTime,
                ),
                onSumbit: (selectedTime) {
                  _finalCheckinDate = DateTime(
                    _checkinDate!.year,
                    _checkinDate!.month,
                    _checkinDate!.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );
                  _checkCheckOutCondition();
                },
                isPickUp: true,
              );
            },
          ),
          _buildSubHeader(
            title: getTranslated(
              context,
              AppLocalizationsStrings.dropOff,
            ),
            subtitle: _checkoutDate,
            time: checkoutTime,
            onPressed: () {
              _buildTimeViewSheet(
                context: context,
                date: _finalCheckoutDate,
                pickerTitle: getTranslated(
                  context,
                  AppLocalizationsStrings.dropOfTime,
                ),
                onSumbit: (selectedTime) {
                  _finalCheckoutDate = DateTime(
                    _checkoutDate!.year,
                    _checkoutDate!.month,
                    _checkoutDate!.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );
                  _checkCheckOutCondition();
                },
                isPickUp: false,
              );
            },
          ),
        ],
      ),
    );
  }

  _checkCheckOutCondition() async {
    if (_checkoutDate != null) {
      if (_checkinDate!.compareTo(_checkoutDate!) == 0) {
        double doubleCheckinTime = _finalCheckinDate.hour.toDouble() +
            (_finalCheckinDate.minute.toDouble() / 60);
        double doubleCheckoutTime = _finalCheckoutDate.hour.toDouble() +
            (_finalCheckoutDate.minute.toDouble() / 60);
        double timeDiff = doubleCheckoutTime - doubleCheckinTime;
        if (timeDiff.truncate() < 2) {
          await _showCheckoutUpdatePopup();
          _finalCheckoutDate = _finalCheckinDate.add(const Duration(hours: 2));
          _checkoutDate = Helpers.getOnlyDateFromDateTime(_finalCheckoutDate);
        }
      }
    }

    setState(() {});
  }

  _showCheckoutUpdatePopup() async {
    OtaAlertDialog dialog = OtaAlertDialog(
      errorTitle:
          getTranslated(context, AppLocalizationsStrings.unableToProceed),
      errorMessage: getTranslated(
          context, AppLocalizationsStrings.minimumCarRentalDuration),
      buttonTitle: getTranslated(context, AppLocalizationsStrings.ok),
      useRootNavigator: false,
      onPressed: () {
        Navigator.pop(context);
      },
    );
    await dialog.showAlertDialog(context);
  }

  void _buildTimeViewSheet(
      {required BuildContext context,
      required DateTime date,
      required String pickerTitle,
      required dynamic Function(TimeOfDay) onSumbit,
      required bool isPickUp}) {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => true,
          child: OtaCupertinoTimeWidget(
            date: date,
            pickerTitle: pickerTitle,
            onSumbit: onSumbit,
            isPickup: isPickUp,
          ),
        );
      },
    );
  }

  Widget _buildSubHeader({
    required String title,
    required DateTime? subtitle,
    required TimeOfDay? time,
    required Function()? onPressed,
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
          const SizedBox(height: kSize2),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.kGrey4),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
            ),
            onPressed: onPressed,
            child: Text(
              '${(time?.hour.toString() ?? '').padLeft(2, '0')}:${(time?.minute.toString() ?? '').padLeft(2, '0')}',
              style: AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey70),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(
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
    // No dates Selected
    setState(() {
      if (_checkinDate != null) {
        if (_checkoutDate == null) {
          if (date.isAfter(_checkinDate!)) {
            // Checkin already set, checkout being selected
            _checkoutDate = date;
            _finalCheckoutDate = DateTime(
              _checkoutDate!.year,
              _checkoutDate!.month,
              _checkoutDate!.day,
              _finalCheckoutDate.hour,
              _finalCheckoutDate.minute,
            );
            _isSubmitDisabled = false;
          } else if (date.isAtSameMomentAs(_checkinDate!)) {
            _checkoutDate = date;
            _finalCheckoutDate = DateTime(
              _checkoutDate!.year,
              _checkoutDate!.month,
              _checkoutDate!.day,
              _finalCheckoutDate.hour,
              _finalCheckoutDate.minute,
            );
            _isSubmitDisabled = false;
            _checkCheckOutCondition();
          } else {
            // Date Selected is before checkin date, resetting to checkin date
            _checkoutDate = null;
            _checkinDate = date;
            _finalCheckinDate = DateTime(
              _checkinDate!.year,
              _checkinDate!.month,
              _checkinDate!.day,
              _finalCheckinDate.hour,
              _finalCheckinDate.minute,
            );
            _isSubmitDisabled = true;
          }
        } else {
          // Both checkin and checkout selected, resetting and chosing new dates
          _checkoutDate = null;
          _checkinDate = date;
          DateTime currentDate = DateTime.now();

          DateTime onlyCurrentDate =
              Helpers.getOnlyDateFromDateTime(DateTime.now());
          if (_checkinDate!.isAfter(onlyCurrentDate)) {
            _finalCheckinDate = DateTime(
              _checkinDate!.year,
              _checkinDate!.month,
              _checkinDate!.day,
              _finalCheckinDate.hour,
              _finalCheckinDate.minute,
            );
          } else {
            _finalCheckinDate = DateTime(
              currentDate.year,
              currentDate.month,
              currentDate.day,
              currentDate.hour + (currentDate.minute < 30 ? 2 : 3),
              currentDate.minute < 30 ? 30 : 0,
            );
          }
          _isSubmitDisabled = true;
        }
      }
    });
  }
}
