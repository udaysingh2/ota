import 'package:ota/domain/tours/tour_recent_playlist/models/tour_recent_playlist_argument_model.dart';

class QueriesTourRecentPlaylist {
  static String getTourRecentPlaylist(
      TourRecentPlaylistArgumentDomain argument) {
    return '''    
query {
	getTourRecentlyViewedItems(playlistInput: {
		serviceName: "${argument.serviceName}",
		offset: ${argument.offset},
		limit: ${argument.limit}
	}) {
		data {
			recentViewPlaylist {
				id
				cityId
				countryId
				name
				image
				locationName
				category
				type
				promotions {
          productId
          productType
          promotionType
          promotionCode
          line1
          line2
          startDate
          endDate
          title
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
