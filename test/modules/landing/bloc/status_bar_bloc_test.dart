import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ota/modules/landing/bloc/status_bar_bloc.dart';

class MockedScrollBigController extends Mock implements ScrollController {
  @override
  double get offset => 600;
}

class MockedScrollSmallController extends Mock implements ScrollController {
  @override
  double get offset => 100;
}

void main() {
  test('Status Header Max Data Test', () async {
    // Build our app and trigger a frame.
    StatusBarBloc statusBarBloc = StatusBarBloc();
    expect(statusBarBloc.state.statusBarBlocState, StatusBarBlocState.opened);
    statusBarBloc.setDynamicCardHeadOffset(399);
    expect(statusBarBloc.state.dynamicStatusBarOffset, 499);
    statusBarBloc.emit(
        StatusBarBlocModel(statusBarBlocState: StatusBarBlocState.opened));
    MockedScrollBigController mockedScrollController =
        MockedScrollBigController();
    statusBarBloc.setStatusOnScroll(mockedScrollController);
  });

  test('Status Header Less Data Test', () async {
    // Build our app and trigger a frame.
    StatusBarBloc cardHeadBloc = StatusBarBloc();
    expect(cardHeadBloc.state.statusBarBlocState, StatusBarBlocState.opened);
    cardHeadBloc.emit(
        StatusBarBlocModel(statusBarBlocState: StatusBarBlocState.closing));
    MockedScrollSmallController mockedScrollController =
        MockedScrollSmallController();
    cardHeadBloc.setStatusOnScroll(mockedScrollController);
  });
}
