import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_save_search_history/data_source/car_save_search_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_argument_domain.dart';
import 'package:ota/domain/car_rental/car_save_search_history/models/car_save_search_domain_model.dart';

abstract class CarSaveSearchHistoryRepository {
  /// Call API to save the Search History.
  ///
  /// [Either<Failure, CarSaveSearchHistoryModelDomain>] to handle the Failure or result data.
  Future<Either<Failure, CarSaveSearchHistoryModelDomain>>
      saveCarSearchHistoryData(CarSaveSearchHistoryArgumentDomain argument);
}

/// CarSaveSearchHistoryRepositoryImpl will contain the CarSaveSearchHistoryRepository implementation.
class CarSaveSearchHistoryRepositoryImpl
    implements CarSaveSearchHistoryRepository {
  CarSaveSearchHistoryRemoteDataSource? carSaveSearchHistoryRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  CarSaveSearchHistoryRepositoryImpl(
      {CarSaveSearchHistoryRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      carSaveSearchHistoryRemoteDataSource =
          CarSaveSearchHistoryRemoteDataSourceImpl();
    } else {
      carSaveSearchHistoryRemoteDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Search Suggestions.
  ///
  /// [Either<Failure, CarSaveSearchHistoryModelDomain>] to handle the Failure or result data.
  @override
  Future<Either<Failure, CarSaveSearchHistoryModelDomain>>
      saveCarSearchHistoryData(
          CarSaveSearchHistoryArgumentDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final searchSuggestionResult =
            await carSaveSearchHistoryRemoteDataSource
                ?.saveCarSearchHistoryData(argument);
        return Right(searchSuggestionResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
