import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_argument_domain.dart';
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_model_domain.dart';

import 'apply_promo_remote_data_source.dart';

class ApplyPromoMockDataSourceImpl implements ApplyPromoRemoteDataSource {
  ApplyPromoMockDataSourceImpl();

  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<ApplyPromoModelDomain> applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain) async {
    await Future.delayed(const Duration(milliseconds: 1));
    return ApplyPromoModelDomain.fromJson(_responseMock);
  }
}

String _responseMock = '''{
	"applyPromoCode": {
		"status": {
			"code": "1000",
			"header": "",
			"description": "Success"
		},
		"data": {
			"bookingUrn": "H22A-xy-1234",
			"priceDetails": {
				"effectiveDiscount": 80.0,
				"orderPrice": 200.0,
				"addonPrice": 200.0,
				"billingAmount": 320.0,
				"totalAmount": 400.0
			}
		}
	}
}''';

var responseMock1899 = '''{
	"applyPromoCode": {
		"status": {
			"code": "1899",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var responseMock1999 = '''{
	"applyPromoCode": {
		"status": {
			"code": "1999",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var responseMock3023 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3023",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var responseMock3024 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3024",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var responseMock3025 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3025",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var responseMock3028 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3028",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var responseMock3033 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3033",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var responseMock3034 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3034",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';

var responseMock3054 = '''{
	"applyPromoCode": {
		"status": {
			"code": "3054",
			"header": "",
			"description": "failure"
		},
		"data": null
	}
}''';
