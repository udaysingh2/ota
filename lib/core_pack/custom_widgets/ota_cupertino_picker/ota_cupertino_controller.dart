import 'package:flutter/material.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'ota_cupertino_model.dart';

class OtaCupertinoController extends Bloc<OtaCupertinoModel> {
  @override
  OtaCupertinoModel initDefaultValue() {
    return OtaCupertinoModel(
      pickUpTime: const TimeOfDay(hour: 10, minute: 0),
      dropOffTime: const TimeOfDay(hour: 10, minute: 0),
    );
  }

  void setSelectedIndex(int index) {
    state.index = index;
    emit(state);
  }

  // convert to selected hour and minutes to TimeDay format
  void setSelectedPickUpTimeToDay(int selectedHour, int selectedMinutes) {
    state.pickUpTime = TimeOfDay(hour: selectedHour, minute: selectedMinutes);
    emit(state);
  }

  // convert to selected hour and minutes to TimeDay format
  void setSelectedDropOffTimeToDay(int selectedHour, int selectedMinutes) {
    state.dropOffTime = TimeOfDay(hour: selectedHour, minute: selectedMinutes);
    emit(state);
  }

  //set onpressed item index
  void setSelectedHourIndex(int index) {
    state.dropOfHour = index;
    emit(state);
  }

  //set onpressed item index
  void setSelectedMinutesIndex(int index) {
    state.dropOfMinute = index;
    emit(state);
  }

  //set selected item in selected index
  void setSelectHourIndex(int selectedHour) {
    state.selectedDropOfHour = selectedHour;
    emit(state);
  }

  //set selected item in selected index
  void setSelectMinutesIndex(int selectedMinutes) {
    state.selectedDropOfMinute = selectedMinutes;
    emit(state);
  }

  int getSelectedIndex() {
    return state.index;
  }

  // int getSelectedDropOffIndex() {
  //   return state.index;
  // }

  int getSelectHourIndex() {
    return state.dropOfHour;
  }

  int getSelectMinutesIndex() {
    return state.dropOfMinute;
  }
}
