import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tours/search_filter/models/tour_search_filter_model_domain.dart';
import 'package:ota/domain/tours/search_filter/repository/tour_search_filter_repository_impl.dart';

abstract class TourSearchFilterUseCases {
  Future<Either<Failure, TourSearchFilterModelDomain?>?>
      getTourSearchFilterData(String serviceType);
}

class TourSearchFilterUseCasesImpl implements TourSearchFilterUseCases {
  TourSearchFilterRepository? tourSearchFilterRepository;

  TourSearchFilterUseCasesImpl({TourSearchFilterRepository? repository}) {
    if (repository == null) {
      tourSearchFilterRepository = TourSearchFilterRepositoryImpl();
    } else {
      tourSearchFilterRepository = repository;
    }
  }
  @override
  Future<Either<Failure, TourSearchFilterModelDomain?>?>
      getTourSearchFilterData(String serviceType) async {
    return await tourSearchFilterRepository
        ?.getTourSearchFilterData(serviceType);
  }
}
