import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/translation/models/translation_argument_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("Thai Translation Data Model", () {
    testWidgets('Thai Translation Data Model', (WidgetTester tester) async {
      TranslationArgumentModel transOne =
          TranslationArgumentModel(translationType: TranslationType.english);
      expect(transOne.translationType.langCode(), "en");
      TranslationArgumentModel transTwo =
          TranslationArgumentModel(translationType: TranslationType.thai);
      expect(transTwo.translationType.langCode(), "th");
    });
  });
}
