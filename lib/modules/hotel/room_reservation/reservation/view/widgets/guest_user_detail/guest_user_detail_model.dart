import 'package:flutter/material.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_bloc.dart';

class GuestUserDetailModel {
  OtaRadioButtonBloc? otaRadioButtonBloc;
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? mobileNumberController;
  TextEditingController? flightNumberController;
  OtaTextInputBloc? firstNameBloc;
  OtaTextInputBloc? lastNameBloc;
  OtaTextInputBloc? mobileNumberBloc;
  OtaTextInputBloc? flightNumberBloc;
}
