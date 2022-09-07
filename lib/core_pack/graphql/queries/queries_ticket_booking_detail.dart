import 'package:ota/domain/tickets/ticket_booking_details/models/ticket_booking_details_argument_model.dart';

import '../../../core/query_names.dart';

class QueriesTicketBookingDetail {
  static String getTicketBookingDetailData(
      TicketBookingDetailArgumentDomain argument) {
    return '''
         mutation {
   ${QueryNames.shared.getTicketBookingDetail}(
    bookingDetailsRequest: {
	  bookingId:"${argument.bookingId}",
	  bookingUrn:"${argument.bookingUrn}",
	  bookingType:"${argument.bookingType}"
    }
  ) {
    data {
		 bookingStatus
		 activityStatus
		 bookingUrn  
		 bookingId   
		 orderId   
		 bookingType
		 promotionList{
		 	productType
		 	promotionCode
		 	title
		 	description
			web
			iconImage
      bannerDescDisplay
      line1
      line2
      promotionType
      productId
			}
		 ticketBookingDetail {
			 name 
			 imageUrl 
			 category  
			 location  
			 packageDetail  {
				 packageName
				 inclusions {
					 highlights 
						{
							 key   
							 value  
						}
					 all   
				}
				 cancellationPolicy  
				 durationText   
				 exclusions   
				 conditions   
				 shuttle   
				 meetingPoint
				 meetingPointLatitude
				 meetingPointLongitude     
				 schedule   
			}
			 ticketTypes {
				 name
				 price
				 noOfTickets
			}
			 information {
         description
         conditions
         howToUse
         openTime
         closeTime
			}
			 bookingDate
			 cancellationDate
       confirmationDate
             cancellationCharge
             cancellationReason
             totalRefundAmount
			 noOfDays  
			 participantInfo {
				 name 
				 surname
				 weight
				 dateOfBirth 
				 passportCountry
				 passportNumber
				 passportCountryIssue 
				 expiryDate
			}
			 providerName
			 supplierContact
			 paymentStatus 
			 netPrice 
			 totalPrice
			 discount
			  promotion {
                promotionId
                promotionName
                shortDescription
                discount
                maximumDiscount
                discountType
                discountFor
                promotionLink
                promotionType
                iconUrl
                voucherCode
                promotionCode
                startDate
                endDate
                applicationKey 
              }
               priceDetails {
                effectiveDiscount
                orderPrice
                addonPrice
                billingAmount
                totalAmount
              }
			 payment {
                amount
                cardNickName
                cardNo
                cardType
                type
                name
        }
      ticketId
			cityId
			countryId
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
