import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/translation/models/english_translation_data_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("English Translation Data Model", () {
    testWidgets('English Translation Data Model', (WidgetTester tester) async {
      Map<String, dynamic> jsonMap = json
          .decode(fixture("translation/english_translation_data_mock.json"));
      EnglishTranslationDataModel hotel =
          EnglishTranslationDataModel.fromMap(jsonMap);
      EnglishTranslationDataModel.fromJson(hotel.toJson());
      expect(hotel.data?.loadTranslation?.data?.en?.length, 4);
      EnglishTranslationDataModelData.fromJson(hotel.data?.toJson() ?? "");
      LoadTranslation.fromJson(hotel.data?.loadTranslation?.toJson() ?? "");
      LoadTranslationData.fromJson(
          hotel.data?.loadTranslation?.data?.toJson() ?? "");
      En.fromJson(hotel.data?.loadTranslation?.data?.en?.first.toJson() ?? "");
    });
  });
}
