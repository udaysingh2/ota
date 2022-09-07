import 'package:ota/domain/get_customer_details/data_sources/customer_remote_data_source.dart';
import 'package:ota/domain/get_customer_details/models/customer_data_model.dart';

class CustomerMockDataSourceImpl implements CustomerRemoteDataSource {
  CustomerMockDataSourceImpl();

  static String getMockData() {
    return _responseMock;
  }

  static String getMockData2() {
    return _responseMock;
  }

  @override
  Future<CustomerData> getCustomerData() async {
    await Future.delayed(const Duration(milliseconds: 10));
    return CustomerData.fromJson(_responseMock);
  }
}

String _responseMock = '''{
"getCustomerDetails":{

    "status": {
      "code": 1000,
      "header": "",
      "description": "success"
    },
    "data": {
      "firstName": "MyFirstName",
      "lastName":"",
      "email":"",
      "phoneNumber":""
    }}
  }''';

