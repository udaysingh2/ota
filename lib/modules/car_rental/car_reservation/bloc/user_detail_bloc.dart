import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_model.dart';
import 'package:ota/domain/get_customer_details/models/customer_data_model.dart';
import 'package:ota/domain/get_customer_details/usecases/customer_use_cases.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/car_reservation_argument_view_model.dart';
import 'package:ota/modules/car_rental/car_reservation/view_model/userdetail_view_model.dart';

class UserDetailBloc extends Bloc<CarUserDetailViewModel> {
  CustomerUseCasesImpl customerUseCasesImpl = CustomerUseCasesImpl();

  @override
  CarUserDetailViewModel initDefaultValue() {
    return CarUserDetailViewModel();
  }

  Future<void> getFromApiCall(CarReservationViewArgumentModel? argument) async {
    state.userDetailViewModelDataState =
        CarUserDetailViewModelDataState.loading;
    emit(state);

    Either<Failure, CustomerData>? customerData =
        await customerUseCasesImpl.getCustomerData();
    if (customerData?.isLeft ?? true) {
      state.userDetailViewModelDataState =
          CarUserDetailViewModelDataState.failed;
      emit(state);
      return;
    }
    state.age = argument?.age ?? 0;
    state.mobileNumber = customerData?.right.data?.phoneNumber ?? "";
    state.email = customerData?.right.data?.email ?? "";
    state.firstName = getFirstName(
      customerData?.right.data?.firstName ?? "",
    );
    state.secondName = getLastName(
      customerData?.right.data?.lastName ?? "",
    );
    state.driverFirstName = getFirstName(
      customerData?.right.data?.firstName ?? "",
    );
    state.driverLastName = getLastName(
      customerData?.right.data?.lastName ?? "",
    );
    state.driverAge = state.age;
    state.driverPhoneNumber = customerData?.right.data?.phoneNumber ?? "";
    state.userDetailViewModelDataState = CarUserDetailViewModelDataState.loaded;
    emit(state);
  }

  void setUserDataFromArg(
      {required String? firstName,
      required String? lastName,
      required String? email,
      required String? mobileNumber}) {
    state.mobileNumber = mobileNumber ?? state.mobileNumber;
    state.email = email ?? state.email;
    state.firstName = firstName ?? state.firstName;
    state.secondName = lastName ?? state.secondName;
    state.userDetailViewModelDataState = CarUserDetailViewModelDataState.loaded;
    emit(state);
  }

  void setDriverDataFromArg({
    required String? firstName,
    required String? lastName,
    required int? age,
    required String? mobileNumber,
    String? flightNumber,
  }) {
    state.driverPhoneNumber = mobileNumber ?? state.mobileNumber;
    state.driverAge = age ?? state.age;
    state.driverFirstName = firstName ?? state.firstName;
    state.driverLastName = lastName ?? state.secondName;
    state.flightNumber = flightNumber ?? '';
    emit(state);
  }

  void isBookForSomeoneElse(OtaRadioButtonBloc radioBloc) {
    state.buttonState = radioBloc.state.otaRadioButtonState;
    if (state.buttonState == OtaRadioButtonState.selected) {
      state.driverFirstName = '';
      state.driverLastName = '';
      state.driverPhoneNumber = '';
      state.driverAge = 0;
      state.flightNumber = '';
    } else {
      state.driverFirstName = state.firstName;
      state.driverLastName = state.secondName;
      state.driverPhoneNumber = state.mobileNumber;
      state.driverAge = state.age;
      state.flightNumber = '';
    }
    emit(state);
  }

  String getFirstName(String serverData) {
    return serverData;
  }

  String getLastName(String serverData) {
    return serverData;
  }
}
