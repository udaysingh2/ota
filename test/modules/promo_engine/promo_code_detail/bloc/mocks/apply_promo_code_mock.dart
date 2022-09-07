import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_argument_domain.dart';
import 'package:ota/domain/promo_engine/apply_promo/models/apply_promo_model_domain.dart';
import 'package:ota/domain/promo_engine/apply_promo/usecases/apply_promo_use_cases.dart';

class ApplyPromoCodeStatus1000Mock extends ApplyPromoUseCasesImpl {
  @override
  Future<Either<Failure, ApplyPromoModelDomain>?> applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain) async {
    return Right(
      ApplyPromoModelDomain(
        applyPromoCode: ApplyPromoCode(
          data: Data(
            bookingUrn: 'H22A-xy-1234',
            priceDetails: PriceDetails(
              orderPrice: 200.0,
              addonPrice: 200.0,
              totalAmount: 400.0,
              billingAmount: 320.0,
              effectiveDiscount: 80.0,
            ),
          ),
          status: Status(
            code: '1000',
            description: 'Success',
            header: '',
          ),
        ),
      ),
    );
  }
}

class ApplyPromoCodeStatus1899Mock extends ApplyPromoUseCasesImpl {
  @override
  Future<Either<Failure, ApplyPromoModelDomain>?> applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain) async {
    return Right(
      ApplyPromoModelDomain(
        applyPromoCode: ApplyPromoCode(
          data: null,
          status: Status(
            code: '1899',
            description: 'failure',
            header: '',
          ),
        ),
      ),
    );
  }
}

class ApplyPromoCodeStatus1999Mock extends ApplyPromoUseCasesImpl {
  @override
  Future<Either<Failure, ApplyPromoModelDomain>?> applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain) async {
    return Right(
      ApplyPromoModelDomain(
        applyPromoCode: ApplyPromoCode(
          data: null,
          status: Status(
            code: '1999',
            description: 'failure',
            header: '',
          ),
        ),
      ),
    );
  }
}

class ApplyPromoCodeStatus3023Mock extends ApplyPromoUseCasesImpl {
  @override
  Future<Either<Failure, ApplyPromoModelDomain>?> applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain) async {
    return Right(
      ApplyPromoModelDomain(
        applyPromoCode: ApplyPromoCode(
          data: null,
          status: Status(
            code: '3023',
            description: 'failure',
            header: '',
          ),
        ),
      ),
    );
  }
}

class ApplyPromoCodeStatus3024Mock extends ApplyPromoUseCasesImpl {
  @override
  Future<Either<Failure, ApplyPromoModelDomain>?> applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain) async {
    return Right(
      ApplyPromoModelDomain(
        applyPromoCode: ApplyPromoCode(
          data: null,
          status: Status(
            code: '3024',
            description: 'failure',
            header: '',
          ),
        ),
      ),
    );
  }
}

class ApplyPromoCodeStatus3025Mock extends ApplyPromoUseCasesImpl {
  @override
  Future<Either<Failure, ApplyPromoModelDomain>?> applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain) async {
    return Right(
      ApplyPromoModelDomain(
        applyPromoCode: ApplyPromoCode(
          data: null,
          status: Status(
            code: '3025',
            description: 'failure',
            header: '',
          ),
        ),
      ),
    );
  }
}

class ApplyPromoCodeStatus3028Mock extends ApplyPromoUseCasesImpl {
  @override
  Future<Either<Failure, ApplyPromoModelDomain>?> applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain) async {
    return Right(
      ApplyPromoModelDomain(
        applyPromoCode: ApplyPromoCode(
          data: null,
          status: Status(
            code: '3028',
            description: 'failure',
            header: '',
          ),
        ),
      ),
    );
  }
}

class ApplyPromoCodeStatus3033Mock extends ApplyPromoUseCasesImpl {
  @override
  Future<Either<Failure, ApplyPromoModelDomain>?> applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain) async {
    return Right(
      ApplyPromoModelDomain(
        applyPromoCode: ApplyPromoCode(
          data: null,
          status: Status(
            code: '3033',
            description: 'failure',
            header: '',
          ),
        ),
      ),
    );
  }
}

class ApplyPromoCodeStatus3034Mock extends ApplyPromoUseCasesImpl {
  @override
  Future<Either<Failure, ApplyPromoModelDomain>?> applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain) async {
    return Right(
      ApplyPromoModelDomain(
        applyPromoCode: ApplyPromoCode(
          data: null,
          status: Status(
            code: '3034',
            description: 'failure',
            header: '',
          ),
        ),
      ),
    );
  }
}

class ApplyPromoCodeStatus3054Mock extends ApplyPromoUseCasesImpl {
  @override
  Future<Either<Failure, ApplyPromoModelDomain>?> applyPromoCode(
      ApplyPromoArgumentDomain applyPromoArgumentDomain) async {
    return Right(
      ApplyPromoModelDomain(
        applyPromoCode: ApplyPromoCode(
          data: null,
          status: Status(
            code: '3054',
            description: 'failure',
            header: '',
          ),
        ),
      ),
    );
  }
}
