import 'package:ota/domain/tours/ota_contact_information/data_sources/ota_update_customer_remote_data_source.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_argument_domain.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_data_model.dart';

class OtaUpdateCustomerMockDataSourceImpl
    implements OtaUpdateCustomerRemoteDataSource {
  static String getMockData() {
    return _responseMock;
  }

  @override
  Future<OtaUpdateCustomerDetailsData> updateCustomerDetails(
      OtaUpdateCustomerDetailsArgumentDomain contactInformationArgumentData) async {
    await Future.delayed(const Duration(seconds: 1));
    return OtaUpdateCustomerDetailsData.fromJson(_responseMock);
  }
}

String _responseMock = '''
{
	"updateCustomerDetails": {
		"status": {
			"code": "1000",
			"header": "Success",
			"description": null
		}
	}
}
''';
