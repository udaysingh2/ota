import 'package:either_dart/either.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/preferences/models/preferences_submit_argument_domain.dart';
import 'package:ota/domain/preferences/models/preferences_submit_model_domain.dart';
import 'package:ota/domain/preferences/usecases/preferences_submit_use_cases.dart';
import 'package:ota/modules/preferences/view_model/preferences_progress_view_model.dart';
import 'package:ota/modules/preferences/view_model/preferences_submit_view_model.dart';

const int _kRetryCount = 3;
const String _kSuccessStatusCode = '1000';

class PreferencesSubmitBloc extends Bloc<PreferencesSubmitViewModel> {
  final PreferencesSubmitUseCases _preferencesSubmitUseCases =
      PreferencesSubmitUseCasesImpl();
  int _retryCount = 0;

  @override
  initDefaultValue() {
    return PreferencesSubmitViewModel();
  }

  void submitPreferencesData(
      List<PreferencesModel>? preferenceModelList) async {
    if (preferenceModelList == null) {
      state.preferencesSubmitStatus = PreferencesSubmitStatus.none;
      emit(state);
    }

    state.preferencesSubmitStatus = PreferencesSubmitStatus.loading;
    emit(state);

    final preferencesSubmitArgument =
        PreferencesSubmitArgumentDomain.fromPreferencesModel(
            preferenceModelList);

    Either<Failure, PreferencesSubmitModelDomain>? result =
        await _preferencesSubmitUseCases
            .submitPreferencesData(preferencesSubmitArgument);
    if (result != null && result.isRight) {
      state.statusCode = result.right.createPreference?.status?.code ?? '';
      state.preferencesSubmitStatus = PreferencesSubmitStatus.success;
      printDebug('success: ${state.statusCode}');
      if (isFailure) _retryCount += 1;
      emit(state);
    } else {
      _retryCount += 1;
      state.preferencesSubmitStatus = PreferencesSubmitStatus.failure;
      printDebug('failure');
      emit(state);
    }
  }

  bool get isLoading =>
      state.preferencesSubmitStatus == PreferencesSubmitStatus.loading;

  bool get isSuccess {
    return state.statusCode == _kSuccessStatusCode &&
        state.preferencesSubmitStatus == PreferencesSubmitStatus.success;
  }

  bool get isFailure {
    return state.preferencesSubmitStatus == PreferencesSubmitStatus.failure ||
        state.statusCode != _kSuccessStatusCode &&
            state.preferencesSubmitStatus == PreferencesSubmitStatus.success;
  }

  bool get isRetryCountReached {
    printDebug('retryCount: $_retryCount');
    return _retryCount == _kRetryCount;
  }
}
