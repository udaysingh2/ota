import 'package:ota/domain/payment_method/data_sources/payment_method_remote_data_source.dart';
import 'package:ota/domain/payment_method/models/payment_method_model_domain.dart';

class PaymentMethodMockDataSourceImpl implements PaymentMethodRemoteDataSource {
  PaymentMethodMockDataSourceImpl();
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<PaymentMethodModelDomain> getPaymentMethodListData(
      String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    return PaymentMethodModelDomain.fromJson(_responseMock);
  }
}

String _responseMock = '''{
  "getCustomerPaymentMethodDetails": {
    "data": {
      "cardCurrent": 10,
      "cardMaximum": 40,
      "paymentList": [
        {
          "paymentMethodId": "1AB23456C7890123D",
          "sortSequence": 1,
          "cardMask": "***3456",
          "cardType": "VISA",
          "paymentType":"CREDIT_CARD",
          "cardBank": "",
          "defaultMethodFlag": false,
          "nickname": "My Visa",
          "paymentStatus": "ACTIVE"
        },
        {
          "paymentMethodId": "1MH23456Z789776D",
          "sortSequence": 2,
          "cardMask": "***2234",
          "cardType": "JCB",
          "paymentType":"CREDIT_CARD",
          "cardBank": "",
          "defaultMethodFlag": true,
          "nickname": "My Jcb",
          "paymentStatus": "ACTIVE"
        },
        {
          "paymentMethodId": "1AB2C7890123D",
          "sortSequence": 3,
          "cardMask": "***7688",
          "cardType": "MASTERCARD",
          "paymentType":"DEBIT_CARD",
          "cardBank": "",
          "defaultMethodFlag": false,
          "nickname": "My Mastercard",
          "paymentStatus": "ACTIVE"
        }
      ]
    },
    "status": {
      "code": "1000",
      "header": "Success",
      "description": "Success"
    }
  }
}''';
