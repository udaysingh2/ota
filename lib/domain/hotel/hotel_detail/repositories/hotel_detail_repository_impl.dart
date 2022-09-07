import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/hotel/hotel_detail/data_sources/hotel_detail_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/add_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/hotel_detail/models/delete_favorite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_check_favourite_model_domain.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_detail_model.dart';

/// Interface for HotelDetailRepository repository.
abstract class HotelDetailRepository {
  Future<Either<Failure, HotelDetailModelDomain>> getHotelDetail(
      HotelDetailDataArgument argument);

  Future<Either<Failure, IsFavoritesDomain>> checkFavouriteHotel({
    required String type,
    required String hotelId,
  });

  Future<Either<Failure, DeleteFavoriteModelDomain>> unfavouritesHotel({
    required String type,
    required String hotelId,
  });

  Future<Either<Failure, AddFavoriteModelDomain>> addFavouriteHotel({
    required AddFavoriteArgumentModelDomain favoriteArgumentModel,
  });
}

class HotelDetailRepositoryImpl implements HotelDetailRepository {
  HotelDetailRemoteDataSource? hotelDetailRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  static InternetConnectionInfo? _internetMockConnectionInfo;

  static setMockInternet(InternetConnectionInfo? internetConnectionInfo) {
    _internetMockConnectionInfo = internetConnectionInfo;
  }

  /// Dependence injection via constructor
  HotelDetailRepositoryImpl(
      {HotelDetailRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      hotelDetailRemoteDataSource = HotelDetailRemoteDataSourceImpl();
    } else {
      hotelDetailRemoteDataSource = remoteDataSource;
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
  Future<Either<Failure, HotelDetailModelDomain>> getHotelDetail(
      HotelDetailDataArgument argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final hotelResult =
            await hotelDetailRemoteDataSource?.getHotelDetail(argument);
        return Right(hotelResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, IsFavoritesDomain>> checkFavouriteHotel(
      {required String type, required String hotelId}) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final checkFavorites = await hotelDetailRemoteDataSource
            ?.checkFavouriteHotel(type: type, hotelId: hotelId);
        return Right(checkFavorites!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, DeleteFavoriteModelDomain>> unfavouritesHotel(
      {required String type, required String hotelId}) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result = await hotelDetailRemoteDataSource?.unfavouritesHotel(
            type: type, hotelId: hotelId);
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, AddFavoriteModelDomain>> addFavouriteHotel(
      {required AddFavoriteArgumentModelDomain favoriteArgumentModel}) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final result = await hotelDetailRemoteDataSource?.addFavouriteHotel(
          favoriteArgumentModel: favoriteArgumentModel,
        );
        return Right(result!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
