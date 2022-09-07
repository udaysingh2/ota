import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/translation/data_sources/translation_remote_data_source.dart';
import 'package:ota/domain/translation/models/translation_argument_model.dart';

/// Interface for HotelDetailRepository repository.
abstract class TranslationRepository {
  Future<Either<Failure, T>> getTranslation<T>(
      TranslationArgumentModel argument);
}

class EnglishTranslationRepositoryImpl implements TranslationRepository {
  TranslationDataSource? translationDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  /// Dependence injection via constructor
  EnglishTranslationRepositoryImpl(
      {TranslationDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      translationDataSource = EnglishTranslationDataSourceImpl();
    } else {
      translationDataSource = remoteDataSource;
    }

    if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  @override
  Future<Either<Failure, T>> getTranslation<T>(
      TranslationArgumentModel argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final hotelResult =
            await translationDataSource?.getTranslation(argument);
        return Right(hotelResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}

class ThaiTranslationRepositoryImpl implements TranslationRepository {
  TranslationDataSource? translationDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  /// Dependence injection via constructor
  ThaiTranslationRepositoryImpl(
      {TranslationDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      translationDataSource = ThaiTranslationDataSourceImpl();
    } else {
      translationDataSource = remoteDataSource;
    }

    if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  @override
  Future<Either<Failure, T>> getTranslation<T>(
      TranslationArgumentModel argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final hotelResult =
            await translationDataSource?.getTranslation(argument);
        return Right(hotelResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
