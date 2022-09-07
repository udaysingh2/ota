import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_model_domain.dart';
import 'package:ota/domain/promo_engine/apply_promo/usecases/apply_promo_use_cases.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_argument_domain.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/models/remove_promo_code_model_domain.dart';
import 'package:ota/domain/promo_engine/remove_promo_code/usecases/remove_promo_code_use_cases.dart';
import 'package:ota/modules/ota_common/model/ota_service_type.dart';
import 'package:ota/modules/promo_engine/promo_code_detail/bloc/promo_detail_bloc.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/apply_promotion_argument.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/promo_code_view_model.dart';
import 'package:ota/modules/promo_engine/search_list/view_model/public_promo_view_model.dart';

import 'mocks/apply_promo_code_mock.dart';
import 'mocks/remove_promo_code_mock.dart';

void main() {
  PromoDetailBloc bloc = PromoDetailBloc();

  ///Apply Promo Code
  ApplyPromoUseCasesImpl apply1000Mock = ApplyPromoCodeStatus1000Mock();
  ApplyPromoUseCasesImpl apply1899Mock = ApplyPromoCodeStatus1899Mock();
  ApplyPromoUseCasesImpl apply1999Mock = ApplyPromoCodeStatus1999Mock();
  ApplyPromoUseCasesImpl apply3023Mock = ApplyPromoCodeStatus3023Mock();
  ApplyPromoUseCasesImpl apply3024Mock = ApplyPromoCodeStatus3024Mock();
  ApplyPromoUseCasesImpl apply3025Mock = ApplyPromoCodeStatus3025Mock();
  ApplyPromoUseCasesImpl apply3028Mock = ApplyPromoCodeStatus3028Mock();
  ApplyPromoUseCasesImpl apply3033Mock = ApplyPromoCodeStatus3033Mock();
  ApplyPromoUseCasesImpl apply3034Mock = ApplyPromoCodeStatus3034Mock();
  ApplyPromoUseCasesImpl apply3054Mock = ApplyPromoCodeStatus3054Mock();

  ///Remove Promo Code
  RemovePromoCodeUseCasesImpl removeSuccessMock =
      RemovePromoCodeImplSuccessMock();
  RemovePromoCodeUseCasesImpl removeFailureMock =
      RemovePromoCodeImplFailureMock();
  RemovePromoCodeUseCasesImpl removeResultEmptyMock =
      RemovePromoCodeImplResultEmptyMock();

  test('For class PromoDetailBloc ==> initDefaultValue Test', () {
    bloc.initDefaultValue();

    expect(bloc.state.state, PromoCodeScreenState.none);
  });

  group('For class applyPromoCode group test', () {
    test('For class applyPromoCode ==>If argument is NULL then', () async {
      bloc.applyPromoCode(null, OtaServiceType.hotel);

      expect(bloc.state.state, PromoCodeScreenState.failure);
    });

    test('For class applyPromoCode ==> If Success code 1000 then', () async {
      bloc.applyPromoUseCases = apply1000Mock;
      bloc.applyPromoCode(
        ApplyPromoArgument(
          bookingUrn: 'bookingUrn',
          appliedPromo: promotion,
          merchantId: 'merchantId',
        ),
        OtaServiceType.hotel,
      );

      Either<Failure, ApplyPromoModelDomain?>? result = await apply1000Mock
          .applyPromoCode(applyArgs.toApplyPromoArgumentDomain());

      expect(result?.isRight, true);
      expect(bloc.state.state, PromoCodeScreenState.success);
    });

    test('For class applyPromoCode ==> If Success code 1899 then', () async {
      bloc.applyPromoUseCases = apply1899Mock;
      bloc.applyPromoCode(
        ApplyPromoArgument(
          bookingUrn: 'bookingUrn',
          appliedPromo: promotion,
          merchantId: 'merchantId',
        ),
        OtaServiceType.hotel,
      );

      Either<Failure, ApplyPromoModelDomain?>? result = await apply1899Mock
          .applyPromoCode(applyArgs.toApplyPromoArgumentDomain());

      expect(result?.isRight, true);
      expect(bloc.state.state, PromoCodeScreenState.failure1899);
    });

    test('For class applyPromoCode ==> If Success code 1999 then', () async {
      bloc.applyPromoUseCases = apply1999Mock;
      bloc.applyPromoCode(
        ApplyPromoArgument(
          bookingUrn: 'bookingUrn',
          appliedPromo: promotion,
          merchantId: 'merchantId',
        ),
        OtaServiceType.hotel,
      );

      Either<Failure, ApplyPromoModelDomain?>? result = await apply1999Mock
          .applyPromoCode(applyArgs.toApplyPromoArgumentDomain());

      expect(result?.isRight, true);
      expect(bloc.state.state, PromoCodeScreenState.failure1999);
    });

    test('For class applyPromoCode ==> If Success code 3023 then', () async {
      bloc.applyPromoUseCases = apply3023Mock;
      bloc.applyPromoCode(
        ApplyPromoArgument(
          bookingUrn: 'bookingUrn',
          appliedPromo: promotion,
          merchantId: 'merchantId',
        ),
        OtaServiceType.hotel,
      );

      Either<Failure, ApplyPromoModelDomain?>? result = await apply3023Mock
          .applyPromoCode(applyArgs.toApplyPromoArgumentDomain());

      expect(result?.isRight, true);
      expect(bloc.state.state, PromoCodeScreenState.failure3023);
    });

    test('For class applyPromoCode ==> If Success code 3024 then', () async {
      bloc.applyPromoUseCases = apply3024Mock;
      bloc.applyPromoCode(
        ApplyPromoArgument(
          bookingUrn: 'bookingUrn',
          appliedPromo: promotion,
          merchantId: 'merchantId',
        ),
        OtaServiceType.hotel,
      );

      Either<Failure, ApplyPromoModelDomain?>? result = await apply3024Mock
          .applyPromoCode(applyArgs.toApplyPromoArgumentDomain());

      expect(result?.isRight, true);
      expect(bloc.state.state, PromoCodeScreenState.failure3024);
    });

    test('For class applyPromoCode ==> If Success code 3025 then', () async {
      bloc.applyPromoUseCases = apply3025Mock;
      bloc.applyPromoCode(
        ApplyPromoArgument(
          bookingUrn: 'bookingUrn',
          appliedPromo: promotion,
          merchantId: 'merchantId',
        ),
        OtaServiceType.hotel,
      );

      Either<Failure, ApplyPromoModelDomain?>? result = await apply3025Mock
          .applyPromoCode(applyArgs.toApplyPromoArgumentDomain());

      expect(result?.isRight, true);
      expect(bloc.state.state, PromoCodeScreenState.failure3025);
    });

    test('For class applyPromoCode ==> If Success code 3028 then', () async {
      bloc.applyPromoUseCases = apply3028Mock;
      bloc.applyPromoCode(
        ApplyPromoArgument(
          bookingUrn: 'bookingUrn',
          appliedPromo: promotion,
          merchantId: 'merchantId',
        ),
        OtaServiceType.hotel,
      );

      Either<Failure, ApplyPromoModelDomain?>? result = await apply3028Mock
          .applyPromoCode(applyArgs.toApplyPromoArgumentDomain());

      expect(result?.isRight, true);
      expect(bloc.state.state, PromoCodeScreenState.failure3028);
    });

    test('For class applyPromoCode ==> If Success code 3033 then', () async {
      bloc.applyPromoUseCases = apply3033Mock;
      bloc.applyPromoCode(
        ApplyPromoArgument(
          bookingUrn: 'bookingUrn',
          appliedPromo: promotion,
          merchantId: 'merchantId',
        ),
        OtaServiceType.hotel,
      );

      Either<Failure, ApplyPromoModelDomain?>? result = await apply3033Mock
          .applyPromoCode(applyArgs.toApplyPromoArgumentDomain());

      expect(result?.isRight, true);
      expect(bloc.state.state, PromoCodeScreenState.failure3033);
    });

    test('For class applyPromoCode ==> If Success code 3034 then', () async {
      bloc.applyPromoUseCases = apply3034Mock;
      bloc.applyPromoCode(
        ApplyPromoArgument(
          bookingUrn: 'bookingUrn',
          appliedPromo: promotion,
          merchantId: 'merchantId',
        ),
        OtaServiceType.hotel,
      );

      Either<Failure, ApplyPromoModelDomain?>? result = await apply3034Mock
          .applyPromoCode(applyArgs.toApplyPromoArgumentDomain());

      expect(result?.isRight, true);
      expect(bloc.state.state, PromoCodeScreenState.failure3034);
    });

    test('For class applyPromoCode ==> If Success code 3054 then', () async {
      bloc.applyPromoUseCases = apply3054Mock;
      bloc.applyPromoCode(
        ApplyPromoArgument(
          bookingUrn: 'bookingUrn',
          appliedPromo: promotion,
          merchantId: 'merchantId',
        ),
        OtaServiceType.hotel,
      );

      Either<Failure, ApplyPromoModelDomain?>? result = await apply3054Mock
          .applyPromoCode(applyArgs.toApplyPromoArgumentDomain());

      expect(result?.isRight, true);
      expect(bloc.state.state, PromoCodeScreenState.failure3054);
    });
  });

  group('For class removePromoCode group test', () {
    test('For class removePromoCode ==>If argument is NULL then', () async {
      bloc.promoCodeUseCases = removeSuccessMock;
      bloc.removePromoCode(argument: null);

      expect(bloc.state.state, PromoCodeScreenState.removeFailure);
    });

    test('For class removePromoCode ==> If all Success then', () async {
      bloc.promoCodeUseCases = removeSuccessMock;
      bloc.removePromoCode(
          argument: PromoCodeData(
        promotion: promotion,
        isPromotionApplied: true,
        bookingUrn: 'bookingUrn',
        merchantId: 'merchantId',
        applicationKey: OtaServiceType.hotel,
      ));

      Either<Failure, RemovePromoCodeModelDomain>? result =
          await removeSuccessMock.getRemovePromoCodeData(
              RemovePromoCodeArgumentDomain(bookingUrn: 'bookingUrn'));

      expect(result?.isRight, true);
      expect(bloc.state.state, PromoCodeScreenState.removeSuccess);
    });

    test('For class removePromoCode ==> If Result is null then', () async {
      bloc.promoCodeUseCases = removeResultEmptyMock;
      bloc.removePromoCode(
          argument: PromoCodeData(
        promotion: promotion,
        isPromotionApplied: true,
        bookingUrn: 'bookingUrn',
        merchantId: 'merchantId',
        applicationKey: OtaServiceType.hotel,
      ));

      Either<Failure, RemovePromoCodeModelDomain>? result =
          await removeResultEmptyMock.getRemovePromoCodeData(
              RemovePromoCodeArgumentDomain(bookingUrn: 'bookingUrn'));

      expect(result?.isRight, true);
      expect(bloc.state.state, PromoCodeScreenState.removeFailure);
    });

    test('For class removePromoCode ==> If Internet Failure then', () async {
      bloc.promoCodeUseCases = removeFailureMock;
      bloc.removePromoCode(
          argument: PromoCodeData(
        promotion: promotion,
        isPromotionApplied: true,
        bookingUrn: 'bookingUrn',
        merchantId: 'merchantId',
        applicationKey: OtaServiceType.hotel,
      ));

      Either<Failure, RemovePromoCodeModelDomain>? result =
          await removeFailureMock.getRemovePromoCodeData(
              RemovePromoCodeArgumentDomain(bookingUrn: 'bookingUrn'));

      expect(result?.isLeft, true);
      expect(bloc.state.state, PromoCodeScreenState.internetFailure);
    });
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

ApplyPromoArgument applyArgs = ApplyPromoArgument(
  bookingUrn: 'bookingUrn',
  appliedPromo: promotion,
  merchantId: 'merchantId',
);
