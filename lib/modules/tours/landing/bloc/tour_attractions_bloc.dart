import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/domain/tours/landing/models/tour_attractions_model_domain.dart';
import 'package:ota/domain/tours/landing/usecases/tour_attractions_usecases.dart';
import 'package:ota/modules/tours/landing/helpers/tour_landing_helper.dart';
import 'package:ota/modules/tours/landing/view_model/tour_attractions_view_model.dart';

class TourAttractionsBloc extends Bloc<TourAttractionsViewModel> {
  @override
  TourAttractionsViewModel initDefaultValue() {
    return TourAttractionsViewModel();
  }

  void getTourAttractionsData(String serviceType) async {
    state.pageState = TourAttractionsPageState.loading;
    emit(state);

    TourAttractionsUseCasesImpl tourAttractionsCardUseCases =
        TourAttractionsUseCasesImpl();
    Either<Failure, TourAttractionsModelDomain?>? result =
        await tourAttractionsCardUseCases.getTourAttractionsData(serviceType);
    if (result?.isRight ?? false) {
      TourAttractionsModelDomain? attractionsResult = result!.right;
      String? statusCode =
          attractionsResult?.getTourServiceSuggestions?.status?.code;
      if (statusCode == kErrorCode1899) {
        state.pageState = TourAttractionsPageState.failure1899;
        emit(state);
      } else if (statusCode == kErrorCode1999) {
        state.pageState = TourAttractionsPageState.failure1999;
        emit(state);
      } else if (statusCode == kSuccessCode) {
        List<LocationList>? attractionList =
            attractionsResult?.getTourServiceSuggestions?.data?.locationList;

        if (attractionList != null && attractionList.isNotEmpty) {
          state.tourAtrractionsList =
              TourLandingHelper.getTourAttractionsList(attractionList);
          state.pageState = TourAttractionsPageState.success;
          emit(state);
        } else {
          state.pageState = TourAttractionsPageState.failure;
          emit(state);
        }
      }
    } else {
      state.pageState = TourAttractionsPageState.failure;
      emit(state);
    }
  }

  bool get isLoading => state.pageState == TourAttractionsPageState.loading;

  bool get isFailure =>
      state.pageState == TourAttractionsPageState.failure ||
      state.pageState == TourAttractionsPageState.failure1899 ||
      state.pageState == TourAttractionsPageState.failure1999;

  bool get isSuccess => state.pageState == TourAttractionsPageState.success;
}
