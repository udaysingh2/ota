import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/hotel/hotel_addon_service/data_sources/hotel_service_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_addon_service/data_sources/hotel_service_remote_mock.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_result_model.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_data_argument.dart';
import 'package:ota/domain/hotel/hotel_addon_service/repositories/hotel_service_repository_impl.dart';
import '../../../modules/hotel/repositories/internet_failure_mock.dart';
import '../../../modules/hotel/repositories/internet_success_mock.dart';

class HotelServiceDataSourceFailureMock
    implements HotelServiceRemoteDataSource {
  Future<HotelServiceResultModel> getServiceCards(
      HotelServiceResultModel argument) {
    throw exp.ServerException(null);
  }

  @override
  Future<HotelServiceResultModel> getHotelAddonServiceData(
      HotelServiceDataArgument serviceDataArgument) {
    throw UnimplementedError();
  }
}

void main() {
  HotelServiceRepository? preferenceQuestionsRepositoryMock;
  HotelServiceRepository? preferenceQuestionsRepositoryServerException;
  HotelServiceDataArgument argument = HotelServiceDataArgument(
      checkInDate: "",
      checkOutDate: "",
      currency: "",
      hotelId: "",
      limit: 9,
      offset: 0);

  setUpAll(() async {
    preferenceQuestionsRepositoryMock = HotelServiceRepositoryImpl();

    preferenceQuestionsRepositoryMock = HotelServiceRepositoryImpl(
        remoteDataSource: HotelServicelMockDataSourceImpl(),
        internetInfo: InternetSuccessMock());

    preferenceQuestionsRepositoryServerException = HotelServiceRepositoryImpl(
        remoteDataSource: HotelServicelMockDataSourceImpl(),
        internetInfo: InternetFailureMock());
  });

  test("Hotel Addon Service Repository" 'With Success response', () async {
    final result = await preferenceQuestionsRepositoryMock!
        .getHotelAddonServiceData(argument);
    final HotelServiceResultModel serviceData = result.right;
    expect(serviceData.getAddonServices == null, false);
  });

  test("Hotel Addon Service Repository" 'With Server Exception response data',
      () async {
    final result = await preferenceQuestionsRepositoryServerException!
        .getHotelAddonServiceData(argument);
    expect(result.isLeft, true);
  });
}
