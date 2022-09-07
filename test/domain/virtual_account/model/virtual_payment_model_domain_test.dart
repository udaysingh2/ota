import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/virtual_account/models/virtual_payment_model_domain.dart';

void main() {
  var json = """
  {
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
  } """;
  test("Virtual Payment Model Domain Test", () {
    VirtualPaymentModelDomain virtualPaymentModelDomain =
        VirtualPaymentModelDomain.fromJson(json);
    expect(virtualPaymentModelDomain.getVaBalance != null, true);
    Map<String, dynamic> map = virtualPaymentModelDomain.toMap();
    VirtualPaymentModelDomain.fromMap(map);
    virtualPaymentModelDomain.toJson();
  });

  test("GetVaBalance test", () {
    GetVaBalance getVaBalance = GetVaBalance.fromJson(json);
    expect(getVaBalance.data != null, false);
    Map<String, dynamic> map = getVaBalance.toMap();
    GetVaBalance.fromMap(map);
    getVaBalance.toJson();
  });

  test("Data test", () {
    Data data = Data.fromJson(json);
    expect(data.balance != null, false);
    Map<String, dynamic> map = data.toMap();
    Data.fromMap(map);
    data.toJson();
  });

  test("Status test", () {
    Status status = Status.fromJson(json);
    expect(status.code != null, false);
    Map<String, dynamic> map = status.toMap();
    Status.fromMap(map);
    status.toJson();
  });
}
