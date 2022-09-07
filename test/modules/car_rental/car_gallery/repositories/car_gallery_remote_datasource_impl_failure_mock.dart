import 'package:ota/domain/car_rental/car_gallery/data_sources/car_gallery_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_model_domain.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_argument_domain.dart';
import 'package:ota/common/network/exceptions.dart' as exp;

class CarGalleryRemoteDataSourceFailureMock
    implements CarGalleryRemoteDataSource {
  @override
  Future<CarGalleryModelDomain> getCarGalleryData(
      CarGalleryArgumentDomain argument, int offset, int limit) {
    throw exp.ServerException(null);
  }
}
