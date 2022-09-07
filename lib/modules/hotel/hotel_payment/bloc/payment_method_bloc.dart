import 'package:either_dart/either.dart';
import 'package:ota/channels/ota_payment_handler/models/ota_payment_model_channel.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/payment_method/models/payment_method_model_domain.dart';
import 'package:ota/domain/payment_method/usecases/payment_method_use_cases.dart';
import 'package:ota/modules/hotel/hotel_payment/helper/payment_method_helper.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_list_view_model.dart';
import 'package:ota/modules/hotel/hotel_payment/view_model/payment_method_type.dart';

const String _kPayWise = 'PAYWISE';
const String _kCard = 'CARD';
const String _kCredit = 'Credit';

class PaymentMethodBloc extends Bloc<PaymentMethodListViewModel> {
  @override
  PaymentMethodListViewModel initDefaultValue() {
    return PaymentMethodListViewModel(paymentMethodList: []);
  }

  void getPaymentMethodListData(String? userId) async {
    if (userId == null) {
      state.paymentMethodViewState = PaymentMethodViewState.failure;
      emit(state);
    }

    state.paymentMethodViewState = PaymentMethodViewState.loading;

    PaymentMethodUseCases paymentMethodUseCases = PaymentMethodUseCasesImpl();
    Either<Failure, PaymentMethodModelDomain>? result =
        await paymentMethodUseCases.getPaymentMethodListData(userId: userId!);
    if (result != null && result.isRight) {
      List<PaymentMethodViewModel>? paymentMethodViewModelList =
          PlaymentMethodHelper.getPaymentMethodViewModelList(
              result.right.getCustomerPaymentMethodDetails?.data?.paymentList);
      state.paymentMethodList =
          _getPaymentMethodListWithScb(paymentMethodViewModelList ?? []);
      state.paymentMethodViewState = PaymentMethodViewState.success;
      emit(state);
    } else {
      state.paymentMethodList = _getPaymentMethodListWithScb([]);
      state.paymentMethodViewState = PaymentMethodViewState.success;
      emit(state);
    }
  }

  List<PaymentMethodViewModel> _getPaymentMethodListWithScb(
      List<PaymentMethodViewModel> paymentMethodList) {
    final isDefaultPaymentAvailable =
        paymentMethodList.indexWhere((element) => element.isDefault == true);
    final scbModel =
        PaymentMethodViewModel.getSCBModel(isDefaultPaymentAvailable == -1);
    paymentMethodList.insert(0, scbModel);
    return paymentMethodList;
  }

  List<PaymentMethodViewModel> getAllPaymentMethodList() {
    return state.paymentMethodList;
  }

  PaymentMethodViewModel? getDefaultPaymentMethod() {
    for (PaymentMethodViewModel item in state.paymentMethodList) {
      if (item.isDefault) return item;
    }
    return null;
  }

  String getSelectedPaymentMethod() {
    return (getDefaultPaymentMethod()?.paymentMethodType ??
                PaymentMethodType.scb) ==
            PaymentMethodType.scb
        ? _kPayWise
        : _kCard;
  }

  String getSelectedPaymentMethodFirebase() {
    return (getDefaultPaymentMethod()?.paymentMethodType ??
                PaymentMethodType.scb) ==
            PaymentMethodType.scb
        ? _kPayWise
        : _kCredit;
  }

  void setDefaultPaymentMethod(String paymentMethodId) {
    for (PaymentMethodViewModel item in state.paymentMethodList) {
      if (item.paymentMethodId == paymentMethodId) {
        item.isDefault = true;
      } else {
        item.isDefault = false;
      }
    }
  }

  void setDefaultPaymentMethodFromChannel(OtaPaymentModelChannel paymentModel) {
    PaymentMethodViewModel? item = getDefaultPaymentMethod();
    if (item == null) {
      return;
    }
    item.updatePlayListFromChannel(paymentModel);
    emit(state);
  }
}
