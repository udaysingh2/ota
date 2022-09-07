import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_argument_domain.dart';

void main() {
  test('OTA Contact information argument', () async {
    final otaContactInformationArgument =
    OtaUpdateCustomerDetailsArgumentDomain(
      lastName: "Smith",
      firstName: "Steve"
          );
    final otaContactInformationArgument1 =
    OtaUpdateCustomerDetailsArgumentDomain.from("Steve",
        "Smith",
        "steve@email.com",
        "0987654321"
    );
    expect(otaContactInformationArgument.firstName,"Steve");
    expect(otaContactInformationArgument1.lastName,"Smith");
  });
}
