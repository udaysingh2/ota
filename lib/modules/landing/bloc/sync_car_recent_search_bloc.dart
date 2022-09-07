import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/landing/models/sync_car_recent_search_model.dart';
import 'package:ota/domain/landing/usecases/recent_search_save_usecases.dart';
import 'package:ota/modules/car_rental/car_landing/db_models/car_recent_search_model.dart';
import 'package:ota/modules/landing/view_model/sync_car_recent_search_view_model.dart';

const String _kSuccessCode = "1000";
const String _kFailureCode = "1899";

class SyncCarRecentSearchBloc extends Bloc<SyncCarRecentSearchViewModel> {
  SyncCarRecentSearchUseCases recentSearchUseCase =
      SyncCarRecentSearchUseCasesImpl();

  @override
  SyncCarRecentSearchViewModel initDefaultValue() {
    return SyncCarRecentSearchViewModel();
  }

  Future<String> syncRecentDataForGuestUser(
      List<CarRecentSearchData> data,
      String userId,
      String searchKey,
      bool searchAvailableApi,
      bool includeDriver) async {
    Either<Failure, SyncCarRecentSearchDomainModel?>? result =
        await recentSearchUseCase.syncRecentSearchData(
            data, userId, searchKey, searchAvailableApi, includeDriver);
    if (result != null && result.isRight) {
      if (result.right?.saveRecentCarrentalSearch?.status?.code ==
          _kSuccessCode) {
        return _kSuccessCode;
      } else {
        return _kFailureCode;
      }
    } else {
      return _kFailureCode;
    }
  }
}
