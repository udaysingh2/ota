import 'package:ota/core_components/bloc/bloc.dart';
import 'ota_search_input_view_model.dart';

class OtaSearchInputBloc extends Bloc<OtaSearchInputModel> {
  @override
  OtaSearchInputModel initDefaultValue() {
    return OtaSearchInputModel();
  }

  void setStateEmpty() {
    state.tourSearchScreenState = OtaSearchInputState.empty;
    emit(state);
  }

  void setStateNotEmpty() {
    state.tourSearchScreenState = OtaSearchInputState.notEmpty;
    emit(state);
  }
}
