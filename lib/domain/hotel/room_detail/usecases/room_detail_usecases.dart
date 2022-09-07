import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/room_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';
import 'package:ota/domain/hotel/room_detail/repositories/room_detail_repository_impl.dart';

/// Interface for HotelDetail use cases.
abstract class RoomDetailUseCases {
  Future<Either<Failure, RoomDetailData?>?> getRoomDetail(
      RoomDetailDataArgument argument);
}

class RoomDetailUseCasesImpl implements RoomDetailUseCases {
  RoomDetailRepository? roomDetailRepository;

  /// Dependence injection via constructor
  RoomDetailUseCasesImpl({RoomDetailRepository? repository}) {
    if (repository == null) {
      roomDetailRepository = RoomDetailRepositoryImpl();
    } else {
      roomDetailRepository = repository;
    }
  }

  @override
  Future<Either<Failure, RoomDetailData?>?> getRoomDetail(
      RoomDetailDataArgument argument) async {
    return await roomDetailRepository?.getRoomDetail(argument);
  }
}
