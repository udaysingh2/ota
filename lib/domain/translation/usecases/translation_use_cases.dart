import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/translation/models/english_translation_data_model.dart';
import 'package:ota/domain/translation/models/thai_translation_data_model.dart';
import 'package:ota/domain/translation/models/translation_argument_model.dart';
import 'package:ota/domain/translation/repositories/translation_repository_impl.dart';

abstract class TranslationUseCases {
  Future<Either<Failure, ThaiTranslationDataModel>?> getThaiTranslation(
      {required TranslationArgumentModel argument});
  Future<Either<Failure, EnglishTranslationDataModel>?> getEnglishTranslation(
      {required TranslationArgumentModel argument});
  Future<List<Either?>?> getTranslation();
}

class TranslationUseCasesImpl implements TranslationUseCases {
  TranslationRepository? thaiRepository, englishRepository;

  /// Dependence injection via constructor
  TranslationUseCasesImpl(
      {TranslationRepository? thaiRepository,
      TranslationRepository? englishRepository}) {
    if (thaiRepository == null) {
      this.thaiRepository = ThaiTranslationRepositoryImpl();
    } else {
      this.thaiRepository = thaiRepository;
    }

    if (englishRepository == null) {
      this.englishRepository = EnglishTranslationRepositoryImpl();
    } else {
      this.englishRepository = englishRepository;
    }
  }

  @override
  Future<Either<Failure, EnglishTranslationDataModel>?> getEnglishTranslation({
    required TranslationArgumentModel argument,
  }) async {
    return await englishRepository
        ?.getTranslation<EnglishTranslationDataModel>(argument);
  }

  @override
  Future<Either<Failure, ThaiTranslationDataModel>?> getThaiTranslation(
      {required TranslationArgumentModel argument}) async {
    return await thaiRepository
        ?.getTranslation<ThaiTranslationDataModel>(argument);
  }

  @override
  Future<List<Either?>?> getTranslation() async {
    return await Future.wait([
      getEnglishTranslation(
          argument: TranslationArgumentModel(
              translationType: TranslationType.english)),
      getThaiTranslation(
          argument:
              TranslationArgumentModel(translationType: TranslationType.thai))
    ]);
  }
}
