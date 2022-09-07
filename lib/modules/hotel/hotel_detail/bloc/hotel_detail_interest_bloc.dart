import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/usecases/hotel_detail_interest_use_cases.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/hotel_detail_interest_view_model.dart';

class HotelDetailInterestBloc extends Bloc<HotelDetailInterestViewModel> {
  HotelDetailInterestUseCases hotelDetailInterestUseCases =
      HotelDetailInterestUseCasesImpl();

  @override
  HotelDetailInterestViewModel initDefaultValue() {
    return HotelDetailInterestViewModel();
  }

  void getInterests(HotelDetailArgument? argument) async {
    state.viewState = HotelDetailInterestViewModelState.loading;
    emit(state);
    if (argument == null) {
      state.viewState = HotelDetailInterestViewModelState.failure;
      emit(state);
      return;
    }

    Either<Failure, HotelDetailInterestData>? data =
        await hotelDetailInterestUseCases.getHotelDetailInterest(
            argument.toHotelDetailInterestDataArgument());
    if (data?.isLeft ?? true) {
      state.viewState = HotelDetailInterestViewModelState.failure;
      emit(state);
      return;
    }
    HotelDetailInterestData hotelDetailInterestData = data!.right;
    state.setSuggesionModelFromApi(hotelDetailInterestData);
    state.viewState = HotelDetailInterestViewModelState.success;
    emit(state);
  }
}
