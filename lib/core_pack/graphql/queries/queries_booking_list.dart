import 'package:ota/domain/managed_booking/models/booking_argument_domain.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';

class QueriesBookingList {
  static String getBookingListData(BookingArgumentDomain argument) {
    return '''
          mutation {
            getBookingSummaryV2(
              bookingSummaryRequest: {
                serviceType: "${argument.serviceType}"
                activityType: "${argument.activityType}"
                limit: ${argument.limit}
                pageNo: ${argument.pageNo}
              }
            ) {
              data {
                totalPageNumber
                bookingDetails {
                  serviceType
                  sortDateTime
                  sortPriority
                  ${_getServiceTypeModel(argument.serviceType)}
                }
              }
              status {
                code
                header
                description
              }
            }
          }''';
  }

  static String _getServiceTypeModel(String serviceType) {
    switch (serviceType) {
      case OtaServiceType.hotel:
        return '''hotel {
                    name
                    totalPrice
                    checkInDate
                    checkOutDate
                    bookingUrn
                    status
                    bookingId
                    paymentStatus
                    activityStatus
                  }''';
      case OtaServiceType.tour:
        return '''tour {
                      subServiceType
                      name
                      totalPrice
                      startTimeAMPM
                      bookingUrn
                      status
                      bookingDate
                      bookingId
                      paymentStatus
                      activityStatus
                    }''';
      case OtaServiceType.carRental:
        return '''car {
                    name
                    totalPrice
                    supplierName
                    bookingUrn
                    status
                    bookingSummaryStatus
                    pickupDateTime
                    returnDateTime
                    bookingId
                    returnExtraCharge
                  }''';
      default:
        return '''hotel {
                    name
                    totalPrice
                    checkInDate
                    checkOutDate
                    bookingUrn
                    status
                    bookingId
                    paymentStatus
                    activityStatus
                  }''';
    }
  }
}
