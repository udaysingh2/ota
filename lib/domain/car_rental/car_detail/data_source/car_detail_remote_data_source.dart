import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/core/query_names.dart';
import 'package:ota/core_pack/graphql/graphql_client.dart';
import 'package:ota/core_pack/graphql/queries/queries_car_detail.dart';
import 'package:ota/domain/car_rental/car_detail/model/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_argument_model.dart';
import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_model.dart';
import 'package:ota/domain/car_rental/car_detail/model/check_favourite_domain_model.dart';
import '../../../../core_pack/graphql/queries/queries_favourites_car_rental.dart';
import '../../../favourites/models/unfavourite_model_domain.dart';
import '../model/add_favourite_model_domain.dart';

/// Interface for Car detail Data remote data source.
abstract class CarDetailRemoteDataSource {
  Future<CarDetailDomainModel> getCarDetail(
      CarDetailDomainArgumentModel argument);

  Future<CheckFavouriteDomainModel> checkFavouriteCar({
    required String supplierId,
    required String carId,
    required String serviceName,
  });

  Future<UnFavouriteModelDomain> unfavouritesCar({
    required String id,
    required String supplierId,
    required String serviceName,
  });

  Future<AddfavouriteModelDomain> addFavouriteCar(
      {required AddFavoriteArgumentModelDomain favoriteArgumentModel,
      required String serviceName});
}

class CarDetailRemoteDataSourceImpl implements CarDetailRemoteDataSource {
  GraphQlResponse? graphQlResponse;
  static GraphQlResponse? _mockGraphQlResponse;

  static setMock(GraphQlResponse? graphQlResponse) {
    _mockGraphQlResponse = graphQlResponse;
  }

  CarDetailRemoteDataSourceImpl({GraphQlResponse? graphQlResponse}) {
    if (_mockGraphQlResponse != null) {
      this.graphQlResponse = _mockGraphQlResponse;
    } else if (graphQlResponse == null) {
      this.graphQlResponse = GraphQlResponseImpl();
    } else {
      this.graphQlResponse = graphQlResponse;
    }
  }
  @override
  Future<CarDetailDomainModel> getCarDetail(
      CarDetailDomainArgumentModel argument) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query: QueriesCarDeatil.getCarDetailData(argument),
        queryName: QueryNames.shared.getCarRentalDetails);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return CarDetailDomainModel.fromMap(result.data?['getCarRentalDetails']);
    }
  }

  @override
  Future<AddfavouriteModelDomain> addFavouriteCar(
      {required AddFavoriteArgumentModelDomain favoriteArgumentModel,
      required String serviceName}) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query: QueriesFavouritesCarRental.addFavourite(
            favoriteArgumentModel, serviceName),
        queryName: QueryNames.shared.addFavorite);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return AddfavouriteModelDomain.fromMap(result.data!);
    }
  }

  @override
  Future<CheckFavouriteDomainModel> checkFavouriteCar(
      {required String carId,
      required String supplierId,
      required String serviceName}) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query: QueriesFavouritesCarRental.checkFavourite(
            carId, supplierId, serviceName),
        queryName: QueryNames.shared.checkFavorites);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return CheckFavouriteDomainModel.fromMap(result.data!);
    }
  }

  @override
  Future<UnFavouriteModelDomain> unfavouritesCar(
      {required String id,
      required String supplierId,
      required String serviceName}) async {
    final QueryResult result = await graphQlResponse!.getGraphQlResponse(
        query: QueriesFavouritesCarRental.unfavouriteCar(
            id, supplierId, serviceName),
        queryName: QueryNames.shared.deleteFavorite);
    if (result.hasException) {
      throw exp.ServerException(result.exception!);
    } else {
      return UnFavouriteModelDomain.fromMap(result.data!["deleteFavorite"]);
    }
  }
}
