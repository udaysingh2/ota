import 'package:ota/common/network/exceptions.dart';
import 'package:ota/domain/hotel/hotel_booking/data_sources/hotel_booking_list_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_booking/models/hotel_booking_argument_domain.dart';
import 'package:ota/domain/hotel/hotel_booking/models/hotel_booking_list_model_domain.dart';

class HotelBookingsServerFailureDataSourceMock
    implements HotelBookingListRemoteDataSource {
  @override
  Future<HotelBookingListModelDomain> getHotelBookingListData(
      HotelBookingArgumentDomain args) async {
    throw ServerException(null);
  }
}
