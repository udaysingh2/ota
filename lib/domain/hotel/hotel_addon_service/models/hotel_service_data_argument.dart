import 'package:ota/modules/hotel/room_reservation/addon_service/view_model/hotel_service_view_argument.dart';

class HotelServiceDataArgument {
  final String hotelId;
  final String checkInDate;
  final String checkOutDate;
  final String currency;
  final int limit;
  final int offset;

  HotelServiceDataArgument({
    required this.hotelId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.currency,
    required this.limit,
    required this.offset,
  });

  factory HotelServiceDataArgument.fromViewArgument(
      HotelServiceViewArgument viewArgument, int limit, int offset) {
    return HotelServiceDataArgument(
      hotelId: viewArgument.hotelId,
      checkInDate: viewArgument.checkInDate,
      checkOutDate: viewArgument.checkOutDate,
      currency: viewArgument.currency,
      limit: limit,
      offset: offset,
    );
  }
}
