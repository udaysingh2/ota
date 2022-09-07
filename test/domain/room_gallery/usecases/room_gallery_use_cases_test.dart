import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/common/network/internet_info.dart';
import 'package:ota/domain/room_gallery/data_sources/room_gallery_remote_data_source.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_argument_domain.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_model_domain.dart';
import 'package:ota/domain/room_gallery/repositories/room_gallery_repository_impl.dart';
import 'package:ota/domain/room_gallery/usecases/room_gallery_use_cases.dart';

import '../../../mocks/fixture_reader.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  RoomGalleryUseCases? roomGalleryUseCase;
  setUpAll(() async {
    roomGalleryUseCase = RoomGalleryUseCasesImpl();

    roomGalleryUseCase =
        RoomGalleryUseCasesImpl(repository: _RoomGalleryUseCase());
  });

  group("Customer Use case group", () {
    test('Customer Use case test then', () async {
      final result = await roomGalleryUseCase!.getRoomGalleryData(
          argument: RoomGalleryArgumentDomain(hotelId: '', roomId: ''),
          offset: 1,
          limit: 15);

      final RoomGalleryModelDomain data = result!.right;

      expect(data.getRoomImages != null, true);
    });
  });
}

class _RoomGalleryUseCase implements RoomGalleryRepositoryImpl {
  @override
  RoomGalleryRemoteDataSource? galleryRemoteDataSource;

  @override
  InternetConnectionInfo? internetConnectionInfo;

  @override
  Future<Either<Failure, RoomGalleryModelDomain>> getRoomGalleryData(
      RoomGalleryArgumentDomain argument, int offset, int limit) {
    Map<String, dynamic> map =
        json.decode(fixture("room_gallery/room_gallery_mock.json"));
    return Future.value(Right(RoomGalleryModelDomain.fromMap(map)));
  }
}
