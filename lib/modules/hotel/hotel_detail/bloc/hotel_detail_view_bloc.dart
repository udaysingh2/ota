import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/hotel/hotel_detail/models/hotel_detail_model.dart';
import 'package:ota/domain/hotel/hotel_detail/usecases/hotel_detail_use_cases.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/hotel_detail_view_model.dart';

class HotelDetailViewBloc extends Bloc<HotelDetailViewModel> {
  @override
  HotelDetailViewModel initDefaultValue() {
    return HotelDetailViewModel(pageState: HotelDetailViewPageState.initial);
  }

  Future<void> getHotelDetail(
      HotelDetailArgument? argument, bool isRefresh) async {
    if (argument == null) {
      emit(HotelDetailViewModel(pageState: HotelDetailViewPageState.failure));
      return;
    }
    if (!isRefresh) {
      emit(HotelDetailViewModel(pageState: HotelDetailViewPageState.loading));
    }

    HotelDetailUseCasesImpl hotelDetailUseCasesImpl = HotelDetailUseCasesImpl();
    await mapHotelDetail(hotelDetailUseCasesImpl, argument, isRefresh);
  }

  Future<void> mapHotelDetail(HotelDetailUseCasesImpl hotelDetailUseCasesImpl,
      HotelDetailArgument argument, bool isRefresh) async {
    Either<Failure, HotelDetailModelDomain>? result =
        await hotelDetailUseCasesImpl
            .getHotelDetail(argument.toHotelDataArgument());

    if (result?.isRight ?? false) {
      HotelDetailModelDomain data = result!.right;
      Data? hotelDetail = data.getHotelDetails?.data;
      if (hotelDetail != null) {
        if (hotelDetail.rooms?.isNotEmpty ?? false) {
          emit(HotelDetailViewModel(
              pageState: HotelDetailViewPageState.success,
              data:
                  HotelDetailModel.mapFromHotelDetail(hotelDetail, argument)));
        } else {
          emit(HotelDetailViewModel(
              pageState: HotelDetailViewPageState.noRoomData,
              data:
                  HotelDetailModel.mapFromHotelDetail(hotelDetail, argument)));
        }
      } else {
        emit(HotelDetailViewModel(pageState: HotelDetailViewPageState.failure));
      }
    } else if (result?.left is InternetFailure) {
      emit(HotelDetailViewModel(
          pageState: HotelDetailViewPageState.internetFailure));
    } else {
      ///Notify the splash screen that Api call Failed
      emit(HotelDetailViewModel(pageState: HotelDetailViewPageState.failure));
    }
  }
}
