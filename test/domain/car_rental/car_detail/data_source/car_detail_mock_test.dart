import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/car_rental/car_detail/data_source/car_detail_mock_data_source.dart';
import 'package:ota/domain/car_rental/car_detail/data_source/car_detail_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_detail/model/add_favorite_argument_model_domain.dart';
import 'package:ota/domain/car_rental/car_detail/model/car_detail_domain_argument_model.dart';

void main() {
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

  TestWidgetsFlutterBinding.ensureInitialized();

  group("Car detail Mock Data source group", () {
    test("Car detail Data Source", () {
      CarDetailRemoteDataSource carDetailRemoteDataSource =
          CarDetailMockDataSourceImpl();
      carDetailRemoteDataSource.getCarDetail(argumentModel);
    });
    test("Car detail with success response data", () async {
      CarDetailRemoteDataSource carDetailRemoteDataSource =
          CarDetailMockDataSourceImpl();

      final result =
          await carDetailRemoteDataSource.getCarDetail(argumentModel);
      expect(result.carDetailInfo != null, true);
    });

    test("Car check favourite Data Source", () async {
      CarDetailRemoteDataSource carDetailRemoteDataSource =
          CarDetailMockDataSourceImpl();
      carDetailRemoteDataSource.checkFavouriteCar(
          serviceName: '', supplierId: '', carId: '');
    });
    test("Car check favourite with success response data", () async {
      CarDetailRemoteDataSource carDetailRemoteDataSource =
          CarDetailMockDataSourceImpl();

      final result = await carDetailRemoteDataSource.checkFavouriteCar(
          serviceName: '', supplierId: '', carId: '');
      expect(result.checkCarFavorites != null, false);
    });

    test("Car check un favourite Data Source", () async {
      CarDetailRemoteDataSource carDetailRemoteDataSource =
          CarDetailMockDataSourceImpl();
      carDetailRemoteDataSource.unfavouritesCar(
          serviceName: '', supplierId: '', id: '');
    });
    test("Car check un favourite with success response data", () async {
      CarDetailRemoteDataSource carDetailRemoteDataSource =
          CarDetailMockDataSourceImpl();

      final result = await carDetailRemoteDataSource.unfavouritesCar(
          serviceName: '', supplierId: '', id: '');
      expect(result.status != null, false);
    });

    test("Car check add favourite Data Source", () async {
      CarDetailRemoteDataSource carDetailRemoteDataSource =
          CarDetailMockDataSourceImpl();
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
      carDetailRemoteDataSource.addFavouriteCar(
          serviceName: '',
          favoriteArgumentModel: addFavoriteArgumentModelDomain);
    });
    test("Car check add favourite with success response data", () async {
      CarDetailRemoteDataSource carDetailRemoteDataSource =
          CarDetailMockDataSourceImpl();
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
      final result = await carDetailRemoteDataSource.addFavouriteCar(
          serviceName: '',
          favoriteArgumentModel: addFavoriteArgumentModelDomain);
      expect(result.addFavorite != null, true);
    });

    test('Car favourite Mock Test source', () async {
      String response = CarDetailMockDataSourceImpl.getMockData();
      expect(response, isNotEmpty);
    });
  });
}
