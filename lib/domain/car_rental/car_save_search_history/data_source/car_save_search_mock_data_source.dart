import 'package:ota/domain/car_rental/car_save_search_history/data_source/car_save_search_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_argument_domain.dart';
import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_domain_model.dart';

class CarSaveSearchHistoryMockDataSourceImpl
    implements CarSaveSearchHistoryRemoteDataSource {
  CarSaveSearchHistoryMockDataSourceImpl();

  @override
  Future<CarSaveSearchHistoryModelDomain> saveCarSearchHistoryData(
      CarSaveSearchHistoryArgumentDomain argument) async {
    await Future.delayed(const Duration(milliseconds: 1));
    return CarSaveSearchHistoryModelDomain.fromJson(
        _saveSearchHistoryResponseMock);
  }
}

String _saveSearchHistoryResponseMock = '''
  {
    "saveRecentCarRentalSearchHistory": {
      "status": {
        "code": "1000",
        "header": "success",
        "description": "success"
      }
    }
  }
  ''';
