import 'package:ota/domain/hotel/hotel_booking/models/hotel_booking_argument_domain.dart';

class QueriesHotelBookingList {
  static String getHotelBookingListData(HotelBookingArgumentDomain argument) {
    return '''
          mutation {
  getBookingSummaryV2(
    bookingSummaryRequest: {
      serviceType : "${argument.serviceType}"
      activityType : "${argument.activityType}"
      limit : ${argument.limit}
      pageNo : ${argument.pageNo}
    }
  ) {
    data {
      totalPageNumber
      bookingDetails {
	  	serviceType   
	  	sortDateTime 
	  	sortPriority 
        hotel {
          name
          totalPrice
          checkInDate
          checkOutDate
          bookingUrn
          status
          bookingId
          paymentStatus
          activityStatus
        }
      }
    }
    status {
      code
      header
      description
    }
  }
}
    ''';
  }
}
