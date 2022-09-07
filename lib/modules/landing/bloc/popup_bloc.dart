import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/popup/models/popup_models.dart';
import 'package:ota/domain/popup/usecases/popup_usecases.dart';
import 'package:ota/modules/landing/helper/landing_page_helper.dart';
import 'package:ota/modules/landing/view_model/popup_view_model.dart';

class PopupBloc extends Bloc<PopupViewModel> {
  PopupUseCases popupUseCases = PopupUseCasesImpl();

  @override
  PopupViewModel initDefaultValue() {
    return PopupViewModel(data: PopupDataModel.setDefault());
  }

  Future<void> getPopupData() async {
    state.popupViewModelState = PopupViewModelState.loading;
    emit(state);

    Either<Failure, PopupModelDomain?>? result =
        (await popupUseCases.getPopup());
    if (result != null && result.isRight) {
      GetPopupsData? getPopupsData = result.right?.getPopups?.data;
      if (getPopupsData?.popups == null || getPopupsData!.popups!.isEmpty) {
        state.popupViewModelState = PopupViewModelState.failure;
      } else {
        state.popupViewModelState = PopupViewModelState.success;
        state.data = LandingPageHelper.generatePopupList(getPopupsData)![0];
      }
      emit(state);
    } else {
      state.popupViewModelState = PopupViewModelState.failure;
      emit(state);
    }
  }
}
