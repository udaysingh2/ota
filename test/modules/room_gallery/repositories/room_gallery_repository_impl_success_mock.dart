import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/room_gallery/data_sources/room_gallery_remote_data_source.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_model_domain.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_argument_domain.dart';
import 'package:ota/domain/room_gallery/repositories/room_gallery_repository_impl.dart';

import '../../../mocks/fixture_reader.dart';

class RoomGalleryRepositoryImplSuccessMock
    implements RoomGalleryRepositoryImpl {
  @override
  RoomGalleryRemoteDataSource? galleryRemoteDataSource;

  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  Future<Either<Failure, RoomGalleryModelDomain>> getRoomGalleryData(
      RoomGalleryArgumentDomain argument, int offset, int limit) async {
    String json = fixture("room_gallery/room_gallery_mock.json");
    RoomGalleryModelDomain roomGalleryModelDomain =
        RoomGalleryModelDomain.fromJson(json);
    return Right(roomGalleryModelDomain);
  }
}
