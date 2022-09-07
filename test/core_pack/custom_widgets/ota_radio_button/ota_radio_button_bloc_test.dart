import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';

void main() {
  test("Ota Radio Button Bloc Test", () {
    OtaRadioButtonBloc otaRadioButtonBloc = OtaRadioButtonBloc();
    expect(otaRadioButtonBloc.state.otaRadioButtonState,
        OtaRadioButtonState.unselected);
    otaRadioButtonBloc.select();
    expect(otaRadioButtonBloc.state.otaRadioButtonState,
        OtaRadioButtonState.selected);
    otaRadioButtonBloc.unSelect();
    expect(otaRadioButtonBloc.state.otaRadioButtonState,
        OtaRadioButtonState.unselected);
  });
}
