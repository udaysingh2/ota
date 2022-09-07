import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/filter_view_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_argument_model.dart';

class FilterViewBloc extends Bloc<FilterViewModel> {
  @override
  FilterViewModel initDefaultValue() {
    return FilterViewModel();
  }

  void getFromArgument(
      ReservationArgumentModel? reservationArgumentModel) async {
    state.filterViewModelDataState = FilterViewModelDataState.loading;
    emit(state);
    if (reservationArgumentModel == null) return;
    state.toDate = reservationArgumentModel.toDate;
    state.fromDate = reservationArgumentModel.fromDate;
    state.childCount = reservationArgumentModel.getChildCount().toString();
    state.adultsCount = reservationArgumentModel.getAdultCount().toString();
    state.roomCount = reservationArgumentModel.rooms.length.toString();
    updateIfFromArgument(
        reservationArgumentModel.fromDate, reservationArgumentModel.toDate);
    state.filterViewModelDataState =
        FilterViewModelDataState.loadedFromArgument;
    emit(state);
  }

  void updateNightCountFromServer(String nightCount) async {
    state.nightsCount = state.nightsCount;
    state.filterViewModelDataState = FilterViewModelDataState.loadedFromServer;
    emit(state);
  }

  void updateIfFromArgument(DateTime fromDay, DateTime toDay) {
    if (state.filterViewModelDataState ==
        FilterViewModelDataState.loadedFromServer) {
      return;
    }
    state.nightsCount = getDayDifference(fromDay, toDay).toString();
  }

  int getDayDifference(DateTime fromDay, DateTime toDay) {
    return Helpers.getOnlyDateFromDateTime(toDay).difference(Helpers.getOnlyDateFromDateTime(fromDay)).inDays;
  }
}
