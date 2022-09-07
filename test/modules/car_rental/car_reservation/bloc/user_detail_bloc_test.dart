import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_bloc.dart';
import 'package:ota/domain/get_customer_details/data_sources/customer_remote_data_source.dart';
import 'package:ota/domain/get_customer_details/models/customer_data_model.dart';
import 'package:ota/domain/get_customer_details/repositories/customer_repository_impl.dart';
import 'package:ota/domain/get_customer_details/usecases/customer_use_cases.dart';
import 'package:ota/modules/car_rental/car_reservation/bloc/user_detail_bloc.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/userdetail_view_model.dart';

import '../../../../mocks/fixture_reader.dart';

class MockedCustomerRemoteDataSource implements CustomerRemoteDataSource {
  @override
  Future<CustomerData> getCustomerData() async {
    Map<String, dynamic> map =
        json.decode(fixture("get_customer_details/customer_details.json"));
    CustomerData customerData = CustomerData.fromMap(map);
    return customerData;
  }
}

class MockedCustomerDataSourceExp implements CustomerRemoteDataSource {
  @override
  Future<CustomerData> getCustomerData() async {
    throw Exception();
  }
}

class InternetConnectionInfoMocked extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(true);
}

class InternetConnectionInfoMockedFalse extends InternetConnectionInfoImpl {
  @override
  Future<bool> isConnected = Future.value(false);
}

void main() {
  group("User Detail Bloc Test", () {
    UserDetailBloc userDetailBloc = UserDetailBloc();
    userDetailBloc.customerUseCasesImpl = CustomerUseCasesImpl(
        repository: CustomerRepositoryImpl(
      internetInfo: InternetConnectionInfoMocked(),
      remoteDataSource: MockedCustomerRemoteDataSource(),
    ));
    test("Testing Mock Data", () {
      userDetailBloc.getFromApiCall(CarReservationViewArgumentModel(
        carId: "2",
        pickupLocationId: "MA05110001",
        returnLocationId: "MA05110001",
        pickupDate: Helpers().parseDateTime("2021-12-12"),
        returnDate: Helpers().parseDateTime("2021-11-11"),
        supplierId: "MA2111000062",
        includeDriver: "false",
        currency: "THB",
        rentalType: "",
        pickupCounter: "",
        returnCounter: "",
        age: 25,
        rateKey: "eNqLVjI0U9KJNjaN1THUMTLQMTPQMdAxNokFAEBXBRw=",
        refCode: "CL213",
        lastPrice: 1000,
      ));
      expect(userDetailBloc.state.userDetailViewModelDataState,
          CarUserDetailViewModelDataState.loading);
    });

    test("User Detail Bloc Set Driver Data from Args", () {
      userDetailBloc.setDriverDataFromArg(
          firstName: "Test",
          lastName: "Test",
          age: 12,
          mobileNumber: "1234567890");
      expect(userDetailBloc.state.driverFirstName, "Test");
      expect(userDetailBloc.state.driverLastName, "Test");
      expect(userDetailBloc.state.age, 25);
      expect(userDetailBloc.state.driverPhoneNumber, "1234567890");
    });

    test("User Detail Bloc Set User Data from Args", () {
      userDetailBloc.setUserDataFromArg(
          firstName: "Test",
          lastName: "Test",
          email: "test@test.com",
          mobileNumber: "1234567890");
      expect(userDetailBloc.state.firstName, "Test");
      expect(userDetailBloc.state.secondName, "Test");
      expect(userDetailBloc.state.email, "test@test.com");
      expect(userDetailBloc.state.mobileNumber, "1234567890");
    });

    test("User Detail Bloc is Booking for someone else", () {
      OtaRadioButtonBloc radioBloc = OtaRadioButtonBloc();
      radioBloc.select();
      userDetailBloc.isBookForSomeoneElse(radioBloc);
      expect(userDetailBloc.state.driverFirstName, "");
      expect(userDetailBloc.state.driverLastName, "");
      expect(userDetailBloc.state.age, 25);
      expect(userDetailBloc.state.driverPhoneNumber, "");
      expect(userDetailBloc.state.flightNumber, "");
    });
  });
}
