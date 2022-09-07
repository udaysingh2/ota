import 'package:ota/common/network/exceptions.dart' as exp;
import 'package:ota/domain/tours/ota_contact_information/data_sources/ota_update_customer_remote_data_source.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_argument_domain.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_data_model.dart';

class OtaUpdateCustomerRemoteDataSourceFailureMock implements OtaUpdateCustomerRemoteDataSource {
  @override
  Future<OtaUpdateCustomerDetailsData> updateCustomerDetails(
      OtaUpdateCustomerDetailsArgumentDomain argument) {
    throw exp.ServerException(null);
  }

}
