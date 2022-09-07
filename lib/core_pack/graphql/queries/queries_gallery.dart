import 'package:ota/domain/gallery/models/gallery_argument_model_domain.dart';
import 'package:ota/modules/favourites/view_model/ota_favourite_service_type.dart';

class QueriesGallery {
  static String getGalleryData(
      GalleryArgumentDomain argument, String offset, String limit) {
    if (argument.serviceName == OtaFavouriteServiceType.ticket) {
      return getTicketGalleryData(argument.serviceId, offset, limit);
    } else {
      return getTourGalleryData(argument.serviceId, offset, limit);
    }
  }

  static String getTourGalleryData(
      String serviceId, String offset, String limit) {
    return '''
         query{
          getAllTourImages(
          tourId: "$serviceId"
          galleryOffset: "$offset"
          galleryLimit: "$limit"
          ){
            data {
              images    
            }
            status{
              code
              header
              description
            }
          }
        }
    ''';
  }

  static String getTicketGalleryData(
      String serviceId, String offset, String limit) {
    return '''
         query{
          getAllTicketImages(
          ticketId: "$serviceId"
          galleryOffset: "$offset"
          galleryLimit: "$limit"
          ){
            data {
              images    
            }
            status{
              code
              header
              description
            }
          }
        }
    ''';
  }
}
