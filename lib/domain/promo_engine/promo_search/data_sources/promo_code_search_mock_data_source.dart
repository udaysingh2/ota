import 'package:ota/domain/promo_engine/promo_search/data_sources/promo_code_search_remote_data_source.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_argument_domain.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_search_model_domain.dart';

class PromoCodeSearchMockDataSourceImpl
    implements PromoCodeSearchRemoteDataSource {
  PromoCodeSearchMockDataSourceImpl();

  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<PromoCodeSearchModelDomain> searchPromoCode(
      PromoCodeArgumentDomain promoCodeArgumentDomain) async {
    await Future.delayed(const Duration(milliseconds: 1));
    return PromoCodeSearchModelDomain.fromJson(_responseMock);
  }
}

String _responseMock = '''{
    "searchPromoCode": {
      "data": {
        "promotionId": 1,
        "promotionName": "RBH Special",
        "shortDescription": "ส่วนลดมูลค่า 50 บาท",
        "discount": 50.0,
        "maximumDiscount": 100.0,
        "discountType": "PERCENT",
        "discountFor": "ORDER",
        "promotionLink": "scbeasy://payments/creditcard/review/id/4567",
        "promotionType": "PUBLIC",
        "iconUrl": "scbeasy://payments/creditcard/review/id/4567",
        "voucherCode": "RBH50",
        "promotionCode": "RBH50",
        "startDate": "2020-07-24T08:44:39.000Z",
        "endDate": "2020-07-24T08:44:39.000Z",
        "applicationKey": "HOTEL"
      },
      "status": {
        "code": "1000",
        "header": "",
        "description": "Success"
      }
    }
  }''';
