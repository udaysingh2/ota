
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/your_list_view_model.dart';

void main() {
  test('For YourListViewModel class Test', (){
    final actual = YourListViewModel();

    expect(actual.yourListViewModelState, YourListViewModelState.initial);
  });
}