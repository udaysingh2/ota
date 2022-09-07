import 'dart:async';

import 'package:flutter/foundation.dart';

class OtaCountDownController {
  final int durationInSecond;
  late int _counter;
  late ValueNotifier<int> countValue;
  late Timer _timer;
  late DateTime dateTime;
  bool isTimerActive = false;
  bool isTimeOutDisabled = false;
  VoidCallback? onComplete;
  OtaCountDownController({required this.durationInSecond, this.onComplete})
      : _counter = durationInSecond,
        dateTime = DateTime.now() {
    countValue = ValueNotifier(_counter);
  }
  static bool _isMock = false;

  static void setAsMock({bool isMock = true}) {
    _isMock = isMock;
  }

  void showTimeOut() {
    if (!isTimeOutDisabled) onComplete!();
  }

  void reStartTimer() {
    stopTimer();
    startTimer();
  }

  void startTimer() {
    if (isTimerActive) return;
    isTimerActive = true;
    if (_isMock) return;
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      int internalCounter =
          durationInSecond - DateTime.now().difference(dateTime).inSeconds;
      if (_counter > 0) {
        _counter = internalCounter < 0 ? 0 : internalCounter;
        countValue.value = _counter;
      }
      if (_counter == 0) {
        cancelTimer();
        showTimeOut();
      }
    });
  }

  void resetTimer() {
    _counter = durationInSecond;
    dateTime = DateTime.now();
    countValue.value = _counter;
  }

  void stopTimer() {
    resetTimer();
    cancelTimer();
  }

  void cancelTimer() {
    if (isTimerActive) {
      isTimerActive = false;
      if (_isMock) return;
      _timer.cancel();
    }
  }

  void dispose() {
    cancelTimer();
    countValue.dispose();
  }
}
