import 'package:ota/domain/car_rental/car_gallery/data_sources/car_gallery_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_model_domain.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_argument_domain.dart';

import '../../../../mocks/fixture_reader.dart';

class CarGalleryRemoteDataSourceImplSuccessMock
    implements CarGalleryRemoteDataSource {
  @override
  Future<CarGalleryModelDomain> getCarGalleryData(
      CarGalleryArgumentDomain argument, int offset, int limit) async {
    String json = fixture("car_gallery/car_gallery_model_domain.json");

    ///Convert into Model
    CarGalleryModelDomain model = CarGalleryModelDomain.fromJson(json);
    return model;
    //throw UnimplementedError();
  }
}
