import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/preferences/helpers/preferences_helper.dart';
import 'package:ota/modules/preferences/view_model/preferences_argument_model.dart';
import 'package:ota/modules/preferences/view_model/preferences_progress_view_model.dart';

const _kMinSelected = 1;

class PreferencesProgressBloc extends Bloc<PreferencesProgressViewModel> {
  @override
  initDefaultValue() {
    return PreferencesProgressViewModel(preferenceModelList: []);
  }

  void initPreferences(List<PreferencesArgumentModel>? argumentModelList) {
    state.preferenceModelList =
        PreferencesHelper.getPreferenceList(argumentModelList);
    emit(state);
  }

  void moveToNextQuestion() {
    if (currentQuestionNumber < questionsCount) {
      state.currentQuestionNumber++;
      emit(state);
    }
  }

  void moveToPreviousQuestion() {
    if (currentQuestionNumber <= questionsCount && currentQuestionNumber > 1) {
      state.currentQuestionNumber--;
      emit(state);
    }
  }

  void updateCurrentQuestionOptionSelection(int index, bool selected) {
    if (isMultiChoice) {
      currentOptionList[index].isSelected = selected;
      selected
          ? currentPreferencesModel.selectedOptions++
          : currentPreferencesModel.selectedOptions--;
    } else {
      for (int i = 0; i < currentOptionsCount; i++) {
        currentOptionList[i].isSelected = i == index ? true : false;
        if (currentOptionList[i].isSelected) {
          currentPreferencesModel.selectedOptions = _kMinSelected;
        }
      }
    }
    emitWithNoStateUpdate(state);
  }

  bool get isCurrentQuestionOptionSelected {
    return isMultiChoice
        ? currentPreferencesModel.selectedOptions >=
            currentPreferencesModel.minNum
        : currentPreferencesModel.selectedOptions == _kMinSelected;
  }

  int get questionsCount => state.preferenceModelList.length;

  bool get isLastQuestion => currentQuestionNumber == questionsCount;

  bool get isMultiChoice => currentPreferencesModel.multiChoice;

  bool get isGridView => currentOptionList.isNotEmpty
      ? currentOptionList[0].imageUrl.isNotEmpty
      : false;

  String get currentQuestionImageUrl =>
      currentPreferencesModel.backgroundImageUrl;

  PreferencesModel get currentPreferencesModel =>
      state.preferenceModelList[currentQuestionNumber - 1];

  int get currentQuestionNumber => state.currentQuestionNumber;

  String get currentQuestion => currentPreferencesModel.description1;

  String get currentQuestionDesc => currentPreferencesModel.description2;

  List<OptionModel> get currentOptionList => currentPreferencesModel.options;

  int get currentOptionsCount => currentOptionList.length;
}
