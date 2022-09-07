import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_argument_domain.dart';
import 'package:ota/domain/promo_engine/promo_search/models/promo_code_search_model_domain.dart';
import 'package:ota/domain/promo_engine/public_promo/models/public_promotion_model_domain.dart';
import 'package:ota/modules/promo_engine/search_list/bloc/public_promo_bloc.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promo_view_model.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promotion_argument.dart';

import 'mocks/get_promo_search_mock.dart';
import 'mocks/get_public_promotions_mock.dart';

void main() {
  PublicPromotionBloc bloc = PublicPromotionBloc();
  GetPublicPromotionsMocks apply1000Mock = GetPublicPromotionsMocks();
  GetPublicPromotionsEmptyMocks applyEmptyMock =
      GetPublicPromotionsEmptyMocks();
  GetPublicPromotionsNullMocks applyNullMock = GetPublicPromotionsNullMocks();
  GetPublicPromoImplFailureMock applyInternetFailureMock =
      GetPublicPromoImplFailureMock();
  GetPromoSearchMock applySearch1000 = GetPromoSearchMock();
  GetPromoSearchFailureMock applySearchFailure = GetPromoSearchFailureMock();
  GetSearchImplFailureMock applySearchInternetFailure =
      GetSearchImplFailureMock();
  test('For class PublicPromotionBloc ==> initDefaultValue Test', () {
    bloc.initDefaultValue();

    expect(bloc.state.state, PublicPromotionScreenState.none);
  });

  group('For class PublicPromotionBloc get public promo group test', () {
    test('For class PublicPromotionBloc failure test', () async {
      bloc.getPromotionData(argument: null, forceFetch: false);

      expect(bloc.state.state, PublicPromotionScreenState.failure);
    });
    test('For class PublicPromotionBloc success test', () async {
      bloc.promotionUseCases = apply1000Mock;
      bloc.getPromotionData(
        argument: PublicPromotionArgument(
            applicationKey: "",
            voucherCode: "",
            bookingUrn: "",
            pageOffset: 0,
            merchantId: ""),
        forceFetch: false,
      );
      Either<Failure, PublicPromotionModelDomain>? result = await apply1000Mock
          .getPublicPromotionData(applyArgs.toDomainArgument());
      expect(result?.isRight, true);
      expect(bloc.state.state, PublicPromotionScreenState.success);
    });
    test('For class PublicPromotionBloc empty test', () async {
      bloc.promotionUseCases = applyEmptyMock;
      bloc.getPromotionData(
        argument: PublicPromotionArgument(
            applicationKey: "",
            voucherCode: "",
            bookingUrn: "",
            pageOffset: 0,
            merchantId: ""),
        forceFetch: false,
      );
      Either<Failure, PublicPromotionModelDomain>? result = await applyEmptyMock
          .getPublicPromotionData(applyArgs.toDomainArgument());
      expect(result?.isRight, true);
      expect(bloc.state.state, PublicPromotionScreenState.empty);
    });
    test('For class PublicPromotionBloc empty test when argument is null',
        () async {
      bloc.promotionUseCases = applyNullMock;
      bloc.getPromotionData(
        argument: PublicPromotionArgument(
            applicationKey: "",
            voucherCode: "",
            bookingUrn: "",
            pageOffset: 0,
            merchantId: ""),
        forceFetch: false,
      );
      Either<Failure, PublicPromotionModelDomain>? result = await applyNullMock
          .getPublicPromotionData(applyArgs.toDomainArgument());
      expect(result?.isRight, true);
      expect(bloc.state.state, PublicPromotionScreenState.failure);
    });

    test('For class PublicPromotionBloc internetFailure test', () async {
      bloc.promotionUseCases = applyInternetFailureMock;
      bloc.getPromotionData(
        argument: PublicPromotionArgument(
            applicationKey: "",
            voucherCode: "",
            bookingUrn: "",
            pageOffset: 0,
            merchantId: ""),
        forceFetch: false,
      );
      Either<Failure, PublicPromotionModelDomain>? result =
          await applyInternetFailureMock
              .getPublicPromotionData(applyArgs.toDomainArgument());
      expect(result?.isLeft, true);
      expect(bloc.state.state, PublicPromotionScreenState.internetFailure);
    });
    test('For class PublicPromotionBloc searchInternetFailure test', () async {
      bloc.promotionUseCases = applyInternetFailureMock;
      bloc.getPromotionData(
        argument: PublicPromotionArgument(
            applicationKey: "",
            voucherCode: "",
            bookingUrn: "",
            pageOffset: 0,
            merchantId: ""),
        forceFetch: true,
      );
      Either<Failure, PublicPromotionModelDomain>? result =
          await applyInternetFailureMock
              .getPublicPromotionData(applyArgs.toDomainArgument());
      expect(result?.isLeft, true);
      expect(
          bloc.state.state, PublicPromotionScreenState.searchInternetFailure);
    });
  });
  group('For class PublicPromotionBloc promo search group test', () {
    test('For class PublicPromotionBloc failure test', () async {
      bloc.getPromoCodeSearchData(null);
      expect(bloc.state.state, PublicPromotionScreenState.failure);
    });

    test('For class PublicPromotionBloc searchSuccess test', () async {
      bloc.promoCodeSearchUseCases = applySearch1000;
      bloc.getPromoCodeSearchData(
        PublicPromotionArgument(
            applicationKey: "",
            voucherCode: "",
            bookingUrn: "",
            pageOffset: 0,
            merchantId: ""),
      );
      Either<Failure, PromoCodeSearchModelDomain>? result =
          await applySearch1000
              .searchPromoCode(PromoCodeArgumentDomain(applicationKey: ''));
      expect(result?.isRight, true);
      expect(bloc.state.state, PublicPromotionScreenState.searchSuccess);
    });
  });

  test('For class PublicPromotionBloc searchFailure test', () async {
    bloc.promoCodeSearchUseCases = applySearchFailure;
    bloc.getPromoCodeSearchData(
      PublicPromotionArgument(
          applicationKey: "",
          voucherCode: "",
          bookingUrn: "",
          pageOffset: 0,
          merchantId: ""),
    );
    Either<Failure, PromoCodeSearchModelDomain>? result =
        await applySearchFailure
            .searchPromoCode(PromoCodeArgumentDomain(applicationKey: ''));
    expect(result?.isRight, true);
    expect(bloc.state.state, PublicPromotionScreenState.searchFailure);
  });

  test('For class PublicPromotionBloc searchErrorInternetFailure test',
      () async {
    bloc.promoCodeSearchUseCases = applySearchInternetFailure;
    bloc.getPromoCodeSearchData(
      PublicPromotionArgument(
          applicationKey: "",
          voucherCode: "",
          bookingUrn: "",
          pageOffset: 0,
          merchantId: ""),
    );
    Either<Failure, PromoCodeSearchModelDomain>? result =
        await applySearchInternetFailure
            .searchPromoCode(PromoCodeArgumentDomain(applicationKey: ''));
    expect(result?.isLeft, true);
    expect(bloc.state.state,
        PublicPromotionScreenState.searchErrorInternetFailure);
  });
  test('For class PublicPromotionBloc onCrossButtonTap method test', () async {
    bloc.onCrossButtonTap();
  });
  test('For class PublicPromotionBloc isNewDataRequired method test', () async {
    bloc.isNewDataRequired(0, 2);
  });
}

PublicPromotion promotion = PublicPromotion(
  promotionId: 1,
  promotionName: 'promotionName',
  shortDescription: 'shortDescription',
  discount: 50,
  discountType: 'discountType',
  discountFor: 'discountFor',
  promotionLink: 'promotionLink',
  promotionType: 'promotionType',
  voucherCode: 'voucherCode',
  promotionCode: 'promotionCode',
  startDate: DateTime.now(),
  endDate: DateTime.now().add(const Duration(days: 5)),
  applicationKey: 'Hotel',
);

PublicPromotionArgument applyArgs = PublicPromotionArgument(
    applicationKey: "applicationKey",
    voucherCode: "voucherCode",
    bookingUrn: "bookingUrn",
    pageOffset: 0,
    merchantId: "merchantId");
