import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/room_detail/models/argument_data_model.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';
import 'package:ota/domain/hotel/room_detail/usecases/room_detail_usecases.dart';

class RoomDetailUseCasesImplFailureMock extends RoomDetailUseCasesImpl {
  @override
  Future<Either<Failure, RoomDetailData?>?> getRoomDetail(
      RoomDetailDataArgument argument) async {
    return Left(InternetFailure());
  }
}
