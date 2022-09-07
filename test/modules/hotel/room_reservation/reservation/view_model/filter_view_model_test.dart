import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/filter_view_model.dart';

void main() {
  test('Filter view model test', () {
    FilterViewModel addonsModel = FilterViewModel();
    expect(addonsModel.childCount, "0");
  });
}
