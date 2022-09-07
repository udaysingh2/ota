import '../models/argument_data_model_automation.dart';

class QueriesHotelAutomation {
  static String getHotelDetailData(HotelDetailDataArgumentAutomation argument) {
    var roomsQuery = argument.rooms.map((result) => result.toMap()).toList();
    return '''
          mutation {
            getHotelDetails(
              hotelRequest: {
                hotelId: "${argument.hotelId}"
                cityId: "${argument.cityId}"
                checkInDate: "${argument.checkInDate}"
                checkOutDate: "${argument.checkOutDate}"
                roomType: "Double"
                currency: "${argument.currency}"
                countryId: "${argument.countryId}"
                room: $roomsQuery
              }
            ) {
              data {
                id
                name
                rating
                ratingCount
                ratingText
                location
                address
                isFavourite
                images {
                 baseUri
                  cover
                  galleryCount
                  gallery
                }
                facilities {
                  list {
                    key
                    value
                  }
                  main {
                    key
                    value
                  }
                }
                rooms {
                  roomName
                  facility {
                    key
                    value
                  }
                  details {
                    roomCode
                    roomOfferName
                    roomType
                    nightPrice
                    totalPrice
                    roomOffer {
                      breakfast
                      payNow
                      cancellationPolicy
                    }
                  }
                }
              }
              status {
                code
                header
              }
              metadata {
                source
                timeStamp
              }
            }
          }
    ''';
  }

  static String getHotelGalleryData(
      HotelDetailDataArgumentAutomation argument, String offset, String limit) {
    return '''
          mutation{
            getImages(
              hotelId: "${argument.hotelId}"
              cityId: "${argument.cityId}"
              checkInDate: "${argument.checkInDate}"
              checkOutDate: "${argument.checkOutDate}"
              roomType: "Double"
              room:"${argument.rooms}"
              currency: "${argument.currency}"
              countryId: "${argument.countryId}"
              galleryOffset: "$offset",
              galleryLimit: "$limit"
            ) {
              data {
                images {
                  baseUri
                  gallery
                }
              }
              status {
                code
                header
              }
            }
          }
    ''';
  }
}
