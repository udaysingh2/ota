import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/usecases/recommended_location_usecases.dart';
import 'package:ota/modules/hotel/hotel_landing/helpers/hotel_landing_helper.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/recommended_location_view_model.dart';

const String _kServiceTypeHotel = 'HOTEL_LANDING';

class RecommendedLocationBloc extends Bloc<RecommendedLocationViewModel> {
  RecommendedLocationUseCases recommendedLocationUseCases =
      RecommendedLocationUseCasesImpl();

  @override
  RecommendedLocationViewModel initDefaultValue() {
    return RecommendedLocationViewModel(
      recommendedLocationList: [],
      recommendationsState: RecommendedLocationModelState.none,
    );
  }

  void getLandingRecommendations() async {
    state.recommendationsState = RecommendedLocationModelState.loading;
    emit(state);

    Either<Failure, RecommendedLocationModelDomain>? result =
        await recommendedLocationUseCases
            .getRecommendedLocationData(_kServiceTypeHotel);
    if (result != null && result.isRight) {
      GetRecommendedLocation? getHotelRecommendation =
          result.right.getRecommendedLocation;

      if (getHotelRecommendation?.data == null) {
        state.recommendationsState = RecommendedLocationModelState.failure;
        emit(state);
        return;
      }

      final List<RecommendedLocationModel> recommendedLocationList =
          HotelLandingHelper.getHotelRecommendationViewModel(
                  getHotelRecommendation?.data?.locationList) ??
              [];
      state.recommendedLocationList = recommendedLocationList;
      state.recommendationsState = RecommendedLocationModelState.success;
      emit(state);
    } else {
      state.recommendationsState = RecommendedLocationModelState.failure;
      emit(state);
    }
  }

  bool get isRecommendationsEmpty => state.recommendedLocationList.isEmpty;

  bool get isSuccess =>
      state.recommendationsState == RecommendedLocationModelState.success;
}
