//import 'package:ota/domain/room_gallery/models/room_gallery_argument_domain.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_argument_domain.dart';

class QueriesCarGallery {
  static String getCarGalleryData(
      CarGalleryArgumentDomain argument, int offset, int limit) {
    return '''  
query {
  getAllCarRentalImages(
    lazyLoadRequest: { carId: "${argument.carId}", galleryOffset: "$offset", galleryLimit: "$limit" }
  ) {
    data {
      id
      images {
        thumb
        full
      }
    }
  }
}
    ''';
  }
}
