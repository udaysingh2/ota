import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tours/search_result/models/tour_search_result_argument_domain.dart';
import 'package:ota/domain/tours/search_result/models/tour_search_result_model_domain.dart';
import 'package:ota/domain/tours/search_result/repository/tour_search_result_repository_impl.dart';

abstract class TourSearchResultUseCases {
  Future<Either<Failure, TourSearchResultModelDomain?>?>
      getTourSearchResultData(TourSearchResultArgumentDomain argument);
}

class TourSearchResultUseCasesImpl implements TourSearchResultUseCases {
  TourSearchResultRepository? tourSearchResultRepository;

  TourSearchResultUseCasesImpl({TourSearchResultRepository? repository}) {
    if (repository == null) {
      tourSearchResultRepository = TourSearchResultRepositoryImpl();
    } else {
      tourSearchResultRepository = repository;
    }
  }
  @override
  Future<Either<Failure, TourSearchResultModelDomain?>?>
      getTourSearchResultData(TourSearchResultArgumentDomain argument) async {
    return await tourSearchResultRepository?.getTourSearchResultData(argument);
  }
}
