class OtaUpdateCustomerDetailsArgumentDomain {
  String firstName;
  String lastName;
  OtaUpdateCustomerDetailsArgumentDomain({
    required this.firstName,
    required this.lastName,
  });

  factory OtaUpdateCustomerDetailsArgumentDomain.from(
      String firstName, String lastName, String email, String phoneNumber) {
    return OtaUpdateCustomerDetailsArgumentDomain(
      firstName: firstName,
      lastName: lastName,
    );
  }
}
