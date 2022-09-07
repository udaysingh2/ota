import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_model.dart';

class OtaTextInputBloc extends Bloc<OtaTextInputModel> {
  @override
  OtaTextInputModel initDefaultValue() {
    return OtaTextInputModel();
  }

  void validInputState() {
    state.otaTextInputState = OtaTextInputState.valid;
    emit(state);
  }

  void errorInputState() {
    state.otaTextInputState = OtaTextInputState.error;
    emit(state);
  }

  void noneInputState() {
    state.otaTextInputState = OtaTextInputState.none;
    emit(state);
  }
}
