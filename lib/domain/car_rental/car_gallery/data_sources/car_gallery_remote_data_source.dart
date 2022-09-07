import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
//import 'package:ota/core_pack/graphql/queries/queries_room_gallery.dart';
// import 'package:ota/domain/room_gallery/models/room_gallery_argument_domain.dart';
// import 'package:ota/domain/room_gallery/models/room_gallery_model_domain.dart';
import 'package:ota/core_pack/graphql/queries/queries_car_gallery.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_argument_domain.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_model_domain.dart';

/// Interface for Gallery Data remote data source.
abstract class CarGalleryRemoteDataSource {
  /// Call API to get the Gallery Screen details.
  ///
  /// [hotelId] to get the Gallery Data for users.
  /// [Either<Failure, GalleryResultModel>] to handle the Failure or result data.
  Future<CarGalleryModelDomain> getCarGalleryData(
      CarGalleryArgumentDomain argument, int offset, int limit);
}

/// GalleryRemoteDataSourceImpl will contain the GalleryRemoteDataSource implementation.
class CarGalleryRemoteDataSourceImpl implements CarGalleryRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  CarGalleryRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
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
  Future<CarGalleryModelDomain> getCarGalleryData(
      CarGalleryArgumentDomain argument, int offset, int limit) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query: QueriesCarGallery.getCarGalleryData(argument, offset, limit),
        queryName: QueryNames.shared.getAllCarRentalImages);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      // return CarGalleryModelDomain.fromMap(result.data!);
      CarGalleryModelDomain carGalleryModelDomain =
          CarGalleryModelDomain.fromMap(result.data!);
      return carGalleryModelDomain;
    }
  }
}
