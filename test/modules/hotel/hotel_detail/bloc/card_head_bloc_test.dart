import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/card_head_bloc.dart';

class MockedScrollBigController extends Mock implements ScrollController {
  @override
  double get offset => 600;
}

class MockedScrollSmallController extends Mock implements ScrollController {
  @override
  double get offset => 100;
}

void main() {
  test('Card Head  Bloc Max Data Test', () async {
    // Build our app and trigger a frame.
    CardHeadBloc cardHeadBloc = CardHeadBloc();
    expect(cardHeadBloc.state.cardHeadBlocState, CardHeadBlocState.sticky);
    cardHeadBloc.setDynamicCardHeadOffset(399);
    expect(cardHeadBloc.state.dynamicCardHeadOffset, 759);
    cardHeadBloc
        .emit(CardHeadBlocModel(cardHeadBlocState: CardHeadBlocState.sticky));
    MockedScrollBigController mockedScrollController =
        MockedScrollBigController();
    cardHeadBloc.setStatusOnScroll(mockedScrollController);
  });

  test('Card Head Bloc Less Data Test', () async {
    // Build our app and trigger a frame.
    CardHeadBloc cardHeadBloc = CardHeadBloc();
    expect(cardHeadBloc.state.cardHeadBlocState, CardHeadBlocState.sticky);
    cardHeadBloc.emit(
        CardHeadBlocModel(cardHeadBlocState: CardHeadBlocState.nonSticky));
    MockedScrollSmallController mockedScrollController =
        MockedScrollSmallController();
    cardHeadBloc.setStatusOnScroll(mockedScrollController);
  });
}
