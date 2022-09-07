import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_data_model.dart';
import '../../../../mocks/fixture_reader.dart';


void main() {
  String json = fixture("tour/ota_contact_information_success_mock.json");
  test("Ota Update Customer Model", () {
    ///Convert into Model
    OtaUpdateCustomerDetailsData model = OtaUpdateCustomerDetailsData.fromJson(json);
    expect(model.updateCustomerDetails != null, true);

    ///convert into map
    Map<String, dynamic> map = model.toMap();

    ///Check map conversion
    OtaUpdateCustomerDetailsData mapFromModel = OtaUpdateCustomerDetailsData.fromMap(map);
    expect(mapFromModel.updateCustomerDetails != null, true);

    ///Convert to String
    String stringData = model.toString();
    expect(stringData.isNotEmpty, true);

    ///Convert to json
    String jsonData = model.toJson();
    expect(jsonData.isNotEmpty, true);
  });
}
