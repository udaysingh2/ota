import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/secondary_view_model.dart';

void main() {
  test('Secondary Room Model Test constructor', () {
    SecondaryViewModel secondaryViewModel = SecondaryViewModel(
        supplierId: '123',
        supplierName: 'Mark All Services Co., Ltd',
        roomCode: "dsc",
        roomName: 'Test',
        roomType: 'Superior',
        totalPrice: 1000,
        nightPrice: 500,
        supplier: '');
    expect(secondaryViewModel.roomOffer, null);
    expect(secondaryViewModel.facilityList, null);
  });
  test('Secondary Room Model Test constructor with static data', () {
    SecondaryViewModel suggetionViewModel = SecondaryViewModel(
      supplierId: '123',
      supplierName: 'Mark All Services Co., Ltd',
      roomCode: "fde",
      roomName: 'Test',
      roomType: 'Superior',
      totalPrice: 1000,
      nightPrice: 500,
      roomOffer: RoomOffers(
          cancellationPolicy: "cancellationPolicy",
          payNow: "pay now",
          breakfast: 1),
      facilityList: {"WIFI": "1", "SPA": "0"},
      supplier: '',
    );
    expect(suggetionViewModel.roomName, "Test");
    expect(suggetionViewModel.roomType, "Superior");
    expect(suggetionViewModel.totalPrice, 1000);
    expect(suggetionViewModel.nightPrice, 500);
    expect(suggetionViewModel.facilityList?["WIFI"], "1");
    expect(
        suggetionViewModel.roomOffer?.cancellationPolicy, "cancellationPolicy");
  });
}
