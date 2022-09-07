import 'package:ota/domain/tours/search/data_source/tour_save_search_history_remote_data_source.dart';
import 'package:ota/domain/tours/search/model/tour_save_search_history_argument_domain.dart';
import 'package:ota/domain/tours/search/model/tour_save_search_history_model_domain.dart';

class TourSaveSearchHistoryMockDataSourceImpl
    implements TourSaveSearchHistoryRemoteDataSource {
  TourSaveSearchHistoryMockDataSourceImpl();

  @override
  Future<TourSaveSearchHistoryModelDomain> saveTourSearchHistoryData(
      TourSaveSearchHistoryArgumentDomain argument) async {
    await Future.delayed(const Duration(milliseconds: 1));
    return TourSaveSearchHistoryModelDomain.fromJson(
        _saveSearchHistoryResponseMock);
  }
}

String _saveSearchHistoryResponseMock = '''
  {
    "saveRecentTourAndTicketSearchHistory": {
      "status": {
        "code": "1000",
        "header": "success",
        "description": "success"
      }
    }
  }
  ''';
