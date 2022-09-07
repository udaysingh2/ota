import '../../../../../core_components/bloc/bloc.dart';
import 'car_reservation_info_model.dart';

class CarInfoReservationController extends Bloc<CarInfoReservationModel> {
  @override
  CarInfoReservationModel initDefaultValue() {
    return CarInfoReservationModel();
  }

  void toggle() {
    if (state.state == CarInfoReservationModelState.expanded) {
      emit(CarInfoReservationModel(
          state: CarInfoReservationModelState.collapsed));
    } else {
      emit(CarInfoReservationModel(
          state: CarInfoReservationModelState.expanded));
    }
  }
}
