import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_gallery.dart';
import 'package:ota/core_pack/graphql/queries/queries_hotel.dart';
import 'package:ota/domain/gallery/models/gallery_argument_model_domain.dart';
import 'package:ota/domain/gallery/models/gallery_model_domain.dart';
import 'package:ota/domain/gallery/models/gallery_result_model.dart';
import 'package:ota/domain/hotel/hotel_detail/models/argument_data_model.dart';

/// Interface for Gallery Data remote data source.
abstract class GalleryRemoteDataSource {
  /// Call API to get the Gallery Screen details.
  ///
  /// [tourId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  Future<GalleryResultModel> getGalleryData(
      HotelDetailDataArgument argument, String offset, String limit);

  /// Call API to get the Gallery Screen details.
  ///
  /// [tourId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  Future<GalleryModelDomain> getGalleryImages(
      GalleryArgumentDomain argument, String offset, String limit);
}

/// GalleryRemoteDataSourceImpl will contain the GalleryRemoteDataSource implementation.
class GalleryRemoteDataSourceImpl implements GalleryRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  GalleryRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }

  /// Call API to get the Gallery Screen details.
  ///
  /// [tourId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  @override
  Future<GalleryResultModel> getGalleryData(
      HotelDetailDataArgument argument, String offset, String limit) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getImages,
        query: QueriesHotel.getHotelGalleryData(argument, offset, limit));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return GalleryResultModel.fromMap(result.data!);
    }
  }

  /// Call API to get the Gallery Screen details.
  ///
  /// [tourId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  @override
  Future<GalleryModelDomain> getGalleryImages(
      GalleryArgumentDomain argument, String offset, String limit) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getGalleryImages,
        query: QueriesGallery.getGalleryData(argument, offset, limit));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return GalleryModelDomain.fromMap(result.data!);
    }
  }
}
