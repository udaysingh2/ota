import 'package:ota/core_components/bloc/bloc.dart';

class HotelLandingFiltersController extends Bloc<String> {
  @override
  String initDefaultValue() {
    return "";
  }

  void setText(String text) {
    emit(text);
  }

  bool isEmpty() {
    return state.isEmpty;
  }
}
