import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/search/ota/view_model/ota_search_screen_model.dart';

class OtaSearchScreenBloc extends Bloc<OtaSearchScreenModel> {
  @override
  initDefaultValue() {
    return OtaSearchScreenModel();
  }

  void setStateNone() {
    state.otaSearchScreenState = OtaSearchScreenState.none;
    emit(state);
  }

  void setStateRecommendations() {
    state.otaSearchScreenState = OtaSearchScreenState.recommendations;
    emit(state);
  }

  void setStateSuggestions() {
    state.otaSearchScreenState = OtaSearchScreenState.suggestions;
    emit(state);
  }

  void setStateResults() {
    state.otaSearchScreenState = OtaSearchScreenState.results;
    emit(state);
  }

  bool get isStateNone =>
      state.otaSearchScreenState == OtaSearchScreenState.none;

  bool get isStateRecommendations =>
      state.otaSearchScreenState == OtaSearchScreenState.recommendations;

  bool get isStateSuggestions =>
      state.otaSearchScreenState == OtaSearchScreenState.suggestions;

  bool get isStateResults =>
      state.otaSearchScreenState == OtaSearchScreenState.results;
}
