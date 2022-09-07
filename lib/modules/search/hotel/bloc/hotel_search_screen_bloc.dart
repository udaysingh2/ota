import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/search/hotel/view_model/hotel_search_screen_model.dart';

class HotelSearchScreenBloc extends Bloc<HotelSearchScreenModel> {
  @override
  initDefaultValue() {
    return HotelSearchScreenModel();
  }

  void setStateNone() {
    state.hotelSearchScreenState = HotelSearchScreenState.none;
    emit(state);
  }

  void setStateRecommendations() {
    state.hotelSearchScreenState = HotelSearchScreenState.recommendations;
    emit(state);
  }

  void setStateSuggestions() {
    state.hotelSearchScreenState = HotelSearchScreenState.suggestions;
    emit(state);
  }

  bool get isStateNone =>
      state.hotelSearchScreenState == HotelSearchScreenState.none;

  bool get isStateRecommendations =>
      state.hotelSearchScreenState == HotelSearchScreenState.recommendations;

  bool get isStateSuggestions =>
      state.hotelSearchScreenState == HotelSearchScreenState.suggestions;
}
