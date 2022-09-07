import 'package:ota/domain/promo_engine/remove_promo_code/data_sources/remove_promo_code_remote_data_sources.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_argument_domain.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_model_domain.dart';

class RemovePromoCodeMockDataSourceImpl
    implements RemovePromoCodeRemoteDataSource {
  RemovePromoCodeMockDataSourceImpl();

  static String getMockData() => _responseMock;

  @override
  Future<RemovePromoCodeModelDomain> removePromoCodeData(
      RemovePromoCodeArgumentDomain argumentDomain) async {
    await Future.delayed(const Duration(milliseconds: 1));
    return RemovePromoCodeModelDomain.fromJson(_responseMock);
  }
}

String _responseMock = '''
{
  "removePromoCode": {
      "data": {
          "removed": true,
          "priceDetails": {
              "orderPrice": 200.0,
              "addonPrice": 200.0,
              "totalAmount": 400.0
          }
      },
      "status": {
        "code": "1000",
        "header": "",
        "description": "Success"
      }
    }
  }''';
