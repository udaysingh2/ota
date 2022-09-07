import '../../../../../core_components/bloc/bloc.dart';
import '../../view_model/car_reservation_view_model.dart';

class CarReservationCancellationController
    extends Bloc<CancellationPolicyListData> {
  @override
  CancellationPolicyListData initDefaultValue() {
    return CancellationPolicyListData(
        state: CancellationPolicyListModelState.collapsed);
  }

  void toggle() {
    if (state.state == CancellationPolicyListModelState.expanded) {
      emit(CancellationPolicyListData(
          state: CancellationPolicyListModelState.collapsed));
    } else {
      emit(CancellationPolicyListData(
          state: CancellationPolicyListModelState.expanded));
    }
  }
}
