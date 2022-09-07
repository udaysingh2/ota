import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/page_view_indicator/page_view_indicator_bloc.dart';

void main() {
  test('Page View Indicator Bloc Test', () async {
    // Build our app and trigger a frame.
    PageViewIndicatorBloc pageController = PageViewIndicatorBloc();
    expect(pageController.state, 0);
    pageController.onIndexChanged(1);
    await Future.delayed(const Duration(milliseconds: 100));
    expect(pageController.state, 1);
  });
}
