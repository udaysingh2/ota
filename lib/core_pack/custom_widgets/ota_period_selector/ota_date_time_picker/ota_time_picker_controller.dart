import 'package:ota/core_components/bloc/bloc.dart';

class OtaTimePickeroController extends Bloc<OtaTimePickerModel> {
  List<int> timeList = List.generate(24, (index) => index);
  @override
  OtaTimePickerModel initDefaultValue() {
    return OtaTimePickerModel(
      selectedHour: 0,
      selectedMinutes: 0,
      kHour24Count: List.generate(24, (index) => index),
    );
  }

  void setSelectedIndex(int selectedHour, int selectedMinutes) {
    state.selectedHour = selectedHour;
    state.selectedMinutes = selectedMinutes;
    emit(state);
  }

  //set selected item in selected index
  void setSelectHourIndex(int selectedHour) {
    state.selectedHour = selectedHour;
    emit(state);
  }

  //set selected item in selected index
  void setSelectMinutesIndex(int selectedMinutes) {
    state.selectedMinutes = selectedMinutes;
    emit(state);
  }

  List<int> setHourRange(DateTime? dateTime) {
    if (dateTime != null && dateTime.isBefore(DateTime.now())) {
      timeList.removeRange(0, timeList[DateTime.now().hour] + 1);
      return timeList;
    }
    return timeList;
  }
}

class OtaTimePickerModel {
  int selectedHour;
  int selectedMinutes;
  List<int> kHour24Count;

  OtaTimePickerModel({
    required this.selectedHour,
    required this.selectedMinutes,
    required this.kHour24Count,
  });
}
