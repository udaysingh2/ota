import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:ota/domain/get_customer_details/models/customer_data_model.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("Customer model test group", () {
    test('Customer model test', () async {
      Map<String, dynamic> map =
          json.decode(fixture("get_customer_details/customer_details.json"));
      CustomerData customerData = CustomerData.fromMap(map);
      CustomerData.fromJson(customerData.toJson());
      // ignore: unused_local_variable
      Data data = Data.fromJson(customerData.data!.toJson());
      data = Data.fromMap(customerData.data!.toMap());
      Status.fromMap(customerData.status!.toMap());
      Status.fromJson(customerData.status!.toJson());
    });
  });
}
