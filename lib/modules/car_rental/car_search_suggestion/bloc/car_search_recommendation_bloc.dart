import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/usecases/recommended_location_usecases.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/helpers/car_search_suggestion_helper.dart';
import 'package:ota/modules/car_rental/car_search_suggestion/view_model/car_search_recommendation_view_model.dart';

class CarRecommendedLocationBloc extends Bloc<CarRecommendedLocationViewModel> {
  RecommendedLocationUseCases recommendedLocationUseCases =
      RecommendedLocationUseCasesImpl();

  @override
  CarRecommendedLocationViewModel initDefaultValue() {
    return CarRecommendedLocationViewModel(
      recommendedLocationList: [],
      recommendationsState: CarRecommendedLocationModelState.none,
    );
  }

  Future<void> getCarRecommendations(String serviceType) async {
    state.recommendationsState = CarRecommendedLocationModelState.loading;
    emit(state);

    Either<Failure, RecommendedLocationModelDomain>? result =
        await recommendedLocationUseCases
            .getRecommendedLocationData(serviceType);
    if (result != null && result.isRight) {
      GetRecommendedLocation? getHotelRecommendation =
          result.right.getRecommendedLocation;

      if (getHotelRecommendation?.data == null) {
        state.recommendationsState = CarRecommendedLocationModelState.failure;
        emit(state);
        return;
      }

      final List<CarRecommendedLocationModel> recommendedLocationList =
          CarSearchSuggestionsHelper.getHotelRecommendationViewModel(
                  getHotelRecommendation?.data?.locationList) ??
              [];
      state.recommendedLocationList = recommendedLocationList;
      state.recommendationsState = CarRecommendedLocationModelState.success;
      emit(state);
    } else {
      if (result?.left is InternetFailure) {
        state.recommendationsState =
            CarRecommendedLocationModelState.failureNetwork;
        emit(state);
      } else {
        state.recommendationsState = CarRecommendedLocationModelState.failure;
        emit(state);
      }
    }
  }

  bool get isRecommendationsEmpty => state.recommendedLocationList.isEmpty;

  bool get isSuccess =>
      state.recommendationsState == CarRecommendedLocationModelState.success;
}
