import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/tours/confirm_booking/models/tour_confirm_booking_model_domain.dart';
import 'package:ota/domain/tours/confirm_booking/usecases/tour_confirm_booking_usecase.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/tour_confirm_booking_model.dart';
import 'package:ota/modules/tours/confirm_booking/view_model/tour_confirm_booking_view_model.dart';

class TourConfirmBookingBloc extends Bloc<TourConfirmBookingViewModel> {
  @override
  TourConfirmBookingViewModel initDefaultValue() {
    return TourConfirmBookingViewModel(
        state: TourPaymentReviewViewModelStates.initial);
  }

  Future<void> loadFromArgument(TourConfirmBookingModel argumentModel) async {
    state.state = TourPaymentReviewViewModelStates.loading;
    emit(state);
    TourConfirmBookingUseCases tourPaymentReviewUseCases =
        TourConfirmBookingUseCasesImpl();
    Either<Failure, TourConfirmBookingModelDomain>? result =
        await tourPaymentReviewUseCases.getTourConfirmBookingData(
            argumentModel.argument.toConfirmBookingArgumentDomain());
    if (result != null && result.isRight) {
      TourConfirmBookingModelDomain? data = result.right;
      if (data.getTourBookingConfirmation != null &&
          data.getTourBookingConfirmation!.data != null &&
          data.getTourBookingConfirmation!.data!.packageDetail != null) {
        var viewModelData = TourConfirmBookingViewModel.fromData(
            data: data.getTourBookingConfirmation!.data!,
            childInfo: argumentModel.childInfo,
            childCount: argumentModel.childCount,
            adultCount: argumentModel.adultCount,
            adultPrice: argumentModel.adultTourPrice,
            childPrice: argumentModel.childTourPrice,
            cancellationPolicy: argumentModel.cancellationPolicy,
            isAllTravellersInfoRequired:
                argumentModel.isAllTravellersInfoRequired);
        viewModelData.state = TourPaymentReviewViewModelStates.success;
        emit(viewModelData);
        return;
      } else {
        state.state = TourPaymentReviewViewModelStates.failure;
        emit(state);
        return;
      }
    } else if (result?.left is InternetFailure) {
      state.state = TourPaymentReviewViewModelStates.internetFailure;
      emit(state);
      return;
    } else {
      state.state = TourPaymentReviewViewModelStates.failure;
      emit(state);
      return;
    }
  }

  void updatePromoDiscount(double updatedDiscount) {
    state.promoDiscount = updatedDiscount;
    emit(state);
  }

  void updatePromoDiscountNoEmit(double updatedDiscount) {
    state.promoDiscount = updatedDiscount;
  }

  double get getPayablePrice => ((state.totalAmount! - state.promoDiscount >= 0)
      ? (state.totalAmount! - state.promoDiscount)
      : 0.0);

  double getWalletAmountTobeDeducted(double balance) {
    double totalValueAfterPromoApplied = getPayablePrice;
    if (balance > 0) {
      if (balance >= totalValueAfterPromoApplied) {
        return totalValueAfterPromoApplied;
      } else if (balance < totalValueAfterPromoApplied) {
        return balance;
      }
    }
    return 0.0;
  }

  double getGrandTotalWithWalletApplied(bool walletState, double balance) {
    double totalAmount = getPayablePrice;
    double walletAmount = getWalletAmountTobeDeducted(balance);
    if (totalAmount >= 0 && walletState) {
      return totalAmount - walletAmount;
    } else {
      return totalAmount;
    }
  }
}
