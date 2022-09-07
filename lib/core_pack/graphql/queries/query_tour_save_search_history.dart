import 'package:ota/domain/tours/search/model/tour_save_search_history_argument_domain.dart';

class QueriesTourSaveSearchHistory {
  static String saveSearchHistoryData(
      TourSaveSearchHistoryArgumentDomain argument) {
    return '''
mutation
  {
    saveRecentTourAndTicketSearchHistory(
      searchRequest: {
          tourTicketCard: {
          serviceType: "${argument.serviceType}"
          keyword: "${argument.keyword}"
          countryId: "${argument.countryId}"
          cityId: "${argument.cityId}"
          id: "${argument.id}"
          locationName: "${argument.locationName}"
          }
      }
    ) {
      status{
        code
        header
        description
      }
    }
  }
    ''';
  }
}
