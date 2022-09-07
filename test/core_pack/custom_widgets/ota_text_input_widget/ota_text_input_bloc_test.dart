import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_model.dart';

void main() {
  test("Ota Text Input Bloc Test", () {
    OtaTextInputBloc bloc = OtaTextInputBloc();
    expect(bloc.state.otaTextInputState, OtaTextInputState.valid);
    bloc.errorInputState();
    expect(bloc.state.otaTextInputState, OtaTextInputState.error);
    bloc.validInputState();
    expect(bloc.state.otaTextInputState, OtaTextInputState.valid);
  });
}
