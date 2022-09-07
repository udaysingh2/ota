import 'package:ota/domain/virtual_account/models/virtual_payment_model_domain.dart';

import 'virtual_payment_remote_data_source.dart';

class VirtualPaymentMockDataSourceImpl
    implements VirtualPaymentRemoteDataSource {
  VirtualPaymentMockDataSourceImpl();

  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<VirtualPaymentModelDomain> getVirtualWalletBalance() async {
    await Future.delayed(const Duration(milliseconds: 1));
    return VirtualPaymentModelDomain.fromJson(_responseMock);
  }
}

String _responseMock = '''{
	"getVaBalance": {
		"data": {
			"pocketStatus": "ACTIVE",
			"balance": 11.2,
			"currency": "THB",
			"balanceStatus": "ACTIVE"
		},
		"status": {
			"code": "1000",
			"header": "Success",
			"description": "Success"
		}
	}
}''';
