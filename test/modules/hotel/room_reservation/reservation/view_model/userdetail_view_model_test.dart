

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/userdetail_view_model.dart';

void main() {
  test('For UserDetailViewModel class Test', (){
    final actual = UserDetailViewModel(
      secondName: '',
      mobileNumber: '',
      email: '',
      firstName: '',
      buttonState: OtaRadioButtonState.selected,
    );

    expect(actual.buttonState, OtaRadioButtonState.selected);
  });
}