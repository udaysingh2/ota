import 'package:ota/domain/landing/service_card/data_sources/service_card_remote_data_source.dart';
import 'package:ota/domain/landing/service_card/models/service_card_model_domain.dart';

class ServiceCardMockDataSourceImpl implements ServiceCardRemoteDataSource {
  ServiceCardMockDataSourceImpl();

  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<ServiceCardModelDomainData> getServiceCardData() async {
    await Future.delayed(const Duration(milliseconds: 1));
    return ServiceCardModelDomainData.fromJson(_responseMock);
  }
}

var _responseMock = '''{
	"getServiceCard": {
		"data": {
			"defaultCustomText": "Where are you going?",
			"backgroundUrl": "https://static-dev.alp-robinhood.com/ota/background/image/OTA.jpg",
			"businessCards": [{
					"title": "more than 1,000",
					"serviceText": "Hotels",
					"description": "100,000+ Hotels",
					"imageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/image/1.jpg",
					"largeImageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/1.jpg",
					"serviceBackgroundUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/1.jpg",
					"sortSeq": "1",
					"service": "HOTEL",
					"deeplinkUrl": "https://robinhood/"
				},
				{
					"title": "more than 1,000",
					"serviceText": "Flights",
					"description": "50,000+ Flights",
					"imageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/image/2.jpg",
					"largeImageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/2.jpg",
					"serviceBackgroundUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/2.jpg",
					"sortSeq": "2",
					"service": "INSURANCE",
					"deeplinkUrl": "https://robinhood/"
				},
				{
					"title": "more than 1,000",
					"serviceText": "Tours and Activites",
					"description": "1,000+ Tours and Activites",
					"imageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/image/3.jpg",
					"largeImageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/3.jpg",
					"serviceBackgroundUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/3.jpg",
					"sortSeq": "3",
					"service": "TOUR",
					"deeplinkUrl": "https://robinhood/"
				},
				{
					"title": "more than 1,000",
					"serviceText": "Car rentals",
					"description": "20,000+ Car rentals",
					"imageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/image/4.jpg",
					"largeImageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/4.jpg",
					"serviceBackgroundUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/largeImage/4.jpg",
					"sortSeq": "4",
					"service": "CARRENTAL",
					"deeplinkUrl": "https://robinhood/"
				}
			]
		},
		"status": {
			"code": "1000",
			"header": "Success",
			"description": null
		}
	}
}
''';
