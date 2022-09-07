import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_detail/data_source/car_detail_mock_data_source.dart';
import 'package:ota/domain/car_rental/car_detail/data_source/car_detail_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_detail/model/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/car_rental/car_detail/model/add_favourite_model_domain.dart';
import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_argument_model.dart';
import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_model.dart';
import 'package:ota/domain/car_rental/car_detail/model/check_favourite_domain_model.dart';
import 'package:ota/domain/car_rental/car_detail/repositories/car_detail_repository_impl.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/favourites/models/unfavourite_model_domain.dart';

import '../../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../../modules/hotel/repositories/internet_success_mock.dart';

class CarDetailRemoteDataSourceFailureMock
    implements CarDetailRemoteDataSource {
  @override
  Future<AddfavouriteModelDomain> addFavouriteCar(
      {required AddFavoriteArgumentModelDomain favoriteArgumentModel,
      required String serviceName}) {
    throw exp.ServerException(null);
  }

  @override
  Future<CheckFavouriteDomainModel> checkFavouriteCar(
      {required String supplierId,
      required String carId,
      required String serviceName}) {
    throw exp.ServerException(null);
  }

  @override
  Future<CarDetailDomainModel> getCarDetail(
      CarDetailDomainArgumentModel argument) {
    throw exp.ServerException(null);
  }

  @override
  Future<UnFavouriteModelDomain> unfavouritesCar(
      {required String id,
      required String supplierId,
      required String serviceName}) {
    throw exp.ServerException(null);
  }
}

void main() {
  CarDetailRepository? carDetailRepositoryMock;
  CarDetailRepository? carDetailRepositoryInternetFailure;
  CarDetailRepository? carDetailRepositoryServerException;

  CarDetailDomainArgumentModel argumentModel = CarDetailDomainArgumentModel(
    supplierId: '',
    rentalType: '',
    carId: "",
    pickupLocationId: '',
    returnLocationId: '',
    pickupDate: '',
    returnDate: '',
    includeDriver: '',
    residenceCountry: '',
    currency: '',
    age: 2,
    pickupCounter: '',
    returnCounter: '',
  );
  AddFavoriteArgumentModelDomain addFavoriteArgumentModelDomain =
      AddFavoriteArgumentModelDomain(
          id: "id",
          supplierId: "supplierId",
          name: "name",
          location: "location",
          image: "image",
          pickupLocationId: "pickupLocationId",
          dropLocationId: "dropLocationId",
          pickupDate: "pickupDate",
          dropDate: "dropDate",
          rentalType: "rentalType",
          age: 2);

  setUpAll(() async {
    /// Code coverage for default implementation.
    carDetailRepositoryMock = CarDetailRepositoryImpl();

    /// Code coverage for mock class
    carDetailRepositoryMock = CarDetailRepositoryImpl(
        remoteDataSource: CarDetailMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    carDetailRepositoryServerException = CarDetailRepositoryImpl(
        remoteDataSource: CarDetailRemoteDataSourceFailureMock(),
        internetInfo: InternetSuccessMock());

    /// Coverage in-case of internet failure
    carDetailRepositoryInternetFailure = CarDetailRepositoryImpl(
        remoteDataSource: CarDetailRemoteDataSourceFailureMock(),
        internetInfo: InternetFailureMock());
  });

  test(
      'car Reservation Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result = await carDetailRepositoryMock!.getCarDetail(argumentModel);

    /// Get model from mock data.
    final CarDetailDomainModel bookingData = result.right;

    /// Condition check for booking data value null
    expect(bookingData.carDetailInfo != null, true);
  });

  test(
      'car Reservation Internet Failure Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result =
        await carDetailRepositoryInternetFailure!.getCarDetail(argumentModel);

    expect(result.isLeft, true);
  });

  test(
      'car reservation Repository Server Exception Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result =
        await carDetailRepositoryServerException!.getCarDetail(argumentModel);

    expect(result.isLeft, true);
  });

  test(
      'car Check favourite Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result = await carDetailRepositoryMock!
        .checkFavouriteCar(supplierId: '', serviceName: '', carId: '');

    /// Get model from mock data.
    final CheckFavouriteDomainModel bookingData = result.right;

    /// Condition check for booking data value null
    expect(bookingData.checkCarFavorites != null, false);
  });

  test(
      'car Check favouriteInternet Failure Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await carDetailRepositoryInternetFailure!
        .checkFavouriteCar(supplierId: '', serviceName: '', carId: '');

    expect(result.isLeft, true);
  });

  test(
      'car Check favourite Repository Server Exception Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result = await carDetailRepositoryServerException!
        .checkFavouriteCar(supplierId: '', serviceName: '', carId: '');

    expect(result.isLeft, true);
  });

  test(
      'car Add favourite Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result = await carDetailRepositoryMock!.addFavouriteCar(
        favoriteArgumentModel: addFavoriteArgumentModelDomain, serviceName: '');

    /// Get model from mock data.
    final AddfavouriteModelDomain? bookingData = result?.right;

    /// Condition check for booking data value null
    expect(bookingData?.addFavorite != null, true);
  });

  test(
      'car Add favouriteInternet Failure Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await carDetailRepositoryInternetFailure!.addFavouriteCar(
        favoriteArgumentModel: addFavoriteArgumentModelDomain, serviceName: '');

    expect(result?.isLeft, true);
  });

  test(
      'car Add favourite Repository Server Exception Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result = await carDetailRepositoryServerException!.addFavouriteCar(
        favoriteArgumentModel: addFavoriteArgumentModelDomain, serviceName: '');

    expect(result?.isLeft, true);
  });

  test(
      'car Un favourite Repository '
      'With Success response data', () async {
    /// Consent user cases impl
    final result = await carDetailRepositoryMock!
        .unfavouritesCar(serviceName: '', id: '', supplierId: '');

    /// Get model from mock data.
    final UnFavouriteModelDomain bookingData = result.right;

    /// Condition check for booking data value null
    expect(bookingData.status != null, false);
  });

  test(
      'car  Un favouriteInternet Failure Repository '
      'With Internet Failure response data', () async {
    /// Consent user cases impl
    final result = await carDetailRepositoryInternetFailure!
        .unfavouritesCar(serviceName: '', id: '', supplierId: '');

    expect(result.isLeft, true);
  });

  test(
      'car  Un favourite Repository Server Exception Repository'
      'With Server Exception response data', () async {
    /// Consent user cases impl
    final result = await carDetailRepositoryServerException!
        .unfavouritesCar(serviceName: '', id: '', supplierId: '');

    expect(result.isLeft, true);
  });
}
