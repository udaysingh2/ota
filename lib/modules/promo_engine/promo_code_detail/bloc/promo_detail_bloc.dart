import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_model_domain.dart';
import 'package:ota/domain/promo_engine/apply_promo/usecases/apply_promo_use_cases.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_argument_domain.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_model_domain.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/usecases/remove_promo_code_use_cases.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/apply_promotion_argument.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/promo_code_view_model.dart';

class PromoDetailBloc extends Bloc<PromoCodeViewModel> {
  RemovePromoCodeUseCases promoCodeUseCases = RemovePromoCodeUseCasesImpl();
  ApplyPromoUseCases applyPromoUseCases = ApplyPromoUseCasesImpl();

  @override
  PromoCodeViewModel initDefaultValue() {
    return PromoCodeViewModel(state: PromoCodeScreenState.none);
  }

  Future<void> applyPromoCode(
      ApplyPromoArgument? argument, String applicationKey) async {
    if (argument == null) {
      emit(PromoCodeViewModel(state: PromoCodeScreenState.failure));
      return;
    }

    emit(PromoCodeViewModel(state: PromoCodeScreenState.loading));
    Either<Failure, ApplyPromoModelDomain?>? result = await applyPromoUseCases
        .applyPromoCode(argument.toApplyPromoArgumentDomain());

    if (result?.isRight ?? false) {
      ApplyPromoModelDomain? data = result!.right;
      if (data != null) {
        String? statusCode = data.applyPromoCode?.status?.code;
        if (statusCode != null) {
          switch (statusCode) {
            case kSuccessCode:
              if (data.applyPromoCode?.data?.priceDetails != null) {
                emit(
                  PromoCodeViewModel(
                    state: PromoCodeScreenState.success,
                    promoCodeData: PromoCodeData.from(
                      data.applyPromoCode!.data!.priceDetails!,
                      argument.appliedPromo,
                      true,
                      argument.bookingUrn,
                      argument.merchantId,
                      applicationKey,
                    ),
                  ),
                );
              } else {
                emit(PromoCodeViewModel(state: PromoCodeScreenState.failure));
              }
              break;
            case kErrorCode1899:
              emit(PromoCodeViewModel(state: PromoCodeScreenState.failure1899));
              break;
            case kErrorCode1999:
              emit(PromoCodeViewModel(state: PromoCodeScreenState.failure1999));
              break;
            case kErrorCode3023:
              emit(PromoCodeViewModel(state: PromoCodeScreenState.failure3023));
              break;
            case kErrorCode3024:
              emit(PromoCodeViewModel(state: PromoCodeScreenState.failure3024));
              break;
            case kErrorCode3025:
              emit(PromoCodeViewModel(state: PromoCodeScreenState.failure3025));
              break;
            case kErrorCode3028:
              emit(PromoCodeViewModel(state: PromoCodeScreenState.failure3028));
              break;
            case kErrorCode3033:
              emit(PromoCodeViewModel(state: PromoCodeScreenState.failure3033));
              break;
            case kErrorCode3034:
              emit(PromoCodeViewModel(state: PromoCodeScreenState.failure3034));
              break;
            case kErrorCode3054:
              emit(PromoCodeViewModel(state: PromoCodeScreenState.failure3054));
              break;
            case kErrorCode3068:
              emit(PromoCodeViewModel(state: PromoCodeScreenState.failure3068));
              break;
            default:
              emit(PromoCodeViewModel(state: PromoCodeScreenState.failure));
          }
        } else {
          emit(PromoCodeViewModel(state: PromoCodeScreenState.failure));
        }
      } else {
        emit(PromoCodeViewModel(state: PromoCodeScreenState.failure));
      }
    } else if (result?.left is InternetFailure) {
      emit(PromoCodeViewModel(state: PromoCodeScreenState.internetFailure));
    } else {
      emit(PromoCodeViewModel(state: PromoCodeScreenState.failure));
    }
  }

  Future<void> removePromoCode({required PromoCodeData? argument}) async {
    if (argument == null) {
      state.state = PromoCodeScreenState.removeFailure;
      emit(state);
      return;
    }

    state.state = PromoCodeScreenState.loading;
    emit(state);

    Either<Failure, RemovePromoCodeModelDomain>? result =
        await promoCodeUseCases.getRemovePromoCodeData(
            RemovePromoCodeArgumentDomain(bookingUrn: argument.bookingUrn));

    if (result != null && result.isRight) {
      RemovePromoCodeData? data = result.right.removePromoCode?.data;
      if (data != null) {
        state.promoCodeData = PromoCodeData(
          promotion: argument.promotion,
          priceViewModel: PromoPriceViewModel(
            effectiveDiscount: 0.0,
            billingAmount: 0.0,
            orderPrice: data.priceDetails?.orderPrice ?? 0.0,
            addonPrice: data.priceDetails?.addonPrice ?? 0.0,
            totalAmount: data.priceDetails?.totalAmount ?? 0.0,
          ),
          isPromotionApplied: false,
          bookingUrn: argument.bookingUrn,
          merchantId: argument.merchantId,
          applicationKey: argument.applicationKey,
        );

        state.state = PromoCodeScreenState.removeSuccess;
        emit(state);
        return;
      } else {
        state.state = PromoCodeScreenState.removeFailure;
        emit(state);
      }
    } else if (result?.left is InternetFailure) {
      state.state = PromoCodeScreenState.internetFailure;
      emit(state);
    } else {
      state.state = PromoCodeScreenState.removeFailure;
      emit(state);
    }
  }
}
