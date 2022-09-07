import 'package:ota/domain/room_gallery/models/room_gallery_argument_domain.dart';

class QueriesRoomGallery {
  static String getRoomGalleryData(
      RoomGalleryArgumentDomain argument, int offset, int limit) {
    return '''
        mutation GetRoomImages {
          getRoomImages(
            roomImagesRequest: {
              hotelId: "${argument.hotelId}"
              roomId: "${argument.roomId}"
              limit: $limit
              offset: $offset
            }
          ) {
            data {
              roomImageCount
              images {
                URL
              }
            }
            status {
              description
              header
              code
            }
          }
        }
    ''';
  }
}
