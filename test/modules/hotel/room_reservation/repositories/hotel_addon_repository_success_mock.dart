import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/hotel/hotel_addon_service/data_sources/hotel_service_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_data_argument.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_result_model.dart';
import 'package:ota/domain/hotel/hotel_addon_service/repositories/hotel_service_repository_impl.dart';

import '../../../../mocks/fixture_reader.dart';

class HotelAddOnRepositoryImplSuccessMock
    implements HotelServiceRepositoryImpl {
  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  HotelServiceRemoteDataSource? hotelServiceRemoteDataSource;

  @override
  Future<Either<Failure, HotelServiceResultModel>> getHotelAddonServiceData(
      HotelServiceDataArgument serviceDataArgument) async {
    String json = fixture("hotel/room_reservation/addon_service_mock.json");
    HotelServiceResultModel model = HotelServiceResultModel.fromJson(json);
    return Right(model);
  }
}
