import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/data_sources/car_search_suggestion_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_argument_model.dart';
import 'package:ota/domain/car_rental/car_search_suggestion/models/car_search_suggestion_model_domain.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/data_sources/hotel_dynamic_playlist_remote_data_source.dart';

abstract class CarSearchSuggestionRepository {
  Future<Either<Failure, CarSearchSuggestionData>>
      getCarSearchSuggestionData(
          CarSearchSuggestionArgumentModelDomain argument);
}

/// CarSearchSuggestionRepositoryImpl will contain the CarSearchSuggestionRepository implementation.
class CarSearchSuggestionRepositoryImpl
    implements CarSearchSuggestionRepository {
  CarSearchSuggestionRemoteDataSource? carSearchSuggestionRemoteDataSource;
  HotelDynamicPlayListRemoteDataSource? hotelDynamicPlayListRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  /// Dependence injection via constructor
  CarSearchSuggestionRepositoryImpl(
      {CarSearchSuggestionRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (_carSearchSuggestionRemoteDataSource != null) {
      carSearchSuggestionRemoteDataSource =
          _carSearchSuggestionRemoteDataSource;
    } else if (remoteDataSource == null) {
      carSearchSuggestionRemoteDataSource =
          CarSearchSuggestionRemoteDataSourceImpl();
    } else {
      carSearchSuggestionRemoteDataSource = remoteDataSource;
    }

    if (_internetConnectionInfo != null) {
      internetConnectionInfo = _internetConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  @override
  Future<Either<Failure, CarSearchSuggestionData>>
      getCarSearchSuggestionData(
          CarSearchSuggestionArgumentModelDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final carSearchSuggestionResult =
            await carSearchSuggestionRemoteDataSource
                ?.getCarSearchSuggestionData(argument);

        return Right(carSearchSuggestionResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      return Left(InternetFailure());
    }
  }
}

CarSearchSuggestionRemoteDataSource? _carSearchSuggestionRemoteDataSource;
InternetConnectionInfo? _internetConnectionInfo;
void mockDynamicPlaylistPageData(
    {CarSearchSuggestionRemoteDataSource? remoteDataSource,
    InternetConnectionInfo? internetInfo}) {
  _carSearchSuggestionRemoteDataSource = remoteDataSource;
  _internetConnectionInfo = internetInfo;
}
