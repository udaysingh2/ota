import 'package:ota/common/network/exceptions.dart';
import 'package:ota/domain/car_rental/contact_information/data_sources/update_customer_remote_data_source.dart';
import 'package:ota/domain/car_rental/contact_information/models/update_customer_details_model.dart';
import 'package:ota/modules/car_rental/contact_information/view_model/contact_information_argument_model.dart';

class UpdateCustomerServerFailureMock extends UpdateCustomerRemoteDataSource {
  @override
  Future<UpdateCustomerData> updateCustomerData(
      ContactInformationArgumentData contactInformationArgumentData) {
    throw ServerException(null);
  }
}
