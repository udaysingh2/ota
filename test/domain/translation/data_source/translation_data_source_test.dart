import 'package:flutter_test/flutter_test.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/domain/translation/data_sources/translation_remote_data_source.dart';
import 'package:ota/domain/translation/models/translation_argument_model.dart';
import 'package:ota/domain/translation/repositories/translation_repository_impl.dart';

import '../../../modules/hotel/repositories/internet_success_mock.dart';
import 'mock_graphql.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  TranslationRepository translationRepositoryThai =
      ThaiTranslationRepositoryImpl(
          remoteDataSource: ThaiTranslationDataSourceImpl(),
          internetInfo: InternetSuccessMock());
  TranslationRepository translationRepositoryEnglish =
      ThaiTranslationRepositoryImpl(
          remoteDataSource: EnglishTranslationDataSourceImpl(),
          internetInfo: InternetSuccessMock());

  group("Thai Translation Data Model", () {
    GraphQlResponse graphQlResponseEnglish = MockEnglishGraphQl();
    GraphQlResponse graphQlResponseThai = MockThaiGraphQl();

    test(
        'Translation analytics Repository '
        'When calling getGalleryResultModelUrlData '
        'With response data', () async {
      /// Consent user cases impl
      final consentResultThai = await translationRepositoryThai.getTranslation(
          TranslationArgumentModel(translationType: TranslationType.thai));

      expect(consentResultThai.isRight, false);

      /// Consent user cases impl
      final consentResultEnglish = await translationRepositoryEnglish
          .getTranslation(TranslationArgumentModel(
              translationType: TranslationType.english));

      expect(consentResultEnglish.isRight, false);
    });
    test('Thai Translation Data Model', () async {
      TranslationDataSource translationDataSourceEnglish =
          EnglishTranslationDataSourceImpl(
              graphQlResponse: graphQlResponseEnglish);
      translationDataSourceEnglish.getTranslation(
        TranslationArgumentModel(translationType: TranslationType.english),
      );

      TranslationDataSource translationDataSourceThai =
          ThaiTranslationDataSourceImpl(graphQlResponse: graphQlResponseThai);
      translationDataSourceThai.getTranslation(
        TranslationArgumentModel(translationType: TranslationType.thai),
      );
    });
  });
}
