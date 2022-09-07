import 'package:either_dart/either.dart';
import 'package:ota/channels/get_user_location_invoke/models/get_user_location_response_model_channel.dart';
import 'package:ota/channels/get_user_location_invoke/usecases/get_user_location_use_cases.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core/app_config.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/search/models/hotel_recomendation_arg_domain.dart';
import 'package:ota/domain/search/models/hotel_recommendation_model_domain.dart';
import 'package:ota/domain/search/usecases/search_recommendation_use_cases.dart';
import 'package:ota/modules/authentication/model/login_model.dart';
import 'package:ota/modules/search/hotel/helpers/search_helper.dart';
import 'package:ota/modules/search/hotel/view_model/hotel_recommendation_view_model.dart';

const int _kLimit = 10;

class HotelRecommendationBloc extends Bloc<HotelRecommendationViewModel> {
  int _currentPageNumber = 1;
  double _latitude = AppConfig().configModel.defaultLatitude;
  double _longitude = AppConfig().configModel.defaultLongitude;

  SearchRecommendationUseCases recommendationUseCases =
      SearchRecommendationUseCasesImpl();
  @override
  HotelRecommendationViewModel initDefaultValue() {
    return HotelRecommendationViewModel(
        recommendationList: [], searchHistoryList: []);
  }

  Future<void> getUserLocationFromChannel(LoginModel loginModel) async {
    GetUserLocationUseCases getUserLocationUseCases =
        GetUserLocationUseCasesImpl();
    Either<Failure, GetUserLocationResponseModelChannel> either =
        await getUserLocationUseCases.invokeExampleMethod(
            methodName: "otaUserLocation",
            arguments: loginModel.getUserLocationArgumentModelChannel());
    if (either.isRight) {
      GetUserLocationResponseModelChannel model = either.right;
      _latitude = model.latitude != null
          ? double.tryParse(model.latitude!) ??
              AppConfig().configModel.defaultLatitude
          : AppConfig().configModel.defaultLatitude;
      _longitude = model.longitude != null
          ? double.tryParse(model.longitude!) ??
              AppConfig().configModel.defaultLongitude
          : AppConfig().configModel.defaultLongitude;

      fetchRecommendationData();
    } else {
      fetchRecommendationData();
    }
  }

  void fetchRecommendationData({int offset = 0}) async {
    state.recommendationState = HotelRecommendationViewModelState.loading;
    emit(state);
    final recommendationArgument =
        HotelRecommendationArgDomain.fromHotelSuggestion(
            _latitude, _longitude, offset, _kLimit);
    Either<Failure, HotelRecommendationModelDomain>? result =
        await recommendationUseCases
            .getHotelSearchRecommendationData(recommendationArgument);
    if (result != null && result.isRight) {
      GetHotelSearchRecommendation getHotelRecommendation =
          result.right.getHotelSearchRecommendation ??
              GetHotelSearchRecommendation();

      if (getHotelRecommendation.data == null) {
        state.recommendationState = HotelRecommendationViewModelState.failure;
        emit(state);
      }
      HotelRecommendationViewModel searchRecommendedViewModelData =
          SearchHelper.getRecommendationViewModel(getHotelRecommendation);
      if (state.recommendationList.isEmpty) {
        state.recommendationList =
            searchRecommendedViewModelData.recommendationList;
      } else {
        state.recommendationList
            .addAll(searchRecommendedViewModelData.recommendationList);
      }

      if (state.searchHistoryList.isEmpty) {
        state.searchHistoryList =
            searchRecommendedViewModelData.searchHistoryList;
      }
      state.recommendationState = HotelRecommendationViewModelState.success;
      emit(state);
    } else if (result?.left is InternetFailure) {
      state.recommendationState =
          HotelRecommendationViewModelState.internetFailure;
      emit(state);
    } else {
      state.recommendationState = HotelRecommendationViewModelState.failure;
      emit(state);
    }
  }

  void fetchMoreRecommendationsData() {
    if (_isNewDataRequired()) {
      _currentPageNumber++;
      fetchRecommendationData(offset: state.recommendationList.length);
    }
  }

  bool _isNewDataRequired() {
    int maxSize = _currentPageNumber * _kLimit;
    if (maxSize == state.recommendationList.length) return true;
    return false;
  }

  bool get isLazyLoading =>
      state.recommendationState == HotelRecommendationViewModelState.loading &&
      !isRecommendationsEmpty;

  bool get isSuccess =>
      state.recommendationState == HotelRecommendationViewModelState.success;

  bool get isRecommendationsEmpty => state.recommendationList.isEmpty;

  bool get isSearchHistoryEmpty => state.searchHistoryList.isEmpty;
}
