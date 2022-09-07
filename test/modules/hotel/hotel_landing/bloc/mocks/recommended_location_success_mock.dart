import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/models/recommended_location_model_domain.dart';
import 'package:ota/domain/hotel/hotel_recommended_location/usecases/recommended_location_usecases.dart';

class RecommendedLocationUseCasesImplSuccessMock
    extends RecommendedLocationUseCasesImpl {
  @override
  Future<Either<Failure, RecommendedLocationModelDomain>?>
  getRecommendedLocationData(serviceType) async {
    return Right(RecommendedLocationModelDomain(
        getRecommendedLocation:
        GetRecommendedLocation(data: Data(locationList: null))));
  }
}
