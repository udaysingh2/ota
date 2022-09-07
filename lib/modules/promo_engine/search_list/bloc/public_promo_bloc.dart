import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_search_model_domain.dart';
import 'package:ota/domain/promo_engine/promo_search/usecases/promo_code_search_use_cases.dart';
import 'package:ota/domain/promo_engine/public_promo/models/public_promotion_model_domain.dart';
import 'package:ota/domain/promo_engine/public_promo/usecases/public_promotion_usecases.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promo_view_model.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promotion_argument.dart';

const int _kPageSize = 20;

class PublicPromotionBloc extends Bloc<PublicPromotionViewModel> {
  PublicPromotionUseCases promotionUseCases = PublicPromotionUseCasesImpl();
  PromoCodeSearchUseCases promoCodeSearchUseCases =
      PromoCodeSearchUseCasesImpl();
  @override
  PublicPromotionViewModel initDefaultValue() {
    return PublicPromotionViewModel(
      state: PublicPromotionScreenState.none,
    );
  }

  bool isNewDataRequired(int index, int pagingOffset) {
    if (state.pagination != null && state.pagination!.hasNext) {
      int currentNumber = pagingOffset + 1;
      if ((currentNumber * _kPageSize) == (index + 1)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> getPromotionData(
      {PublicPromotionArgument? argument, bool forceFetch = false}) async {
    if (argument == null) {
      state.state = PublicPromotionScreenState.failure;
      emit(state);
      return;
    }
    if (!forceFetch) {
      state.state = PublicPromotionScreenState.loading;
      emit(state);
    }

    Either<Failure, PublicPromotionModelDomain?>? result =
        await promotionUseCases
            .getPublicPromotionData(argument.toDomainArgument());
    if (result != null && result.isRight) {
      PublicPromotionModelDomain? promoList = result.right;
      if (promoList != null &&
          promoList.getAvailablePublicPromotions != null &&
          promoList.getAvailablePublicPromotions?.data?.promotionList != null) {
        Data responseData = promoList.getAvailablePublicPromotions!.data!;
        List<PublicPromotion> promotions = List.generate(
          responseData.promotionList!.length,
          (index) => PublicPromotion.formModel(
            responseData.promotionList![index],
          ),
        );
        PublicPromotionPagination? pagination = responseData.pagination == null
            ? null
            : PublicPromotionPagination.fromPagination(
                responseData.pagination!);
        if (promotions.isEmpty) {
          state.state = PublicPromotionScreenState.empty;
          emit(state);
        } else {
          if (state.promotionList != null && forceFetch) {
            state.promotionList!.addAll(promotions);
          } else {
            state.promotionList = promotions;
          }

          state.pagination = pagination;
          state.state = PublicPromotionScreenState.success;
          emit(state);
        }
      } else {
        state.state = PublicPromotionScreenState.failure;
        emit(state);
      }
    } else if (result?.left is InternetFailure) {
      if (forceFetch) {
        state.state = PublicPromotionScreenState.searchInternetFailure;
      } else {
        state.state = PublicPromotionScreenState.internetFailure;
      }
      emit(state);
    } else {
      state.state = PublicPromotionScreenState.failure;
      emit(state);
    }
  }

  void getPromoCodeSearchData(PublicPromotionArgument? argument) async {
    if (argument == null) {
      state.state = PublicPromotionScreenState.failure;
      emit(state);
      return;
    }
    if (state.state == PublicPromotionScreenState.success ||
        state.state == PublicPromotionScreenState.searchInternetFailure) {
      state.state = PublicPromotionScreenState.searchListLoading;
    } else if (state.state == PublicPromotionScreenState.searchSuccess) {
      state.state = PublicPromotionScreenState.searchSuccessLoading;
    } else if (state.state == PublicPromotionScreenState.empty ||
        state.state ==
            PublicPromotionScreenState.searchEmptyListInternetFailure) {
      state.state = PublicPromotionScreenState.searchEmptyListLoading;
    } else {
      state.state = PublicPromotionScreenState.searchFailureLoading;
    }
    emit(state);

    Either<Failure, PromoCodeSearchModelDomain?>? result =
        await promoCodeSearchUseCases
            .searchPromoCode(argument.toSearchArgument());

    if (result != null && result.isRight) {
      PromoCodeSearchModelDomain? data = result.right;
      if (data?.searchPromoCode?.data != null) {
        state.searchedPromotionCode = PublicPromotion.mapFromLandingModelData(
            data!.searchPromoCode!.data!);
        state.state = PublicPromotionScreenState.searchSuccess;
        emit(state);
      } else {
        state.state = PublicPromotionScreenState.searchFailure;
        emit(state);
      }
    } else if (result?.left is InternetFailure) {
      if (state.state == PublicPromotionScreenState.searchEmptyListLoading) {
        state.state = PublicPromotionScreenState.searchEmptyListInternetFailure;
      } else if (state.state ==
          PublicPromotionScreenState.searchSuccessLoading) {
        state.state = PublicPromotionScreenState.searchSuccessInternetFailure;
      } else if (state.state ==
          PublicPromotionScreenState.searchFailureLoading) {
        state.state = PublicPromotionScreenState.searchErrorInternetFailure;
      } else {
        state.state = PublicPromotionScreenState.searchInternetFailure;
      }
      emit(state);
    } else {
      state.state = PublicPromotionScreenState.searchFailure;
      emit(state);
    }
  }

  List<PublicPromotion> get searchedListResult =>
      [state.searchedPromotionCode!];

  void onCrossButtonTap() {
    state.searchedPromotionCode = null;
    if (state.promotionList != null && state.promotionList!.isNotEmpty) {
      state.state = PublicPromotionScreenState.success;
    } else {
      state.state = PublicPromotionScreenState.empty;
    }
    emit(state);
  }
}
