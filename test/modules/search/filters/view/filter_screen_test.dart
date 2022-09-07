import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_button.dart';
import 'package:ota/modules/search/filters/view/widgets/filter_tile_widget.dart';
import 'package:ota/modules/search/filters/view_model/filter_argument.dart';

import '../../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';

void main() {
  setUp(() async {
    initializeDateFormatting();
  });

  testWidgets(
    'Filter Screen',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(builder: (context) {
              return TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.filterScreen,
                        arguments: FilterArgument.fromHotelDetailArguments(
                            getHotelDetailArgumentMock()));
                  },
                  child: const Text("test"));
            }),
          ),
          routes: AppRoutes.getRoutes(),
        ),
      );
      await tester.pump();
      await tester.tap(find.text("test"));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(OtaTextButton));
      await tester.pump();
      expect(find.byType(FilterTileWidget), findsWidgets);
      await tester.tap(find.byKey(const Key("showCalender")));
      await tester.pump(); 
    },
  );
}
