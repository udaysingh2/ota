import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/your_list_view_model.dart';

void main() {
  test('Your List View Test constructor', () {
    YourListViewModel yourListViewModel = YourListViewModel();
    expect(yourListViewModel.hotelName, '');
    expect(yourListViewModel.cancellationPolicy, '');
    expect(yourListViewModel.nights, 0);
    expect(yourListViewModel.categoriesList, []);
    expect(yourListViewModel.facilitiesList, []);
    expect(yourListViewModel.imageUrl, '');
    expect(yourListViewModel.totalPrice, '0');
    expect(yourListViewModel.yourListViewModelState,
        YourListViewModelState.initial);
    expect(yourListViewModel.roomTitle, '');
  });
  test('Your List View Model Test constructor with static data', () {
    YourListViewModel yourListViewModel = YourListViewModel();
    yourListViewModel.hotelName = 'hotel_name';
    yourListViewModel.cancellationPolicy = 'cancellation_policy';
    yourListViewModel.nights = 2;
    yourListViewModel.roomTitle = 'room_title';
    yourListViewModel.imageUrl = 'image_url';
    yourListViewModel.totalPrice = '10000';
    yourListViewModel.yourListViewModelState = YourListViewModelState.loaded;
    expect(yourListViewModel.hotelName, "hotel_name");
    expect(yourListViewModel.nights, 2);
    expect(yourListViewModel.cancellationPolicy, 'cancellation_policy');
    expect(yourListViewModel.roomTitle, 'room_title');
    expect(yourListViewModel.yourListViewModelState,
        YourListViewModelState.loaded);
  });
}
