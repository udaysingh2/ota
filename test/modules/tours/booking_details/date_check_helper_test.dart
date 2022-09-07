import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/tours/booking_details/helper/date_check_helper.dart';

void main() {
  DateTime now = DateTime.now();
  test("DateCheckHelper checkIfAfterToday", () {
    expect(DateCheckHelper.checkIfAfterToday(now), false);
  });
  test("DateCheckHelper checkIfBeforeToday", () {
    expect(DateCheckHelper.checkIfBeforeToday(now), false);
  });
  test("DateCheckHelper checkIfToday", () {
    expect(DateCheckHelper.checkIfToday(now), true);
  });
  test("DateCheckHelper checkIfTodayOrAfter", () {
    expect(DateCheckHelper.checkIfTodayOrAfter(now), true);
  });
  test("DateCheckHelper checkIfTodayOrAfter", () {
    expect(DateCheckHelper.checkIfTodayOrBefore(now), true);
  });
}
