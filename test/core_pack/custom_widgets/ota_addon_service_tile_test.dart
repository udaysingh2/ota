import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_pack/custom_widgets/ota_addon_service_tile.dart';

void main() {
  testWidgets('hotel addon service tile ...', (tester) async {
    initializeDateFormatting('th');
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OtaHotelAddonServiceTile(
            name: 'Spa Aroma',
            price: 350,
            currency: AppConfig().currency,
            quantity: '1',
            requestDate: DateTime.now(),
            showHeader: true,
            onAddItemsTap: () {},
            onEditTap: () {},
          ),
        ),
      ),
    );
  });
}
