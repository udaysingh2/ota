import 'package:ota/domain/tours/ota_contact_information/data_sources/ota_update_customer_remote_data_source.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_argument_domain.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_data_model.dart';

import '../../../../mocks/fixture_reader.dart';


class OtaUpdateCustomerRepositoryImplSuccessMock
    implements OtaUpdateCustomerRemoteDataSource {
  @override
  Future<OtaUpdateCustomerDetailsData> updateCustomerDetails(
      OtaUpdateCustomerDetailsArgumentDomain argument) async {
    String json = fixture("tour/ota_contact_information_success_mock.json");

    ///Convert into Model
    OtaUpdateCustomerDetailsData model = OtaUpdateCustomerDetailsData.fromJson(json);
    return model;
  }
}
