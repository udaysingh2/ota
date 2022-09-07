import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/loading/models/loading_model.dart';
import 'package:ota/domain/loading/usecases/loading_usecases.dart';

class LoadingUseCasesFailureMock extends LoadingUseCases {
  @override
  Future<Either<Failure, LoadingModelData>?> getLoadingData(String serviceName) async {
    return Left(InternetFailure());
  }
}
