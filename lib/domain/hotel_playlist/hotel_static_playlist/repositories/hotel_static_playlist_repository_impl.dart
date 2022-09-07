import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/data_sources/hotel_static_playlist_remote_data_source/hotel_static_playlist_remote_data_source.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_argument_model.dart';
import 'package:ota/domain/hotel_playlist/hotel_static_playlist/models/hotel_static_playlist_model_domain.dart';

abstract class HotelStaticPlayListRepository {
  /// Call API to get the DynamicPlaylist Screen details.
  ///
  /// [hotelId] to get the DynamicPlaylist Data for users.
  /// [Either<Failure, DynamicPlaylistModel>] to handle the Failure or result data.
  Future<Either<Failure, HotelStaticPlayListModelDomain>>
      getHotelStaticPlayListData(
          HotelStaticPlayListArgumentModelDomain argument);
}

/// HotelStaticPlayListRepositoryImpl will contain the HotelStaticPlayListRepository implementation.
class HotelStaticPlayListRepositoryImpl
    implements HotelStaticPlayListRepository {
  HotelStaticPlayListRemoteDataSource? hotelStaticPlayListRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  /// Dependence injection via constructor
  HotelStaticPlayListRepositoryImpl(
      {HotelStaticPlayListRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (_hotelStaticPlaylistRemoteDataSource != null) {
      hotelStaticPlayListRemoteDataSource =
          _hotelStaticPlaylistRemoteDataSource;
    } else if (remoteDataSource == null) {
      hotelStaticPlayListRemoteDataSource =
          HotelStaticPlayListRemoteDataSourceImpl();
    } else {
      hotelStaticPlayListRemoteDataSource = remoteDataSource;
    }

    if (_internetConnectionInfo != null) {
      internetConnectionInfo = _internetConnectionInfo;
    } else if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  /// Call API to get the Playlist Screen details.
  @override
  Future<Either<Failure, HotelStaticPlayListModelDomain>>
      getHotelStaticPlayListData(
          HotelStaticPlayListArgumentModelDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final hotelStaticPlaylistResult =
            await hotelStaticPlayListRemoteDataSource
                ?.getHotelStaticPlayListData(argument);
        return Right(hotelStaticPlaylistResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}

HotelStaticPlayListRemoteDataSource? _hotelStaticPlaylistRemoteDataSource;
InternetConnectionInfo? _internetConnectionInfo;
void mockDynamicPlaylistPageData(
    {HotelStaticPlayListRemoteDataSource? remoteDataSource,
    InternetConnectionInfo? internetInfo}) {
  _hotelStaticPlaylistRemoteDataSource = remoteDataSource;
  _internetConnectionInfo = internetInfo;
}
