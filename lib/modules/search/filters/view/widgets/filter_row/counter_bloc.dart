import 'package:ota/core/app_config.dart';
import 'package:ota/core_components/bloc/bloc.dart';

enum CounterEvent { increment, decrement }
enum FilterRowType { room, adult, child, hotelAddonService, bookingCalendar }
const int _kMinRooms = 1;
const int _kMinAdultsPerRoom = 1;
const int _kMinChidrenPerRoom = 0;
const int _kMinServiceQuantity = 0;

class CounterBloc extends Bloc<CounterBlocModel> {
  final FilterRowType filterRowWidgetType;
  final int initialValue;
  final int? maxValue;
  final int? minValue;

  CounterBloc(this.filterRowWidgetType, this.initialValue, this.maxValue,
      {this.minValue}) {
    state.value = initialValue;
  }

  void valueChanged(CounterEvent event) {
    switch (event) {
      case CounterEvent.decrement:
        if (state.value > minLimit) {
          state.value--;
          emit(state);
        }
        break;
      case CounterEvent.increment:
        if (state.value < maxLimit) {
          state.value++;
          emit(state);
        }
        break;
    }
  }

  @override
  CounterBlocModel initDefaultValue() {
    return CounterBlocModel();
  }

  int get maxLimit {
    switch (filterRowWidgetType) {
      case FilterRowType.room:
        return AppConfig().configModel.maxRoom;
      case FilterRowType.adult:
        return AppConfig().configModel.maxAdultsAllowed;
      case FilterRowType.child:
        return AppConfig().configModel.maxChildrenAllowed;
      case FilterRowType.hotelAddonService:
      case FilterRowType.bookingCalendar:
        return maxValue ?? 0;
      default:
        return AppConfig().configModel.maxRoom;
    }
  }

  int get minLimit {
    switch (filterRowWidgetType) {
      case FilterRowType.room:
        return _kMinRooms;
      case FilterRowType.adult:
        return _kMinAdultsPerRoom;
      case FilterRowType.child:
        return _kMinChidrenPerRoom;
      case FilterRowType.hotelAddonService:
        return _kMinServiceQuantity;
      case FilterRowType.bookingCalendar:
        return minValue ?? 0;
      default:
        return AppConfig().configModel.maxRoom;
    }
  }
}

class CounterBlocModel {
  CounterEvent counterEvent;
  int value;
  CounterBlocModel({
    this.counterEvent = CounterEvent.increment,
    this.value = 0,
  });
}
