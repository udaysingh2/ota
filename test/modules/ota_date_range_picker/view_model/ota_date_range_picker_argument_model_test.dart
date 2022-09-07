import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/ota_date_range_picker/view_model/ota_date_range_picker_argument_model.dart';

void main() {
  test(
    'OtaDateRangerPickerArgumentModel Tests',
        () async {
      OtaDateRangePickerArgumentModel otaDateRangePickerArgumentModel =
      OtaDateRangePickerArgumentModel(
        checkInDate: DateTime.parse('2022-03-04'),
        checkOutDate: DateTime.parse('2022-03-06'),
      );
      expect(otaDateRangePickerArgumentModel.checkInDate, DateTime.parse('2022-03-04'));
      expect(otaDateRangePickerArgumentModel.checkOutDate, DateTime.parse('2022-03-06'));

      OtaDateRangePickerArgumentModel.from(DateTime.parse('2022-03-04'), DateTime.parse('2022-03-06'));
      OtaDateRangePickerArgumentModel.from(null, null);
    },
  );
}
