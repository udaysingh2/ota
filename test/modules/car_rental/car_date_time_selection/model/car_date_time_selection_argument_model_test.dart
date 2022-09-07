import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/car_rental/car_date_time_selection/model/car_date_time_selection_argument_model.dart';

void main() {
  test('Car Date Time Selection Argument Model test', () {
    DateTime dateTime1 = DateTime.now();
    DateTime dateTime2 = DateTime.now().add(const Duration(days: 5));
    CarDateTimePickerArgumentModel(
        dropOffDate: dateTime1, pickUpDate: dateTime2);
    CarDateTimePickerArgumentModel.from(dateTime1, dateTime2);
    CarDateTimePickerArgumentModel.from(null, null);
  });
}
