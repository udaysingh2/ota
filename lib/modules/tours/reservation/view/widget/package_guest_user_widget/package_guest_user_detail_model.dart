import 'package:flutter/cupertino.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_bloc.dart';

class PackageGuestUserDetailModel {
  OtaRadioButtonBloc? otaRadioButtonBloc;
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? mobileNumberController;
  OtaTextInputBloc? firstNameBloc;
  OtaTextInputBloc? lastNameBloc;
  OtaTextInputBloc? mobileNumberBloc;
}
