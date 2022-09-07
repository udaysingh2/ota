import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/translation/models/thai_translation_data_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("Thai Translation Data Model", () {
    testWidgets('Thai Translation Data Model', (WidgetTester tester) async {
      Map<String, dynamic> jsonMap =
          json.decode(fixture("translation/thai_translation_data_mock.json"));
      ThaiTranslationDataModel hotel =
          ThaiTranslationDataModel.fromMap(jsonMap);
      ThaiTranslationDataModel.fromJson(hotel.toJson());
      expect(hotel.data?.loadTranslation?.data?.th?.length, 4);
      ThaiTranslationDataModelData.fromJson(hotel.data?.toJson() ?? "");
      LoadTranslation.fromJson(hotel.data?.loadTranslation?.toJson() ?? "");
      LoadTranslationData.fromJson(
          hotel.data?.loadTranslation?.data?.toJson() ?? "");
      Th.fromJson(hotel.data?.loadTranslation?.data?.th?.first.toJson() ?? "");
    });
  });
}
