import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_screen_suggestion_model.dart';

class CarSearchSuggestionScreenBloc extends Bloc<CarSearchScreenModel> {
  @override
  initDefaultValue() {
    return CarSearchScreenModel();
  }

  void setStateNone() {
    state.carSearchScreenState = CarSearchScreenState.none;
    emit(state);
  }

  void setStateSuggestions() {
    state.carSearchScreenState = CarSearchScreenState.suggestions;
    emit(state);
  }

  void setStateRecommendations() {
    state.carSearchScreenState = CarSearchScreenState.recommendations;
    emit(state);
  }

  bool get isStateRecommendations =>
      state.carSearchScreenState == CarSearchScreenState.recommendations;

  bool get isStateNone =>
      state.carSearchScreenState == CarSearchScreenState.none;

  bool get isStateSuggestions =>
      state.carSearchScreenState == CarSearchScreenState.suggestions;
}
