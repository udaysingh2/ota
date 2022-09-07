import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_argument_domain.dart';

class OtaQueriesUpdateCustomer {
  static String updateCustomerDetails(
      OtaUpdateCustomerDetailsArgumentDomain argument
      )
  {
    return '''
   mutation {
updateCustomerDetails(
  customerDetailsRequest: {
    firstName: "${argument.firstName}"
    lastName: "${argument.lastName}" 
  }
) {
    status {
      code
      header
      description
    }
  }
}
''';
  }
}
