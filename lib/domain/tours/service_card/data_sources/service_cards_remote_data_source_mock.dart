import 'package:ota/domain/tours/service_card/data_sources/service_card_remote_data_source.dart';
import 'package:ota/domain/tours/service_card/models/service_card_model_domain.dart';

class ServiceCardMockDataSourceImpl implements ServiceCardRemoteDataSource {
  ServiceCardMockDataSourceImpl();
  @override
  Future<ServiceCardModelDomain> getServiceCardData() async {
    await Future.delayed(const Duration(seconds: 1));
    return ServiceCardModelDomain.fromJson(_responseMock);
  }
}

var _responseMock = '''
{
  "getTourServiceCards": {
    "data": {
      "ticket": {
        "imageTitle": "ตั๋วกิจกรรม",
        "imageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/image/ticket.jpg",
        "title": "ตั๋วกิจกรรมหลากหลาย",
        "description": "1000+ ผู้ให้บริการ",
        "deeplinkUrl": "https://robinhood/",
        "sortSeq": 2
      },
      "tour": {
        "imageTitle": "ทัวร์",
        "imageUrl": "https://static-dev.alp-robinhood.com/ota/serviceCard/image/tour.jpg",
        "title": "เดย์ทัวร์และเพคเกจทัวร์",
        "description": "3,000+ ผู้ให้บริการ",
        "deeplinkUrl": "https://robinhood/",
        "sortSeq": 1
      }
    },
    "status": {
      "code": "1000",
      "header": "success",
      "description": ""
    }
  }
}
''';
