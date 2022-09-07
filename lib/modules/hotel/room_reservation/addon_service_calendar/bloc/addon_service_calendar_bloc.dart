import 'package:ota/common/utils/helper.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service_calendar/view_model/addon_service_argument_model.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service_calendar/view_model/addon_service_view_model.dart';

const int _kDefaultNoOfAdults = 1;

class AddonServiceCalendarBloc extends Bloc<AddonServiceViewModel> {
  @override
  AddonServiceViewModel initDefaultValue() {
    return AddonServiceViewModel(
      checkInDate: DateTime.now()
          .add(Duration(days: AppConfig().configModel.checkInDeltaHotel)),
      checkOutDate: DateTime.now()
          .add(Duration(days: AppConfig().configModel.checkOutDeltaHotel)),
      serviceSelectedDate: DateTime.now().add(const Duration(days: 1)),
      description: '',
      price: 0,
      title: '',
      noOfAdults: _kDefaultNoOfAdults,
      preselectedDates: [],
      imageUrl: '',
      uniqueId: '',
      isFlight: false,
    );
  }

  void setAddOnServiceViewModelData(AddonServiceCalendarArgument argument) {
    AddonServiceViewModel model =
        AddonServiceViewModel.mapAddOnServiceArgument(argument);
    emit(_setSelectedDate(model));
  }

  void updateAddOnServiceQuantity(int value) {
    state.quantity = value;
    emit(state);
  }

  int get calculateMaxAddOnServiceQuantity {
    return 2 * state.noOfAdults; //Per day
  }

  double get calculateTotalPrice {
    return state.price * state.quantity;
  }

  // Set the pre-selected date
  AddonServiceViewModel _setSelectedDate(AddonServiceViewModel model) {
    model.preselectedDates = List<DateTime>.generate(
        model.preselectedDates.length,
        (index) =>
            Helpers.getOnlyDateFromDateTime(model.preselectedDates[index]));

    // If adding new add-on we need to find the first date that isnt already
    // previously added to the cart
    if (model.serviceSelectedDate == null) {
      if (model.preselectedDates.isEmpty) {
        model.serviceSelectedDate = model.checkInDate;
      } else {
        model.preselectedDates.sort();

        final checkinDate = Helpers.getOnlyDateFromDateTime(model.checkInDate);
        final checkoutDate =
            Helpers.getOnlyDateFromDateTime(model.checkOutDate);
        for (int i = 0;
            i <= checkoutDate.difference(checkinDate).inDays.abs();
            i++) {
          final date = checkinDate.add(Duration(days: i));
          if (!model.preselectedDates.contains(date)) {
            model.serviceSelectedDate = date;
            return model;
          }
        }
      }
    }
    return model;
  }
}
