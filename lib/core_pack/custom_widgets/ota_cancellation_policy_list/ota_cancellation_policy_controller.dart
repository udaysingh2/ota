import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_cancellation_policy_list/ota_cancellation_policy_model.dart';

class OtaCancellationPolicyController
    extends Bloc<OtaCancellationPolicyListModel> {
  @override
  OtaCancellationPolicyListModel initDefaultValue() {
    return OtaCancellationPolicyListModel();
  }

  void toggle() {
    if (state.state == OtaCancellationPolicyListModelState.collapsed) {
      state.state = OtaCancellationPolicyListModelState.expanded;
    } else if (state.state == OtaCancellationPolicyListModelState.expanded) {
      state.state = OtaCancellationPolicyListModelState.collapsed;
    }
    emit(state);
  }
}
