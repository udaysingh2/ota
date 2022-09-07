import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/virtual_account/models/virtual_payment_model_domain.dart';
import 'package:ota/domain/virtual_account/usecases/virtual_payment_use_cases.dart';
import 'package:ota/core_pack/custom_widgets/ota_virtual_wallet/view_model/virtual_payment_model.dart';

const String _kActiveKey = "ACTIVE";

class VirtualPaymentBloc extends Bloc<VirtualPaymentViewModel> {
  @override
  VirtualPaymentViewModel initDefaultValue() {
    return VirtualPaymentViewModel(
      state: VirtualPaymentState.none,
      walletState: WalletState.disabled,
    );
  }

  void getVirtualWalletBalance() async {
    state.state = VirtualPaymentState.loading;
    emit(state);

    VirtualPaymentUseCases virtualPaymentUseCases =
        VirtualPaymentUseCasesImpl();

    Either<Failure, VirtualPaymentModelDomain>? result =
        await virtualPaymentUseCases.getVirtualWalletBalance();
    if (result != null && result.isRight) {
      Data? model = result.right.getVaBalance?.data;
      if (model != null) {
        emit(
          VirtualPaymentViewModel(
            state: VirtualPaymentState.success,
            walletState:
                isWalletEnabled(model) ? WalletState.off : WalletState.disabled,
            balance: model.balance,
            balanceStatus: model.balanceStatus,
            pocketStatus: model.pocketStatus,
            currency: model.currency,
          ),
        );
      } else {
        emit(
          VirtualPaymentViewModel(
            state: VirtualPaymentState.failure,
            walletState: WalletState.disabled,
          ),
        );
      }
    } else {
      emit(
        VirtualPaymentViewModel(
          state: VirtualPaymentState.failure,
          walletState: WalletState.disabled,
        ),
      );
    }
  }

  void useWallet(double amount) {
    state.walletPaidAmmount = amount;
    state.walletState = WalletState.on;
    emit(state);
  }

  void updateWalletPaidAmountAfterPromoApplied(double amount){
    state.walletPaidAmmount = amount;
    emit(state);
  }

  void removeWallet() {
    state.walletPaidAmmount = null;
    state.walletState = WalletState.off;
    emit(state);
  }

  bool isWalletEnabled(Data data) {
    return (data.balanceStatus == _kActiveKey &&
        data.pocketStatus == _kActiveKey &&
        data.balance! > 0.0);
  }

  bool isWalletOn() => state.walletState == WalletState.on;
}
