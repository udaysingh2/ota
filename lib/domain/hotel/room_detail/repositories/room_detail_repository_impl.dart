import 'package:either_dart/either.dart';
import 'package:ota/common/network/exceptions.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/hotel/room_detail/data_sources/room_detail_remote_data_source.dart';
import 'package:ota/domain/hotel/room_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';

/// Interface for HotelDetailRepository repository.
abstract class RoomDetailRepository {
  Future<Either<Failure, RoomDetailData?>> getRoomDetail(
      RoomDetailDataArgument argument);
}

class RoomDetailRepositoryImpl implements RoomDetailRepository {
  RoomDetailRemoteDataSource? roomDetailRemoteDataSource;
  InternetConnectionInfo? internetConnectionInfo;

  /// Dependence injection via constructor
  RoomDetailRepositoryImpl(
      {RoomDetailRemoteDataSource? remoteDataSource,
      InternetConnectionInfo? internetInfo}) {
    if (remoteDataSource == null) {
      roomDetailRemoteDataSource = RoomDetailRemoteDataSourceImpl();
    } else {
      roomDetailRemoteDataSource = remoteDataSource;
    }

    if (internetInfo == null) {
      internetConnectionInfo = InternetConnectionInfoImpl();
    } else {
      internetConnectionInfo = internetInfo;
    }
  }

  @override
  Future<Either<Failure, RoomDetailData?>> getRoomDetail(
      RoomDetailDataArgument argument) async {
    if (await (internetConnectionInfo?.isConnected) ?? false) {
      try {
        final roomResult =
            await roomDetailRemoteDataSource?.getRoomDetail(argument);
        return Right(roomResult);
      } on ServerException catch (error) {
        return Left(ServerFailure(exception: error.exception));
      }
    } else {
      /// Change this To Local dataSource if internet fails Sqlite or SharePreference
      return Left(InternetFailure());
    }
  }
}
