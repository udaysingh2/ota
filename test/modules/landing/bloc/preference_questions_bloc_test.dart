import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/preference_questions/models/preference_questions_model_domain.dart';
import 'package:ota/domain/preference_questions/usecases/preference_questions_use_cases.dart';
import 'package:ota/modules/landing/bloc/preference_questions_bloc.dart';
import 'package:ota/modules/landing/view_model/preference_list_view_model.dart';

import 'mocks/preference_questions_use_cases_mock.dart';

void main() {
  PreferenceQuestionsBloc bloc = PreferenceQuestionsBloc();
  PreferenceQuestionsUseCasesImpl successMock =
      PreferenceQuestionsUseCasesSuccessMock();
  PreferenceQuestionsUseCasesImpl failureMock =
      PreferenceQuestionsUseCasesFailureMock();
  PreferenceQuestionsUseCasesImpl mainPreferenceNULLMock =
      PreferenceQuestionsUseCasesPreferencesNULLMock();
  PreferenceQuestionsUseCasesImpl dataPreferenceNULLMock =
      PreferenceQuestionsUseCasesAllPreferencesNULLMock();

  test('For PreferenceQuestionsBloc class ==> initDefaultValue()', () {
    final actual = bloc.initDefaultValue();

    expect(actual.preferencesListViewModelState,
        PreferencesListViewModelState.none);
  });

  group('For PreferenceQuestionsBloc class ==> getPreferencesData()', () {
    test('If Failure then', () async {
      bloc.preferenceQuestionsUseCases = failureMock;
      await bloc.getPreferencesData();

      Either<Failure, PreferenceQuestionsModelDomainData?>? result =
          await failureMock.getPreferenceData();

      expect(result?.isLeft, true);
      expect(bloc.state.preferencesListViewModelState,
          PreferencesListViewModelState.failure);
    });

    test('if argument has all valid data but main preferences NULL then',
        () async {
      bloc.preferenceQuestionsUseCases = mainPreferenceNULLMock;
      await bloc.getPreferencesData();

      Either<Failure, PreferenceQuestionsModelDomainData?>? result =
          await mainPreferenceNULLMock.getPreferenceData();

      expect(result?.isRight, true);
      expect(bloc.state.preferencesListViewModelState,
          PreferencesListViewModelState.failure);
    });

    test('if argument has all valid data but "data" preferences NULL then',
        () async {
      bloc.preferenceQuestionsUseCases = dataPreferenceNULLMock;
      await bloc.getPreferencesData();

      Either<Failure, PreferenceQuestionsModelDomainData?>? result =
          await dataPreferenceNULLMock.getPreferenceData();

      expect(result?.isRight, true);
    });

    test('if argument has all valid data then', () async {
      bloc.preferenceQuestionsUseCases = successMock;
      await bloc.getPreferencesData();

      Either<Failure, PreferenceQuestionsModelDomainData?>? result =
          await successMock.getPreferenceData();

      expect(result?.isRight, true);
      expect(bloc.state.preferencesListViewModelState,
          PreferencesListViewModelState.success);

      ///shouldShowPreferenceScreen == TRUE
      final actual = bloc.shouldShowPreferenceScreen;
      expect(actual, true);

      /// Setup setPreferenceSubmitSuccess
      bloc.setPreferenceSubmitSuccess();
      expect(bloc.state.preferencesListViewModelState,
          PreferencesListViewModelState.failure);
    });
  });
}
