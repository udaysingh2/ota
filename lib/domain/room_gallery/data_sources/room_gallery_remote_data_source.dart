import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_room_gallery.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_argument_domain.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_model_domain.dart';

/// Interface for Gallery Data remote data source.
abstract class RoomGalleryRemoteDataSource {
  /// Call API to get the Gallery Screen details.
  ///
  /// [hotelId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  Future<RoomGalleryModelDomain> getRoomGalleryData(
      RoomGalleryArgumentDomain argument, int offset, int limit);
}

/// GalleryRemoteDataSourceImpl will contain the GalleryRemoteDataSource implementation.
class RoomGalleryRemoteDataSourceImpl implements RoomGalleryRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  RoomGalleryRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
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
  /// [hotelId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  @override
  Future<RoomGalleryModelDomain> getRoomGalleryData(
      RoomGalleryArgumentDomain argument, int offset, int limit) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        //This is mandatory for crashlytics provide the query name here
        queryName: QueryNames.shared.getRoomImages,
        query: QueriesRoomGallery.getRoomGalleryData(argument, offset, limit));
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return RoomGalleryModelDomain.fromMap(result.data!);
    }
  }
}
