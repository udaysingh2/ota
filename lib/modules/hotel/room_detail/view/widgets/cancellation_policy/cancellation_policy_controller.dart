import 'dart:core';

import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/hotel/room_detail/view/widgets/cancellation_policy/cancellation_policy_model.dart';

class CancellationPolicyController extends Bloc<CancellationPolicyModel> {
  @override
  CancellationPolicyModel initDefaultValue() {
    return CancellationPolicyModel();
  }

  void setfreeCancellation() {
    emit(CancellationPolicyModel(
        cancellationPolicyState: CancellationPolicyState.freeCancellation));
  }

  void setnonRefundable() {
    emit(CancellationPolicyModel(
        cancellationPolicyState: CancellationPolicyState.nonRefundable));
  }

  void setconditionalCancellation() {
    emit(CancellationPolicyModel(
        cancellationPolicyState:
            CancellationPolicyState.conditionalCancellation));
  }
}
