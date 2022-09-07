import 'package:ota/core_components/bloc/bloc.dart';

class HotelPaymentMinMaxBloc extends Bloc<HotelPaymentMinMaxState> {
  @override
  HotelPaymentMinMaxState initDefaultValue() {
    return HotelPaymentMinMaxState.isCollapsed;
  }

  void toggle() {
    if (state == HotelPaymentMinMaxState.isCollapsed) {
      emit(HotelPaymentMinMaxState.isExpanded);
    } else {
      emit(HotelPaymentMinMaxState.isCollapsed);
    }
  }

  void setMinimised() {
    emit(HotelPaymentMinMaxState.isCollapsed);
  }

  void setMaximised() {
    emit(HotelPaymentMinMaxState.isExpanded);
  }
}

enum HotelPaymentMinMaxState {
  isExpanded,
  isCollapsed,
}
