import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/preference_questions/models/preference_questions_model_domain.dart';
import 'package:ota/domain/preference_questions/usecases/preference_questions_use_cases.dart';
import 'package:ota/modules/landing/helper/landing_page_helper.dart';
import 'package:ota/modules/landing/view_model/preference_list_view_model.dart';

class PreferenceQuestionsBloc extends Bloc<PreferenceListViewModel> {
  PreferenceQuestionsUseCases preferenceQuestionsUseCases =
      PreferenceQuestionsUseCasesImpl();

  @override
  PreferenceListViewModel initDefaultValue() {
    return PreferenceListViewModel(preferencesList: []);
  }

  Future<void> getPreferencesData() async {
    state.preferencesListViewModelState = PreferencesListViewModelState.loading;
    emit(state);

    Either<Failure, PreferenceQuestionsModelDomainData?>? result =
        await preferenceQuestionsUseCases.getPreferenceData();

    if (result != null && result.isRight) {
      if (result.right?.getPreferences == null) {
        state.preferencesListViewModelState =
            PreferencesListViewModelState.failure;
        emit(state);
        return;
      }
      state.preferencesListViewModelState =
          PreferencesListViewModelState.success;
      if (result.right?.getPreferences?.data?.preferences != null) {
        state.preferencesList = LandingPageHelper.generatePreferencesList(
            result.right?.getPreferences?.data?.preferences)!;
      } else {
        state.preferencesList = [];
      }
      emit(state);
    } else {
      state.preferencesListViewModelState =
          PreferencesListViewModelState.failure;
      emit(state);
    }
  }

  bool get shouldShowPreferenceScreen => state.preferencesList.isNotEmpty;

  void setPreferenceSubmitSuccess() {
    state.preferencesList = [];
    state.preferencesListViewModelState = PreferencesListViewModelState.failure;
  }
}
