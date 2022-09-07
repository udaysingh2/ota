import 'package:either_dart/either.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/car_rental/car_gallery/data_sources/car_gallery_remote_data_source.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_argument_domain.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_model_domain.dart';
import 'package:ota/domain/car_rental/car_gallery/repositories/car_gallery_repository_impl.dart';

import '../../../../mocks/fixture_reader.dart';

class CarGalleryRepositoryImplSuccessMock implements CarGalleryRepositoryImpl {
  @override
  CarGalleryRemoteDataSource? galleryRemoteDataSource;

  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  Future<Either<Failure, CarGalleryModelDomain>> getCarGalleryData(
      CarGalleryArgumentDomain argument, int offset, int limit) async {
    String json = fixture("car_gallery/car_gallery_model_domain.json");
    CarGalleryModelDomain model = CarGalleryModelDomain.fromJson(json);
    printDebug(model.getAllCarRentalImages?.data?.images?.length);
    return Right(model);
    //throw UnimplementedError();
  }
}
