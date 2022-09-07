import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service_calendar/bloc/addon_service_calendar_bloc.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service_calendar/view_model/addon_service_argument_model.dart';

void main() {
  test("Add on service calendar bloc test", () {
    AddonServiceCalendarBloc addonServiceCalendarBloc =
        AddonServiceCalendarBloc();
    AddonServiceCalendarArgument addonServiceCalendarArgument =
        AddonServiceCalendarArgument(
      title: 'Title',
      description: 'Description',
      price: 10.0,
      checkInDate: DateTime.now().add(const Duration(days: 1)).toString(),
      checkOutDate: DateTime.now().add(const Duration(days: 2)).toString(),
      noOfAdults: 1,
      currency: 'THB',
      uniqueId: 'UniqueId',
      imageUrl: 'ImageUrl',
      isFlight: true,
      preselectedDates: [
        DateTime.now().add(const Duration(days: 1)),
      ],
    );

    addonServiceCalendarBloc
        .setAddOnServiceViewModelData(addonServiceCalendarArgument);

    expect(addonServiceCalendarBloc.state.title, 'Title');
    expect(addonServiceCalendarBloc.state.description, 'Description');

    expect(addonServiceCalendarBloc.state.quantity, 1);
    addonServiceCalendarBloc.updateAddOnServiceQuantity(2);
    expect(addonServiceCalendarBloc.state.quantity, 2);
    expect(addonServiceCalendarBloc.calculateMaxAddOnServiceQuantity, 2);
    expect(addonServiceCalendarBloc.calculateTotalPrice, 20.0);
  });
}
