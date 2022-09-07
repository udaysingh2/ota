import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_controller.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_option_list/ota_radio_option_list_model.dart';

class OtaRadioOptionListBloc extends Bloc<OtaRadioOptionListModel> {
  @override
  OtaRadioOptionListModel initDefaultValue() {
    return OtaRadioOptionListModel();
  }

  void createRadioButtonList(List<String> list) {
    state.otaRadioButtonControllers ??= [];
    state.otaRadioButtonControllers?.clear();
    for (int i = 0; i < list.length; i++) {
      state.otaRadioButtonControllers?.add(OtaRadioButtonController());
    }
  }

  void unSelect() {
    if (state.otaRadioButtonController != null) {
      state.otaRadioButtonController?.setUnSelected();
    }
  }

  void setSelected(int selectedIndex, OtaRadioButtonController controller) {
    emit(OtaRadioOptionListModel(
        otaRadioButtonController: controller, selectedIndex: selectedIndex));
  }

  void onRadioButtonClicked(int index) {
    for (OtaRadioButtonController item
        in state.otaRadioButtonControllers ?? []) {
      item.setUnSelected();
    }

    state.otaRadioButtonControllers?[index].setSelected();
    emit(state);
  }
}
