import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ota/modules/tours/landing/bloc/tour_landing_app_bar_bloc.dart';

class MockedScrollBigController extends Mock implements ScrollController {
  @override
  double get offset => 100;
}

class MockedScrollSmallController extends Mock implements ScrollController {
  @override
  double get offset => 20;
}

void main() {
  test('App Bar Header Max Data Test', () async {
    // Build our app and trigger a frame.
    TourLandingAppBarBloc tourLandingAppBarBloc = TourLandingAppBarBloc();
    expect(tourLandingAppBarBloc.state.tourLandingAppBarBlocState,
        TourLandingAppBarBlocState.opened);
    tourLandingAppBarBloc.setDynamicCardHeadOffset(199);
    expect(tourLandingAppBarBloc.state.dynamicStatusBarOffset, 229);
    tourLandingAppBarBloc.emit(TourLandingAppBarBlocModel(
        tourLandingAppBarBlocState: TourLandingAppBarBlocState.opened));
    MockedScrollBigController mockedScrollController =
        MockedScrollBigController();
    tourLandingAppBarBloc.setStatusOnScroll(mockedScrollController);
  });

  test('App Bar Status Header Less Data Test', () async {
    TourLandingAppBarBloc cardHeadBloc = TourLandingAppBarBloc();
    expect(cardHeadBloc.state.tourLandingAppBarBlocState,
        TourLandingAppBarBlocState.opened);
    cardHeadBloc.emit(TourLandingAppBarBlocModel(
        tourLandingAppBarBlocState: TourLandingAppBarBlocState.closed));
    MockedScrollSmallController mockedScrollController =
        MockedScrollSmallController();
    cardHeadBloc.setStatusOnScroll(mockedScrollController);
  });
}
