import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/landing/models/sync_car_recent_search_model.dart';
import 'package:ota/domain/landing/repositories/landing_page_repository_impl.dart';
import 'package:ota/domain/landing/repositories/recent_search_repository_impl.dart';
import 'package:ota/modules/car_rental/car_landing/db_models/car_recent_search_model.dart';

abstract class SyncCarRecentSearchUseCases {
  Future<Either<Failure, SyncCarRecentSearchDomainModel?>?>?
      syncRecentSearchData(List<CarRecentSearchData> data, String userId,
          String searchKey, bool searchAvailableApi, bool includeDriver);
}

class SyncCarRecentSearchUseCasesImpl implements SyncCarRecentSearchUseCases {
  SyncRecentSearchRepository? syncRecentSearchRepository;

  SyncCarRecentSearchUseCasesImpl({LandingPageRepository? repository}) {
    if (repository == null) {
      syncRecentSearchRepository = SyncRecentSearchRepositoryImpl();
    } else {
      syncRecentSearchRepository = syncRecentSearchRepository;
    }
  }

  @override
  Future<Either<Failure, SyncCarRecentSearchDomainModel?>?>?
      syncRecentSearchData(List<CarRecentSearchData> data, String userId,
          String searchKey, bool searchAvailableApi, bool includeDriver) async {
    return await syncRecentSearchRepository?.syncRecentSearchData(
        data, userId, searchKey, searchAvailableApi, includeDriver);
  }
}
