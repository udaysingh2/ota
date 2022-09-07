import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_bloc.dart';
import 'package:ota/domain/tours/ota_contact_information/models/ota_update_customer_details_data_model.dart';
import 'package:ota/domain/tours/ota_contact_information/use_cases/ota_update_customer_use_cases.dart';
import 'package:ota/modules/tours/ota_contact_information/view_model/ota_contact_information_argument_model.dart';

const String _kSuccessCode = "1000";

class OtaContactInformationBloc
    extends Bloc<OtaContactInformationArgumentModel> {
  @override
  OtaContactInformationArgumentModel initDefaultValue() {
    OtaContactInformationArgumentModel contactInformationArgumentModel =
        OtaContactInformationArgumentModel(
            initialContactInformationArgumentData:
                OtaContactInformationArgumentData(
                    firstName: '', lastName: '', email: '', phoneNumber: ''),
            onOkClicked: (OtaContactInformationArgumentData
                updatedContactInformationArgumentData) {});
    contactInformationArgumentModel.firstNameBloc = OtaTextInputBloc();
    contactInformationArgumentModel.lastNameBloc = OtaTextInputBloc();
    return contactInformationArgumentModel;
  }

  void onOkClicked() {
    state.onOkClicked(OtaContactInformationArgumentData(
      email: state.initialContactInformationArgumentData.email,
      firstName: state.initialContactInformationArgumentData.firstName,
      lastName: state.initialContactInformationArgumentData.lastName,
      phoneNumber: state.initialContactInformationArgumentData.phoneNumber,
      contactInformationSelected: state
          .initialContactInformationArgumentData.contactInformationSelected,
    ));
  }

  void showMaterialBanner(bool showBanner) {
    state.isMaterialBannerShown = showBanner;
    emit(state);
  }

  bool get isFormValid {
    String firstName = state.initialContactInformationArgumentData.firstName;
    String lastName =
        state.initialContactInformationArgumentData.lastName ?? '';
    if (firstName.isEmpty || kInvalidNameFormatter.hasMatch(firstName)) {
      return false;
    } else if (lastName.isEmpty || kInvalidNameFormatter.hasMatch(lastName)) {
      return false;
    }

    return true;
  }

  void checkValidation() {
    String firstName = state.initialContactInformationArgumentData.firstName;
    String lastName =
        state.initialContactInformationArgumentData.lastName ?? '';
    if (firstName.isEmpty || kInvalidNameFormatter.hasMatch(firstName)) {
      state.firstNameBloc!.errorInputState();
    } else {
      state.firstNameBloc!.validInputState();
    }

    if (lastName.isEmpty || kInvalidNameFormatter.hasMatch(lastName)) {
      state.lastNameBloc!.errorInputState();
    } else {
      state.lastNameBloc!.validInputState();
    }
  }

  void updateTextState() {
    emit(state);
  }

  void mapFromArgument(
      OtaContactInformationArgumentModel contactInformationArgumentModel) {
    OtaContactInformationArgumentData? argData =
        contactInformationArgumentModel.initialContactInformationArgumentData;
    state.initialContactInformationArgumentData.firstName = argData.firstName;
    state.initialContactInformationArgumentData.lastName =
        argData.lastName ?? '';
    state.initialContactInformationArgumentData.email = argData.email;
    state.onOkClicked = contactInformationArgumentModel.onOkClicked;
    state.initialContactInformationArgumentData.phoneNumber =
        argData.phoneNumber;
    state.initialContactInformationArgumentData.contactInformationSelected =
        contactInformationArgumentModel
            .initialContactInformationArgumentData.contactInformationSelected;
    emit(state);
  }

  Future<void> submitApiCall(
      OtaContactInformationArgumentData? argument) async {
    state.submitCustomerDetailsState = OtaSubmitCustomerDetailsState.loading;
    emit(state);
    if (argument == null) {
      state.submitCustomerDetailsState = OtaSubmitCustomerDetailsState.failure;
      emit(state);
      return;
    }
    OtaUpdateCustomerUseCasesImpl otaUpdateCustomerUseCases =
        OtaUpdateCustomerUseCasesImpl();
    Either<Failure, OtaUpdateCustomerDetailsData>? result =
        await otaUpdateCustomerUseCases.updateCustomerDetails(
            argument.toUpdateCustomerDetailsDomainArgument());

    if (result?.isRight ?? false) {
      OtaUpdateCustomerDetailsData data = result!.right;
      String? statusCode = data.updateCustomerDetails?.status?.code;
      if (statusCode == _kSuccessCode) {
        state.submitCustomerDetailsState =
            OtaSubmitCustomerDetailsState.success;
        emit(state);
      } else {
        state.submitCustomerDetailsState =
            OtaSubmitCustomerDetailsState.failure;
        emit(state);
      }
    } else if (result?.left is InternetFailure) {
      state.submitCustomerDetailsState =
          OtaSubmitCustomerDetailsState.internetFailure;
      emit(state);
    } else {
      state.submitCustomerDetailsState = OtaSubmitCustomerDetailsState.failure;
      emit(state);
    }
  }
}
