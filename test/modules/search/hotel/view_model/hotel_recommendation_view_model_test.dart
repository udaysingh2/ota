import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/search/models/hotel_recommendation_model_domain.dart';
import 'package:ota/domain/search/models/search_recommendation_model.dart';
import 'package:ota/modules/search/hotel/view_model/hotel_recommendation_view_model.dart';

void main() {
  test("Hotel Recommendation View Model", () {
    HotelRecommendationViewModel recommendationViewModel =
        HotelRecommendationViewModel(
            recommendationList: [
              HotelRecommendationModel(
                  serviceTitle: "serviceTitle",
                  imageUrl: "imageUrl",
                  hotelId: "ABC1223",
                  cityId: "ABC1223",
                  countryId: "ABC1223",
                  playListId: "1111")
            ],
            recommendationState: HotelRecommendationViewModelState.success,
            searchHistoryList: []);

    expect(recommendationViewModel.recommendationState,
        HotelRecommendationViewModelState.success);
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
    HotelRecommendationModel hotelRecommendationModel =
        HotelRecommendationModel.mapFromModel(recommendation);
    expect(hotelRecommendationModel.cityId, "ABC123");
    expect(hotelRecommendationModel.hotelId, "ABC123");
  });

  test("Hotel Recommendation view Model", () {
    HotelRecommendation recommendation = HotelRecommendation(
        hotelId: "ABC123",
        serviceTitle: "Pataya",
        imageUrl: "image.com",
        cityId: "ABC123",
        countryId: "ABC123",
        playlistId: "1111");
    HotelRecommendationModel hotelRecommendationModel =
        HotelRecommendationModel.mapFromHotelModel(recommendation);
    expect(hotelRecommendationModel.cityId, "ABC123");
    expect(hotelRecommendationModel.hotelId, "ABC123");
  });

  test("Hotel Search History View Model", () {
    HotelRecommendationViewModel recommendationViewModel =
        HotelRecommendationViewModel(
      recommendationList: [],
      searchHistoryList: [
        HotelSearchHistoryModel(
            hotelId: "ABC1223",
            cityId: "ABC1223",
            countryId: "ABC1223",
            keyword: 'test',
            checkInDate: '123',
            checkOutDate: '456,')
      ],
      recommendationState: HotelRecommendationViewModelState.success,
    );

    expect(recommendationViewModel.recommendationState,
        HotelRecommendationViewModelState.success);
    expect(recommendationViewModel.searchHistoryList.length, 1);
  });

  test("Hotel Search History Model", () {
    SearchHistory searchHistory = SearchHistory(
      keyword: 'test',
      checkInDate: '123',
      checkOutDate: '456',
      hotelId: "ABC123",
      cityId: "ABC123",
      countryId: "ABC123",
    );
    HotelSearchHistoryModel hotelSearchHistoryModel =
        HotelSearchHistoryModel.mapFromModel(searchHistory);
    expect(hotelSearchHistoryModel.cityId, "ABC123");
    expect(hotelSearchHistoryModel.hotelId, "ABC123");
  });

  test("Search History Model", () {
    HotelSearchHistory searchHistory = HotelSearchHistory(
      keyword: 'test',
      checkInDate: '123',
      checkOutDate: '456',
      hotelId: "ABC123",
      cityId: "ABC123",
      countryId: "ABC123",
    );
    HotelSearchHistoryModel hotelSearchHistoryModel =
        HotelSearchHistoryModel.mapFromHotelModel(searchHistory);
    expect(hotelSearchHistoryModel.cityId, "ABC123");
    expect(hotelSearchHistoryModel.hotelId, "ABC123");
  });
}
