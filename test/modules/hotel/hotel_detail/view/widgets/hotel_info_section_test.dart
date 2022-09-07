import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/modules/hotel/hotel_detail/bloc/status_bar_bloc.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/hotel_info_section.dart';

import '../../../../../helper/material_wrapper.dart';

void main() {
  HotelInfoSection hotelInfoSection = HotelInfoSection(
    key: const Key('HotelInfoSection'),
    statusBarBloc: StatusBarBloc(),
    ratingText: "1",
  );
  testWidgets('Hotel Info Section Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    Widget widget = getMaterialWrapper(hotelInfoSection);
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  });
}
