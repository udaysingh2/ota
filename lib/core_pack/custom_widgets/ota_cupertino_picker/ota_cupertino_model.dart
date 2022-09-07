import 'package:flutter/material.dart';

class OtaCupertinoModel {
  int index;
  int dropOfHour;
  int dropOfMinute;
  int? selectedDropOfHour;
  int? selectedDropOfMinute;
  int? maxhour;
  int? maxminutes;
  //* PickUp
  int pickUpHour;
  int pickUpMinute;
  int? selectedPickUpHour;
  int? selectedPickUpMinute;
  TimeOfDay? pickUpTime;
  TimeOfDay? dropOffTime;
  OtaCupertinoModel({
    this.index = 0,
    this.dropOfHour = 10,
    this.dropOfMinute = 00,
    this.maxhour = 24,
    this.maxminutes = 30,
    this.selectedDropOfHour,
    this.selectedDropOfMinute,
    this.pickUpHour = 10,
    this.pickUpMinute = 00,
    this.selectedPickUpHour,
    this.selectedPickUpMinute,
    this.dropOffTime,
    this.pickUpTime,
  });
}
