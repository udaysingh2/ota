import 'package:ota/domain/landing/data_sources/sync_car_recent_remote_data_source.dart';
import 'package:ota/domain/landing/models/sync_car_recent_search_model.dart';
import 'package:ota/modules/car_rental/car_landing/db_models/car_recent_search_model.dart';

class RecentSearchMockDataSourceImpl implements SyncCarRecentRemoteDataSource {
  @override
  Future<SyncCarRecentSearchDomainModel> syncRecentSearchData(
      List<CarRecentSearchData> data,
      String userId,
      String searchKey,
      bool searchAvailableApi,
      bool includeDriver) async {
    await Future.delayed(const Duration(seconds: 1));
    return SyncCarRecentSearchDomainModel.fromJson(res);
  }
}

var res = '''{
  "data": {
    "saveGuestRecentSearchPlaylistHistory": {
      "status": {
        "code": "1000",
        "header": "Success"
      }
    }
  }
}

 ''';
