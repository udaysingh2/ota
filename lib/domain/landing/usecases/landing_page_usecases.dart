import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/landing/models/landing_models.dart';
import 'package:ota/domain/landing/repositories/landing_page_repository_impl.dart';

/// Interface for HotelDetail use cases.
abstract class LandingPageUseCases {
  Future<Either<Failure, LandingData?>?> getLandingPage();
}

class LandingPageUseCasesImpl implements LandingPageUseCases {
  LandingPageRepository? roomDetailRepository;

  /// Dependence injection via constructor
  LandingPageUseCasesImpl({LandingPageRepository? repository}) {
    if (repository == null) {
      roomDetailRepository = LandingPageRepositoryImpl();
    } else {
      roomDetailRepository = repository;
    }
  }

  @override
  Future<Either<Failure, LandingData?>?> getLandingPage() async {
    return await roomDetailRepository?.getLandingPage();
  }
}
