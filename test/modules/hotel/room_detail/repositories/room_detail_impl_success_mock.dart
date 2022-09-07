import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/hotel/room_detail/data_sources/room_detail_remote_data_source.dart';
import 'package:ota/domain/hotel/room_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';
import 'package:ota/domain/hotel/room_detail/repositories/room_detail_repository_impl.dart';

import '../../../../mocks/fixture_reader.dart';

class RoomDetailRepositoryImplSuccessMock implements RoomDetailRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  RoomDetailRemoteDataSource? roomDetailRemoteDataSource;

  @override
  Future<Either<Failure, RoomDetailData?>> getRoomDetail(
      RoomDetailDataArgument argument) async {
    String json = fixture("room_detail/room_detail.json");
    RoomDetailData model = RoomDetail.fromJson(json).data!;
    return Right(model);
  }
}
