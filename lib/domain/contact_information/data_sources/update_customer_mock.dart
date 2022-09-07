import 'package:ota/domain/contact_information/data_sources/update_customer_remote_data_source.dart';
import 'package:ota/domain/contact_information/models/update_customer_details_model.dart';
import 'package:ota/modules/hotel/room_reservation/contact_information/view_model/contact_information_argument_model.dart';

class UpdateCustomerMockDataSourceImpl
    implements UpdateCustomerRemoteDataSource {
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<UpdateCustomerData> updateCustomerData(
      ContactInformationArgumentData contactInformationArgumentData) async {
    await Future.delayed(const Duration(seconds: 1));
    return UpdateCustomerData.fromJson(_responseMock);
  }
}

String _responseMock = '''{
  "data": {
    "updateCustomerDetails": {
      "data": {
        "firstName": "milind",
        "lastName": "soman",
        "email": "abc@gmail.com",
        "phoneNumber": "12345678"
      },
      "status": {
        "code": "1000",
        "header": "Success",
        "description": null
      }
    }
  }
}''';
