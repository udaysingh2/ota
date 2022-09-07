import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/adons_view_model.dart';

void main() {
  test('Add on view model test', () {
    AddonsViewModel addonServiceViewModel = AddonsViewModel();

    expect(
        addonServiceViewModel.addonsNetworkState, AddonsNetworkState.initial);
  });

  test('AddonsModel test', () {
    final actual = AddonsModel(
      isFlight: true,
      uniqueId: '111',
    );

    expect(actual.isFlight, true);
    expect(actual.uniqueId, '111');
    expect(actual.hashCode, 231089141);
  });
}
