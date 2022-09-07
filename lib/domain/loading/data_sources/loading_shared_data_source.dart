import 'package:ota/core_pack/caching/ota_preference.dart';
import 'package:ota/domain/loading/models/loading_model.dart';

/// Interface for Loading Data remote data source.
abstract class LoadingSharedDataSource {
  /// Call API to get the Loading Screen details.
  /// [Either<Failure, LoadingModel>] to handle the Failure or result data.
  Future<LoadingModelData> getLoadingData();
}

class LoadingSharedDataSourceImpl implements LoadingSharedDataSource {
  /// Call API to get the Loading Screen details.
  ///
  /// [Either<Failure, LoadingModel>] to handle the Failure or result data.
  @override
  Future<LoadingModelData> getLoadingData() async {
    final String? result = await OtaPreference.shared.getLoadingJsonData();
    if (result!.isNotEmpty) {
      return LoadingModelData.fromJson(result);
    } else {
      throw Exception();
    }
  }
}
