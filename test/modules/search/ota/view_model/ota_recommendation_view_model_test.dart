import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/models/search_recommendation_model.dart';
import 'package:ota/modules/search/ota/view_model/ota_recommendation_view_model.dart';

void main() {
  test("Ota Recommendation View Model", () {
    OtaRecommendationViewModel recommendationViewModel =
        OtaRecommendationViewModel(
            recommendationList: [
              OtaRecommendationModel(
                  serviceTitle: "serviceTitle",
                  imageUrl: "imageUrl",
                  hotelId: "ABC1223",
                  cityId: "ABC1223",
                  countryId: "ABC1223",
                  playListId: "1111")
            ],
            recommendationState: OtaRecommendationViewModelState.success,
            searchHistoryList: []);

    expect(recommendationViewModel.recommendationState,
        OtaRecommendationViewModelState.success);
    expect(recommendationViewModel.recommendationList.length, 1);
  });
  test("Hotel Recommendation Model", () {
    Recommendation recommendation = Recommendation(
        hotelId: "ABC123",
        serviceTitle: "Pataya",
        imageUrl: "image.com",
        cityId: "ABC123",
        countryId: "ABC123",
        playlistId: "1111");
    OtaRecommendationModel hotelRecommendationModel =
        OtaRecommendationModel.mapFromModel(recommendation);
    expect(hotelRecommendationModel.cityId, "ABC123");
    expect(hotelRecommendationModel.hotelId, "ABC123");
  });
}
