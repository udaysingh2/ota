import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';

class OtaRadioButtonBloc extends Bloc<OtaRadioButtonModel> {
  @override
  OtaRadioButtonModel initDefaultValue() {
    return OtaRadioButtonModel();
  }

  void unSelect() {
    state.otaRadioButtonState = OtaRadioButtonState.unselected;
    emit(state);
  }

  void select() {
    state.otaRadioButtonState = OtaRadioButtonState.selected;
    emit(state);
  }
}
