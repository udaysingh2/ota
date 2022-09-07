import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_radio_button/ota_radio_button_bloc.dart';
import 'package:ota/domain/get_customer_details/models/customer_data_model.dart';
import 'package:ota/domain/get_customer_details/usecases/customer_use_cases.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/reservation_argument_model.dart';
import 'package:ota/modules/hotel/room_reservation/reservation/view_model/userdetail_view_model.dart';

class UserDetailBloc extends Bloc<UserDetailViewModel> {
  CustomerUseCasesImpl customerUseCasesImpl = CustomerUseCasesImpl();

  @override
  UserDetailViewModel initDefaultValue() {
    return UserDetailViewModel();
  }

  void getFromApiCall(
      ReservationArgumentModel? reservationArgumentModel) async {
    state.userDetailViewModelDataState = UserDetailViewModelDataState.loading;
    emit(state);
    if (reservationArgumentModel == null) return;
    Either<Failure, CustomerData>? customerData =
        await customerUseCasesImpl.getCustomerData();
    if (customerData?.isLeft ?? true) {
      state.userDetailViewModelDataState = UserDetailViewModelDataState.failed;
      emit(state);
      return;
    }
    state.mobileNumber = customerData?.right.data?.phoneNumber ?? "";
    state.email = customerData?.right.data?.email ?? "";
    state.firstName = getFirstName(customerData?.right.data?.firstName ?? "",
        reservationArgumentModel.firstName);
    state.secondName = getLastName(customerData?.right.data?.lastName ?? "",
        reservationArgumentModel.secondName);
    state.userDetailViewModelDataState = UserDetailViewModelDataState.loaded;
    emit(state);
  }

  Future<UserDetailViewModel?> getUserDetails({isRefresh = false}) async {
    if (!isRefresh) {
      state.userDetailViewModelDataState = UserDetailViewModelDataState.loading;
      emit(state);
    }
    CustomerUseCasesImpl customerUseCasesImpl = CustomerUseCasesImpl();
    Either<Failure, CustomerData>? customerData =
        await customerUseCasesImpl.getCustomerData();
    if (customerData?.isLeft ?? true) {
      state.userDetailViewModelDataState = UserDetailViewModelDataState.failed;
      emit(state);
      return null;
    }
    state.mobileNumber = customerData?.right.data?.phoneNumber ?? "";
    state.email = customerData?.right.data?.email ?? "";
    state.firstName = customerData?.right.data?.firstName ?? "";
    state.secondName = customerData?.right.data?.lastName ?? "";
    state.userDetailViewModelDataState = UserDetailViewModelDataState.loaded;
    emit(state);
    return state;
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
    state.userDetailViewModelDataState = UserDetailViewModelDataState.loaded;
    emit(state);
  }

  void updateUserData({required String? firstName, required String? lastName}) {
    state.firstName = firstName ?? state.firstName;
    state.secondName = lastName ?? state.secondName;
    emit(state);
  }

  void isBookForSomeoneElse(OtaRadioButtonBloc radioBloc) {
    state.buttonState = radioBloc.state.otaRadioButtonState;
    emit(state);
  }

  String getFirstName(String serverData, String otaAppData) {
    if (serverData.isEmpty) {
      return otaAppData;
    }
    return serverData;
  }

  String getLastName(String serverData, String otaAppData) {
    if (serverData.isEmpty) {
      return otaAppData;
    }
    return serverData;
  }
}
