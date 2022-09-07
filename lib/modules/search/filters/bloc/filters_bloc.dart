import 'package:ota/core/app_config.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/modules/search/filters/view_model/filter_argument.dart';
import 'package:ota/modules/search/filters/view_model/filter_view_model.dart';

class FiltersBloc extends Bloc<FilterViewModel> {
  @override
  FilterViewModel initDefaultValue() {
    return FilterViewModel(
      checkInDate: DateTime.now(),
      checkOutDate: DateTime.now(),
      roomList: [],
    );
  }

  void setFilterViewModelData(FilterArgument argument) {
    FilterViewModel model = FilterViewModel.mapFilterArgument(argument);
    emit(model);
  }

  void setSelectedCheckInOutPeriod(DateTime inDate, DateTime outDate) {
    state.checkInDate = inDate;
    state.checkOutDate = outDate;
    emit(state);
  }

  void addNewRoom() {
    state.roomList.add(RoomViewModel.newRoom());
    emit(state);
  }

  /// There will be always one default room, can't be removed
  /// Romoving the latest room i.e last item
  void removeRoom() {
    if (state.roomList.isNotEmpty && state.roomList.length > 1) {
      state.roomList.removeLast();
      emit(state);
    }
  }

  int getRoomChildrenCount(int roomIndex) {
    return state.roomList[roomIndex].childAgeList.length;
  }

  void addAdult(int index, int value) {
    state.roomList[index].adults = value;
    _addRemoveBedType(index);
    emit(state);
  }

  void removeAdult(int index, int value) {
    state.roomList[index].adults = value;
    _addRemoveBedType(index);
    emit(state);
  }

  void addChild(int index, int age) {
    state.roomList[index].childAgeList.add(age);
    emit(state);
  }

  void updateChild(int roomIndex, int childIndex, int age) {
    state.roomList[roomIndex].childAgeList[childIndex] = age;
    emit(state);
  }

  /// Lastest added child will be removed
  void removeChild(int index) {
    state.roomList[index].childAgeList.removeLast();
    emit(state);
  }

  void updateBedType(int index, String value) {
    state.roomList[index].bedTypeKey = value;
    emit(state);
  }

  void addBedType(int index) {
    state.roomList[index].bedTypeKey = AppConfig().configModel.defaultBedType;
    emit(state);
  }

  void _addRemoveBedType(int index) {
    if (state.roomList[index].adults ==
        AppConfig().configModel.bedTypeMaxAdults) {
      state.roomList[index].bedTypeKey = AppConfig().configModel.defaultBedType;
    } else {
      state.roomList[index].bedTypeKey = null;
    }
  }

  int getAdultsCount() {
    int adults = 0;
    for (var element in state.roomList) {
      adults += element.adults;
    }
    return adults;
  }

  int getChildrenCount() {
    int children = 0;
    for (var element in state.roomList) {
      children += element.childAgeList.length;
    }
    return children;
  }
}
