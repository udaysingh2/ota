import 'package:ota/common/utils/helper.dart';
import 'package:ota/domain/tours/search_result/models/tour_search_result_argument_domain.dart'
    as filter_argument;
import 'package:ota/domain/tours/search_result/models/tour_search_result_model_domain.dart';
import 'package:ota/modules/tours/tour_search/results/view_model/tour_search_result_argument_model.dart';
import 'package:ota/modules/tours/tour_search/results/view_model/tour_search_result_view_model.dart';

const String _kTourKey = "tour";
const String _kTicketKey = "ticket";

class TourSearchResultHelper {
  static List<TourSearchResultModel> getTourSearchResultModelList(
      List<TourAndTicketActivityList>? list) {
    List<TourSearchResultModel>? tourTicketSearchList;
    if (list == null || list.isEmpty) return [];

    tourTicketSearchList = List<TourSearchResultModel>.generate(
      list.length,
      (index) {
        return TourSearchResultModel.fromSearchModelDomain(
          list[index],
        );
      },
    );
    return tourTicketSearchList.toList();
  }

  static DateTime getServiceDate(TourSearchResultArgumentModel argument) {
    return argument.serviceDate ?? DateTime.now().add(const Duration(days: 1));
  }

  static bool isDateSelected(TourSearchResultArgumentModel argument) {
    return argument.serviceDate != null;
  }

  static String? getSelectedDate(DateTime? selectedDate) {
    if (selectedDate != null) return Helpers.getwwddMMMyyyy(selectedDate);
    return null;
  }

  static filter_argument.Filter getFilter(
      TourSearchResultArgumentModel argument) {
    filter_argument.Filter filter;
    if (argument.playlistName.toLowerCase() == _kTourKey) {
      filter = argument.tourfilterModel == null
          ? filter_argument.Filter.toDefault(argument)
          : filter_argument.Filter.formArgumentModel(
              argument.tourfilterModel!, isDateSelected(argument));
    } else if (argument.playlistName.toLowerCase() == _kTicketKey) {
      filter = argument.ticketfilterModel == null
          ? filter_argument.Filter.toDefault(argument)
          : filter_argument.Filter.formArgumentModel(
              argument.ticketfilterModel!, isDateSelected(argument));
    } else {
      filter = filter_argument.Filter.toDefault(argument);
    }
    return filter;
  }
}
