import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/status_bar_bloc.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/hotel_slider_bottom.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/page_view_indicator/page_view_indicator.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/slider_gallery_button.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  testWidgets('Hotel Slider Bottom Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(
      HotelSliderBottom(
        galleryButtonText: '',
        statusBarBloc: StatusBarBloc(),
        detailsBorder: 1,
        pageController: PageController(),
        sliderItemCount: 2,
      ),
    );
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    expect(find.byType(SliderGalleryButton), findsOneWidget);
    expect(find.byType(PageViewIndicator), findsNothing);
  });
}
