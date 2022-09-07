import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/translation/data_sources/translation_remote_data_source.dart';
import 'package:ota/domain/translation/models/english_translation_data_model.dart';
import 'package:ota/domain/translation/models/thai_translation_data_model.dart';
import 'package:ota/domain/translation/models/translation_argument_model.dart';
import 'package:ota/domain/translation/repositories/translation_repository_impl.dart';

class InternetConnectionInfoMocked extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(true);
}

class InternetConnectionInfoMockedFalse extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(false);
}

class ThaiTranslationDataSourceImplMocked
    extends ThaiTranslationDataSourceImpl {
  @override
  Future<T> getTranslation<T>(TranslationArgumentModel argument) async {
    return ThaiTranslationDataModel() as T;
  }
}

class EnglishTranslationDataSourceImplMocked
    extends EnglishTranslationDataSourceImpl {
  @override
  Future<T> getTranslation<T>(TranslationArgumentModel argument) async {
    return EnglishTranslationDataModel() as T;
  }
}

class ThaiTranslationDataSourceImplMockedThrow
    extends ThaiTranslationDataSourceImpl {
  @override
  Future<T> getTranslation<T>(TranslationArgumentModel argument) async {
    throw Exception();
  }
}

class EnglishTranslationDataSourceImplMockedThrow
    extends EnglishTranslationDataSourceImpl {
  @override
  Future<T> getTranslation<T>(TranslationArgumentModel argument) async {
    throw Exception();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group("Thai Translation Data Model", () {
    testWidgets('Thai Translation Data Model', (WidgetTester tester) async {
      TranslationRepository translationRepositoryOne =
          EnglishTranslationRepositoryImpl(
        remoteDataSource: EnglishTranslationDataSourceImplMocked(),
        internetInfo: InternetConnectionInfoMocked(),
      );
      EnglishTranslationRepositoryImpl();
      TranslationRepository translationRepositoryTwo =
          ThaiTranslationRepositoryImpl(
              remoteDataSource: ThaiTranslationDataSourceImplMocked(),
              internetInfo: InternetConnectionInfoMocked());
      ThaiTranslationRepositoryImpl();
      translationRepositoryOne.getTranslation(
          TranslationArgumentModel(translationType: TranslationType.english));
      translationRepositoryTwo.getTranslation(
          TranslationArgumentModel(translationType: TranslationType.thai));
    });

    // test('Thai Translation Data Model', () async {
    //   try {
    //     TranslationRepository translationRepositoryOne =
    //         EnglishTranslationRepositoryImpl(
    //       remoteDataSource: EnglishTranslationDataSourceImplMockedThrow(),
    //       internetInfo: InternetConnectionInfoMocked(),
    //     );
    //     EnglishTranslationRepositoryImpl();
    //     TranslationRepository translationRepositoryTwo =
    //         ThaiTranslationRepositoryImpl(
    //             remoteDataSource: ThaiTranslationDataSourceImplMockedThrow(),
    //             internetInfo: InternetConnectionInfoMocked());
    //     ThaiTranslationRepositoryImpl();
    //
    //     translationRepositoryOne.getTranslation(
    //         TranslationArgumentModel(translationType: TranslationType.english));
    //     translationRepositoryTwo.getTranslation(
    //         TranslationArgumentModel(translationType: TranslationType.thai));
    //   } catch (ex) {}
    // });

    testWidgets('Thai Translation Data Model', (WidgetTester tester) async {
      TranslationRepository translationRepositoryOne =
          EnglishTranslationRepositoryImpl(
        remoteDataSource: EnglishTranslationDataSourceImplMocked(),
        internetInfo: InternetConnectionInfoMockedFalse(),
      );
      EnglishTranslationRepositoryImpl();
      TranslationRepository translationRepositoryTwo =
          ThaiTranslationRepositoryImpl(
              remoteDataSource: ThaiTranslationDataSourceImplMocked(),
              internetInfo: InternetConnectionInfoMockedFalse());
      ThaiTranslationRepositoryImpl();
      translationRepositoryOne.getTranslation(
          TranslationArgumentModel(translationType: TranslationType.english));
      translationRepositoryTwo.getTranslation(
          TranslationArgumentModel(translationType: TranslationType.thai));
    });
  });
}
