import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/hotel/room_detail/models/room_detail_model.dart';
import 'package:ota/domain/hotel/room_detail/usecases/room_detail_usecases.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_argument_model.dart';
import 'package:ota/modules/hotel/room_detail/view_model/room_detail_view_model.dart';

class RoomDetailViewBloc extends Bloc<RoomDetailViewModel> {
  RoomDetailUseCasesImpl roomDetailUseCasesImpl = RoomDetailUseCasesImpl();

  @override
  RoomDetailViewModel initDefaultValue() {
    return RoomDetailViewModel(pageState: RoomDetailViewPageState.initial);
  }

  Future<void> getRoomDetail(
      RoomDetailArgument? argument, bool isRefresh) async {
    if (argument == null) {
      emit(RoomDetailViewModel(pageState: RoomDetailViewPageState.failure));
      return;
    }
    if (!isRefresh) {
      emit(RoomDetailViewModel(pageState: RoomDetailViewPageState.loading));
    }

    await mapRoomDetail(roomDetailUseCasesImpl, argument, isRefresh);
  }

  Future<void> mapRoomDetail(RoomDetailUseCasesImpl roomDetailUseCasesImpl,
      RoomDetailArgument argument, bool isRefresh) async {
    Either<Failure, RoomDetailData?>? result = await roomDetailUseCasesImpl
        .getRoomDetail(argument.toRoomDataArgument());

    if (result?.isRight ?? false) {
      RoomDetailData? data = result!.right;
      GetRoomDetailsData? roomDetailData = data?.getRoomDetails?.data;
      if (roomDetailData != null) {
        emit(RoomDetailViewModel(
            pageState: RoomDetailViewPageState.success,
            data: RoomDetailModel.mapFromRoomDetail(roomDetailData, argument)));
      } else {
        emit(RoomDetailViewModel(pageState: RoomDetailViewPageState.failure));
      }
    } else if (result?.left is InternetFailure) {
      emit(RoomDetailViewModel(
          pageState: RoomDetailViewPageState.internetFailure));
    } else {
      ///Notify the splash screen that Api call Failed
      emit(RoomDetailViewModel(pageState: RoomDetailViewPageState.failure));
    }
  }

  bool get isRoomImageAvailable =>
      state.data?.roomImage != null && state.data!.roomImage.isNotEmpty;
}
