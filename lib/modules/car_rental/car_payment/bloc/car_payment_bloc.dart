import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/car_rental/car_payment/usecases/car_payment_use_cases.dart';
import 'package:ota/modules/car_rental/car_payment/view_model/car_payment_argument_view_model.dart';
import '../../../../domain/car_rental/car_payment/models/car_payment_model_domain.dart';
import '../view_model/car_payment_view_model.dart';

class CarPaymentBloc extends Bloc<CarPaymentViewModel> {
  @override
  CarPaymentViewModel initDefaultValue() {
    return CarPaymentViewModel.initial();
  }

  Future<void> loadFromArgument(
      CarPaymentArgumentModel argumentModel, context) async {
    state.state = CarPaymentViewModelState.loading;
    emit(state);

    CarPaymentUseCases carPaymentUseCases = CarPaymentUseCasesImpl();
    Either<Failure, CarPaymentDomainModelData>? result =
        await carPaymentUseCases
            .getCarPaymentData(argumentModel.mapToDomainArgument(context));
    if (result != null && result.isRight) {
      CarPaymentDomainModelData data = result.right;
      var viewModelData = CarPaymentViewModel.fromDomain(data);
      viewModelData.state = CarPaymentViewModelState.loaded;
      emit(viewModelData);
    } else {
      if (result?.left is InternetFailure) {
        state.state = CarPaymentViewModelState.failureNetwork;
      } else {
        state.state = CarPaymentViewModelState.failure;
      }
      emit(state);
    }
  }

  void updateDiscountAmount(double promoDiscount) {
    state.promoDiscount = promoDiscount;
    emit(state);
  }

  void updateDiscountAmountNoEmit(double promoDiscount) {
    state.promoDiscount = promoDiscount;
  }

  double getPayOnlineNow(bool walletState, double balance, double totalOfflinePrice) {
    double totalAmountPayOnline = ((state.carRentalTotalPrice) ?? 0) - state.promoDiscount;
    double walletAmount = getWalletAmountTobeDeducted(balance, totalOfflinePrice);
    if (totalAmountPayOnline >= 0 && walletState) {
      return totalAmountPayOnline - walletAmount;
    } else {
      return totalAmountPayOnline;
    }
  }

  double getSubTotal() {
    return ((state.carRentalTotalPrice) ?? 0) +
        state.extrasOnlinePrice! +
        state.extrasOfflinePrice!;
  }

  double getGrandTotal() {
    double totalAmount = getSubTotal() - state.promoDiscount;
    if (totalAmount >= 0) {
      return totalAmount;
    } else {
      return 0.0;
    }
  }

  double getWalletAmountTobeDeducted(double balance, double totalOfflinePrice) {
    double totalValueAfterPromoApplied = getGrandTotal() - totalOfflinePrice;
    if (balance > 0) {
      if (balance >= totalValueAfterPromoApplied) {
        return totalValueAfterPromoApplied;
      } else if (balance < totalValueAfterPromoApplied) {
        return balance;
      }
    }
    return 0.0;
  }

  double getGrandTotalWithWalletApplied(bool walletState, double balance, double totalOfflinePrice) {
    double totalAmount = getGrandTotal();
    double walletAmount = getWalletAmountTobeDeducted(balance, totalOfflinePrice);
    if (totalAmount >= 0 && walletState) {
      return totalAmount - walletAmount;
    } else {
      return totalAmount;
    }
  }
}
