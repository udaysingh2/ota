import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_period_selector/ota_date_time_picker/widget/localizations.dart';

void main() {
  test('Localization files date method calls cases', () async {
    const localization = DefaultCupertinoLocalizations();
    localization.datePickerHour(2);
    localization.datePickerYear(1);
    localization.datePickerMonth(2);
    localization.datePickerDayOfMonth(1);
    localization.datePickerHourSemanticsLabel(1);
    localization.datePickerMinute(1);
    localization.datePickerMinuteSemanticsLabel(2);
    localization.datePickerMediumDate(DateTime.now());
  });

  test('Localization files date getter  calls ', () async {
    const localization = DefaultCupertinoLocalizations();
    expect(localization.datePickerDateOrder, DatePickerDateOrder.mdy);
    expect(localization.datePickerDateTimeOrder,
        DatePickerDateTimeOrder.dateTimeDayPeriod);
    expect(localization.anteMeridiemAbbreviation, "AM");
    expect(localization.postMeridiemAbbreviation, "PM");
    expect(localization.todayLabel, "Today");
    expect(localization.alertDialogLabel, "Alert");
    expect(
        localization.tabSemanticsLabel(tabIndex: 2, tabCount: 3), "Tab 2 of 3");
  });
  test('Localization files time method calls cases', () async {
    const localization = DefaultCupertinoLocalizations();
    localization.timerPickerHour(2);
    localization.timerPickerMinute(1);
    localization.timerPickerSecond(2);
    localization.timerPickerHourLabel(1);
    localization.timerPickerMinuteLabel(1);
    localization.timerPickerSecondLabel(2);
  });

  test('Localization files timer getter  calls ', () async {
    const localization = DefaultCupertinoLocalizations();
    expect(localization.cutButtonLabel, "Cut");
    expect(localization.copyButtonLabel, "Copy");
    expect(localization.pasteButtonLabel, "Paste");
    expect(localization.selectAllButtonLabel, "Select All");
    expect(localization.searchTextFieldPlaceholderLabel, "Search");
    expect(localization.modalBarrierDismissLabel, "Dismiss");
  });
}
