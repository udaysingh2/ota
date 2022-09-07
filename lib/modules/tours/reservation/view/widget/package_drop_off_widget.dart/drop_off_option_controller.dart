import 'package:ota/core_components/bloc/bloc.dart';

class DropOffController extends Bloc<DropOffModel> {
  @override
  DropOffModel initDefaultValue() {
    return DropOffModel(chosenOption: -1);
  }

  void updateChosenOption(int chosenOption) {
    state.chosenOption = chosenOption;
    emit(state);
    return;
  }
}

class DropOffModel {
  int chosenOption;
  DropOffModel({required this.chosenOption});
}
