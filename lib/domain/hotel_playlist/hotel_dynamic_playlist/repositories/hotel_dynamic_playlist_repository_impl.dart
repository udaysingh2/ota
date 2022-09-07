import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';

import '../data_sources/hotel_dynamic_playlist_remote_data_source.dart';
import '../models/hotel_dynamic_playlist_argument_model.dart';
import '../models/hotel_dynamic_playlist_model_domain.dart';

abstract class HotelDynamicPlaylistRepository {
  /// Call API to get the DynamicPlaylist Screen details.
  ///
  /// [hotelId] to get the DynamicPlaylist Data for users.
  /// [Either<Failure, DynamicPlaylistModel>] to handle the Failure or result data.
  Future<Either<Failure, HotelDynamicPlayListModelDomainData>>
      getDynamicPlayListData(
          HotelDynamicPlayListDataArgumentModelDomain argument);
}

/// HotelDynamicPlaylistRepositoryImpl will contain the HotelDynamicPlaylistRepository implementation.
class HotelDynamicPlaylistRepositoryImpl
    implements HotelDynamicPlaylistRepository {
  HotelDynamicPlayListRemoteDataSource? hotelDynamicPlayListRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  /// Dependence injection via constructor
  HotelDynamicPlaylistRepositoryImpl(
      {HotelDynamicPlayListRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (_hotelDynamicPlayListRemoteDataSource != null) {
      hotelDynamicPlayListRemoteDataSource =
          _hotelDynamicPlayListRemoteDataSource;
    } else if (remoteDataSource == null) {
      hotelDynamicPlayListRemoteDataSource =
          HotelDynamicPlayListRemoteDataSourceImpl();
    } else {
      hotelDynamicPlayListRemoteDataSource = remoteDataSource;
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
  ///
  /// [hotelId] to get the Playlist Data for users.
  /// [Either<Failure, DynamicPlaylistModel>] to handle the Failure or result data.
  @override
  Future<Either<Failure, HotelDynamicPlayListModelDomainData>>
      getDynamicPlayListData(
          HotelDynamicPlayListDataArgumentModelDomain argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final dynamicPlaylistResult = await hotelDynamicPlayListRemoteDataSource
            ?.getHotelDynamicPlayListData(argument);
        return Right(dynamicPlaylistResult!);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}

HotelDynamicPlayListRemoteDataSource? _hotelDynamicPlayListRemoteDataSource;
InternetConnectionInfo? _internetConnectionInfo;
void mockDynamicPlaylistPageData(
    {HotelDynamicPlayListRemoteDataSource? remoteDataSource,
    InternetConnectionInfo? internetInfo}) {
  _hotelDynamicPlayListRemoteDataSource = remoteDataSource;
  _internetConnectionInfo = internetInfo;
}
