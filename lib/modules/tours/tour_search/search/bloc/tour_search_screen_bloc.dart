import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/tours/tour_search/search/view_model/tour_search_view_model.dart';

class TourSearchScreenBloc extends Bloc<TourSearchScreenModel> {
  @override
  initDefaultValue() {
    return TourSearchScreenModel();
  }

  void setStateNone() {
    state.tourSearchScreenState = TourSearchScreenState.none;
    emit(state);
  }

  void setStateRecommendations() {
    state.tourSearchScreenState = TourSearchScreenState.recommendations;
    emit(state);
  }

  void setStateSuggestions() {
    state.tourSearchScreenState = TourSearchScreenState.suggestions;
    emit(state);
  }

  bool get isStateNone =>
      state.tourSearchScreenState == TourSearchScreenState.none;

  bool get isStateRecommendations =>
      state.tourSearchScreenState == TourSearchScreenState.recommendations;

  bool get isStateSuggestions =>
      state.tourSearchScreenState == TourSearchScreenState.suggestions;
}
