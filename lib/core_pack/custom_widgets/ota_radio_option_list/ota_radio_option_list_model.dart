import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_controller.dart';

class OtaRadioOptionListModel {
  List<OtaRadioButtonController>? otaRadioButtonControllers = [];
  OtaRadioButtonController? otaRadioButtonController;
  int? selectedIndex;
  OtaRadioOptionListModel(
      {this.otaRadioButtonControllers,
      this.otaRadioButtonController,
      this.selectedIndex});
}
