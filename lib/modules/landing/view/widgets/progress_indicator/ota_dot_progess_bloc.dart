import 'package:ota/core_components/bloc/bloc.dart';
import 'ota_dot_progress_model.dart';

class OtaProgressBloc extends Bloc<OtaDotProgressModel> {
  @override
  OtaDotProgressModel initDefaultValue() {
    return OtaDotProgressModel();
  }

  void setSelected(int selectedIndex) {
    emit(OtaDotProgressModel(selectedIndex: selectedIndex));
  }

  int getSelectedIndex() {
    return state.selectedIndex;
  }
}
