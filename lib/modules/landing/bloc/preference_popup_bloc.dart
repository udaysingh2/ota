import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/preference_popup/usecases/preference_popup_usecase.dart';
import 'package:ota/modules/landing/view_model/popup_view_model.dart';

class PreferencePopUpBloc extends Bloc<PopupViewModel> {
  PreferencePopUpUseCases preferencePopUpUseCase =
      PreferencePopUpUseCasesImpl();

  @override
  PopupViewModel initDefaultValue() {
    return PopupViewModel(data: PopupDataModel.setDefault());
  }

  Future<void> updatePopUpState(String id, String type, String endDate) async {
    Either<Failure, bool?>? result =
        await preferencePopUpUseCase.getPopUpState(id, type, endDate);
    if (result != null && result.isRight) {
      emit(state);
      return;
    }
  }
}
