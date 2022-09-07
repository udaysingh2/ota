import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_data_argument.dart';
import 'package:ota/domain/hotel/hotel_addon_service/models/hotel_service_result_model.dart';
import 'package:ota/domain/hotel/hotel_addon_service/usecases/hotel_reservation_use_cases.dart';

class AddOnViewUseCasesSuccessMock extends HotelReservationUseCasesImpl {
  @override
  Future<Either<Failure, HotelServiceResultModel>?> getHotelAddonServiceData(
      HotelServiceDataArgument serviceDataArgument) async {
    return Right(
      HotelServiceResultModel(
        getAddonServices: GetAddonServices(
          data: Data(
            hotelEnhancements: [
              HotelEnhancement(
                image: 'image',
                description: 'description',
                currency: 'currency',
                hotelEnhancementId: 'hotelEnhancementId',
                hotelEnhancementName: 'hotelEnhancementName',
                isFlight: true,
                price: '1000',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddOnViewUseCasesFailureMock extends HotelReservationUseCasesImpl {
  @override
  Future<Either<Failure, HotelServiceResultModel>?> getHotelAddonServiceData(
      HotelServiceDataArgument serviceDataArgument) async {
    return Left(
      InternetFailure(),
    );
  }
}
