import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/model/hotel_update.dart';

void main() {
  test("Hotel Update Test", () {
    HotelDetailStatus status = HotelDetailStatus();
    status.updateHotelDetailView();
  });
}
