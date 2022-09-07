import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/helpers/car_cancellation_reason_helper.dart';
import 'package:ota/modules/car_rental/car_booking_cancellation/view_model/cancellation_reason_view_model.dart';

class CancellationReasonBloc extends Bloc<CancellationReasonViewModel> {
  @override
  initDefaultValue() {
    CancellationReasonViewModel cancellationReasonViewModel =
        CancellationReasonViewModel(
            cancellationReason:
                CancellationReasonsHelper.cancellationReasons[0],
            isSelected: false);
    return cancellationReasonViewModel;
  }

  setCancellationReason(
      {int? index, required bool isSelected, required String reason}) {
    state.cancellationReason = reason;
    state.isSelected = isSelected;
    emit(state);
  }
}
