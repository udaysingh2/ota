import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core_pack/graphql/graphql_client.dart';

import '../models/argument_data_model_automation.dart';
import '../models/argument_data_model_room_detail_automation.dart';
import '../models/argument_playlist_data_model_automation.dart';
import '../models/favourites_result_model_domain_automation.dart';
import '../models/gallery_result_model_automation.dart';
import '../models/hotel_detail_model_automation.dart';
import '../models/landing_models_automation.dart';
import '../models/ota_filter_sort_data_model_automation.dart';
import '../models/ota_search_data_argument_automation.dart';
import '../models/ota_search_model_automation.dart';
import '../models/payment_method_model_domain_automation.dart';
import '../models/playlist_result_data_model_automation.dart';
import '../models/room_detail_model_automation.dart';
import '../models/search_recommendation_model_automation.dart';
import '../models/search_service_type_automation.dart';
import '../models/search_suggestion_data_argument_model_automation.dart';
import '../models/search_suggestion_model_automation.dart';
import '../models/splash_data_model_automation.dart';
import '../queries/queries_favorites_automation.dart';
import '../queries/queries_landing_automation.dart';
import '../queries/queries_ota_filter_sort_automation.dart';
import '../queries/queries_ota_search_data_automation.dart';
import '../queries/queries_payment_method_automation.dart';
import '../queries/queries_playlist_automation.dart';
import '../queries/queries_room_automation.dart';
import '../queries/queries_search_automation.dart';
import '../queries/queries_splash_automation.dart';
import 'queries_hotel_automation.dart';

/// Interface for Hotel detail Data remote data source.
abstract class OtaConsolidatedRemoteDataSource {
  Future<HotelAutomation> getHotelDetail(
      HotelDetailDataArgumentAutomation argument);
  Future<GalleryResultModelAutomation> getGalleryData(
      HotelDetailDataArgumentAutomation argument, String offset, String limit);
  Future<LandingDataAutomation> getLandingPage();
  Future<PlaylistResultModelAutomation> getPlayListData(
      PlayListDataArgumentAutomation argument);
  Future<RoomDetailDataAutomation> getRoomDetail(
      RoomDetailDataArgumentAutomation argument);
  Future<SplashModelAutomation> getSplashData();
  Future<SearchSuggestionModelAutomation> getSearchSuggestionData(
      SuggestionDataArgumentAutomation suggestionDataArgument);

  Future<SearchRecommendationModelAutomation> getSearchRecommendationData(
      SearchServiceTypeAutomation serviceType);
  Future<OtaFilterSortAutomation> getOtaSearchSortData();
  Future<OtaSearchDataAutomation> getOtaSearchData(
      OtaSearchDataArgumentAutomation argument);
  Future<PaymentMethodModelDomainAutomation> getPaymentMethodListData(
      String userId);
  Future<FavouritesResultModelDomainAutomation> getFavouritesData(
      String type, int offset, int limit);
}

///This class contains all the existing get request calls across the OTA application for automated integration tests
class OtaConsolidatedRemoteDataSourceImpl
    implements OtaConsolidatedRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  OtaConsolidatedRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
      print(
          '2.The graphql response from OtaConsolidated class is============ $graphQlResponse');
    } else {
      this.graphQlResponse = graphQlResponse;
      print(
          '3.The graphql response from OtaConsolidated class is============ ${this.graphQlResponse}');
    }
  }

  @override
  Future<SplashModelAutomation> getSplashData() async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics can be ignored for integration test
        queryName: "",
        query: QueriesGeneralAutomation.getSplashScreenData());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return SplashModelAutomation.fromMap(result.data!);
    }
  }

  @override
  Future<PlaylistResultModelAutomation> getPlayListData(
      PlayListDataArgumentAutomation argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics can be ignored for integration test
        queryName: "",
        query: QueriesPlayListAutomation.getPlayListData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return PlaylistResultModelAutomation.fromMap(result.data!);
    }
  }

  @override
  Future<LandingDataAutomation> getLandingPage() async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics can be ignored for integration test
        queryName: "",
        query: QueriesLandingAutomation.getLandingPageData());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return LandingDataAutomation.fromMap(result.data);
    }
  }

  @override
  Future<RoomDetailDataAutomation> getRoomDetail(
      RoomDetailDataArgumentAutomation argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics can be ignored for integration test
        queryName: "",
        query: QueriesRoomAutomation.getRoomDetailData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return RoomDetailDataAutomation.fromMap(result.data!);
    }
  }

  @override
  Future<GalleryResultModelAutomation> getGalleryData(
      HotelDetailDataArgumentAutomation argument,
      String offset,
      String limit) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics can be ignored for integration test
        queryName: "",
        query: QueriesHotelAutomation.getHotelGalleryData(
            argument, offset, limit));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return GalleryResultModelAutomation.fromMap(result.data!);
    }
  }

  @override
  Future<HotelAutomation> getHotelDetail(
      HotelDetailDataArgumentAutomation argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics can be ignored for integration test
        queryName: "",
        query: QueriesHotelAutomation.getHotelDetailData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return HotelAutomation.fromMap(result.data!);
    }
  }

  @override
  Future<SearchRecommendationModelAutomation> getSearchRecommendationData(
      SearchServiceTypeAutomation serviceType) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics can be ignored for integration test
        queryName: "",
        query:
            QueriesSearchAutomation.getSearchRecommendationData(serviceType));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return SearchRecommendationModelAutomation.fromMap(result.data!);
    }
  }

  @override
  Future<SearchSuggestionModelAutomation> getSearchSuggestionData(
      SuggestionDataArgumentAutomation suggestionDataArgument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics can be ignored for integration test
        queryName: "",
        query: QueriesSearchAutomation.getSearchSuggestionData(
            suggestionDataArgument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return SearchSuggestionModelAutomation.fromMap(result.data!);
    }
  }

  @override
  Future<OtaFilterSortAutomation> getOtaSearchSortData() async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics can be ignored for integration test
        queryName: "",
        query: QueriesOtaFilterSortAutomation.getOtaFilterSortData());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return OtaFilterSortAutomation.fromMap(
          result.data!["getSortCriteriaDetails"]!);
    }
  }

  @override
  Future<OtaSearchDataAutomation> getOtaSearchData(
      OtaSearchDataArgumentAutomation argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics can be ignored for integration test
        queryName: "",
        query: QueriesOtaSearchAutomation.getOtaSearchData(argument));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return OtaSearchDataAutomation.fromMap(result.data!);
    }
  }

  @override
  Future<PaymentMethodModelDomainAutomation> getPaymentMethodListData(
      String userId) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics can be ignored for integration test
        queryName: "",
        query: QueriesPaymentMethodAutomation.getPaymentMethodListData());
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return PaymentMethodModelDomainAutomation.fromMap(result.data!);
    }
  }

  @override
  Future<FavouritesResultModelDomainAutomation> getFavouritesData(
      String type, int offset, int limit) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics can be ignored for integration test
        queryName: "",
        query:
            QueriesFavouritesAutomation.getFavouritesData(type, offset, limit));
    print('----------Result.data ${result.data}');
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return FavouritesResultModelDomainAutomation.fromMap(result.data!);
    }
  }
}
