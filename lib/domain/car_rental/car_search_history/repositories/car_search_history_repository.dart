import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_search_history/data_source/car_search_history_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_history/models/car_search_history_model.dart';

abstract class CarSearchHistoryRepository {
  Future<Either<Failure, CarSearchHistoryModelDomainData>>
      getCarSearchHistoryData();
}

class CarSearchHistoryRepositoryImpl implements CarSearchHistoryRepository {
  CarSearchHistoryRemoteDataSource? searchRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;
  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  CarSearchHistoryRepositoryImpl(
      {CarSearchHistoryRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      searchRemoteDataSource = CarSearchHistoryRemoteDataSourceImpl();
      // searchRemoteDataSource = CarSearchHistoryMockDataSourceImpl();
    } else {
      searchRemoteDataSource = remoteDataSource;
    }

    if (_internetMockConnectionInfo != null) {
      internetConnectionInfo = _internetMockConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  @override
  Future<Either<Failure, CarSearchHistoryModelDomainData>>
      getCarSearchHistoryData() async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final searchSuggestionResult =
            await searchRemoteDataSource?.getCarSearchHistoryData();
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
