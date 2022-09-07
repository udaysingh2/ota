import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/translation/models/english_translation_data_model.dart';
import 'package:ota/domain/translation/models/thai_translation_data_model.dart';
import 'package:ota/domain/translation/models/translation_argument_model.dart';
import 'package:ota/domain/translation/repositories/translation_repository_impl.dart';
import 'package:ota/domain/translation/usecases/translation_use_cases.dart';

class MockedEnglishTranslationRepository
    extends EnglishTranslationRepositoryImpl {
  @override
  Future<Either<Failure, T>> getTranslation<T>(
      TranslationArgumentModel argument) async {
    return Right(EnglishTranslationDataModel() as T);
  }
}

class MockedThaiTranslationRepository extends EnglishTranslationRepositoryImpl {
  @override
  Future<Either<Failure, T>> getTranslation<T>(
      TranslationArgumentModel argument) async {
    return Right(ThaiTranslationDataModel() as T);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("Thai Translation Data Model", () {
    testWidgets('Thai Translation Data Model', (WidgetTester tester) async {
      MockedEnglishTranslationRepository mockE =
          MockedEnglishTranslationRepository();
      MockedThaiTranslationRepository mockT = MockedThaiTranslationRepository();
      TranslationUseCasesImpl();
      TranslationUseCases translationUseCases = TranslationUseCasesImpl(
        englishRepository: mockE,
        thaiRepository: mockT,
      );
      translationUseCases.getTranslation();
    });
  });
}
