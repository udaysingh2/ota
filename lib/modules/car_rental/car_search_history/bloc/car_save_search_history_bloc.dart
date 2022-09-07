import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_argument_domain.dart';
import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_domain_model.dart';
import 'package:ota/domain/car_rental/car_save_search_history/usecases/car_save_search_use_cases.dart';
import 'package:ota/modules/car_rental/car_search_history/view_model/car_save_search_history_view_argument_model.dart';
import 'package:ota/modules/car_rental/car_search_history/view_model/car_save_search_history_view_model.dart';

class CarSaveSearchHistoryBloc extends Bloc<CarSaveSearchHistoryViewModel> {
  CarSaveSearchHistoryUseCasesImpl saveSearchHistoryUseCases =
      CarSaveSearchHistoryUseCasesImpl();

  @override
  CarSaveSearchHistoryViewModel initDefaultValue() {
    return CarSaveSearchHistoryViewModel();
  }

  Future<void> saveCarSearchHistoryData(
      CarSaveSearchHistoryViewArgumentModel argumentModel) async {
    state.carSaveSearchHistoryViewModelState =
        CarSaveSearchHistoryViewModelState.none;
    emit(state);

    Either<Failure, CarSaveSearchHistoryModelDomain>? result =
        await saveSearchHistoryUseCases.saveCarSearchHistoryData(
            CarSaveSearchHistoryArgumentDomain.from(
                argumentModel: argumentModel));
    if (result != null && result.isRight) {
      SaveRecentCarRentalSearchHistory saveSearchHistory =
          result.right.saveRecentCarRentalSearchHistory!;

      if (saveSearchHistory.status == null) {
        state.carSaveSearchHistoryViewModelState =
            CarSaveSearchHistoryViewModelState.failure;
        emit(state);
      }
      state.carSaveSearchHistoryViewModelState =
          CarSaveSearchHistoryViewModelState.success;
      emit(state);
    } else {
      state.carSaveSearchHistoryViewModelState =
          CarSaveSearchHistoryViewModelState.failure;
      emit(state);
    }
  }
}
