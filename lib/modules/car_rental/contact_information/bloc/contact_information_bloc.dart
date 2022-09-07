import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/custom_widgets/ota_text_input_widget/ota_text_input_bloc.dart';
import 'package:ota/domain/car_rental/contact_information/models/update_customer_details_model.dart';
import 'package:ota/domain/car_rental/contact_information/use_cases/update_customer_use_cases.dart';
import 'package:ota/modules/car_rental/contact_information/view_model/contact_information_argument_model.dart';

const String _kSuccessCode = "1000";

class ContactInformationBloc extends Bloc<ContactInformationArgumentModel> {
  UpdateCustomerUseCases contactUseCases = UpdateCustomerUseCasesImpl();

  @override
  ContactInformationArgumentModel initDefaultValue() {
    ContactInformationArgumentModel contactInformationArgumentModel =
        ContactInformationArgumentModel(
            initialContactInformationArgumentData:
                ContactInformationArgumentData(
                    firstName: '', lastName: '', email: '', phoneNumber: ''),
            onOkClicked: (ContactInformationArgumentData
                updatedContactInformationArgumentData) {});
    contactInformationArgumentModel.firstNameBloc = OtaTextInputBloc();
    contactInformationArgumentModel.lastNameBloc = OtaTextInputBloc();
    return contactInformationArgumentModel;
  }

  void onOkClicked() {
    state.onOkClicked(ContactInformationArgumentData(
      email: state.initialContactInformationArgumentData.email,
      firstName: state.initialContactInformationArgumentData.firstName,
      lastName: state.initialContactInformationArgumentData.lastName,
      phoneNumber: state.initialContactInformationArgumentData.phoneNumber,
      contactInformationSelected: state
          .initialContactInformationArgumentData.contactInformationSelected,
    ));
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
    state.submitCustomerDetailsState = SubmitCustomerDetailsState.initial;
    emit(state);
  }

  void mapFromArgument(
      ContactInformationArgumentModel contactInformationArgumentModel) {
    ContactInformationArgumentData? argData =
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
    state.submitCustomerDetailsState = SubmitCustomerDetailsState.initial;
    emit(state);
  }

  Future<void> submitApiCall(
      ContactInformationArgumentData contactInformationArgumentData) async {
    state.submitCustomerDetailsState = SubmitCustomerDetailsState.loading;
    emit(state);
    Either<Failure, UpdateCustomerData>? customerData = await contactUseCases
        .updateCustomerData(contactInformationArgumentData);
    if (customerData?.isRight ?? true) {
      if (customerData?.right.updateCustomerDetails?.status?.code ==
          _kSuccessCode) {
        state.submitCustomerDetailsState = SubmitCustomerDetailsState.success;
      } else {
        state.submitCustomerDetailsState = SubmitCustomerDetailsState.failure;
      }
      emit(state);
      return;
    } else {
      if (customerData?.left is InternetFailure) {
        state.submitCustomerDetailsState =
            SubmitCustomerDetailsState.failureNetwork;
      } else {
        state.submitCustomerDetailsState = SubmitCustomerDetailsState.failure;
      }
    }
    emit(state);
  }
}
