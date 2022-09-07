import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/room_gallery/repositories/room_gallery_repository_impl.dart';
import 'package:ota/domain/room_gallery/usecases/room_gallery_use_cases.dart';
import 'package:ota/modules/room_gallery/bloc/hotel_room_gallery_bloc.dart';
import 'package:ota/modules/room_gallery/view_model/room_gallery_argument_model.dart';
import 'package:ota/modules/room_gallery/view_model/room_gallery_view_model.dart';

import '../../hotel/repositories/internet_failure_mock.dart';
import '../repositories/room_gallery_remote_data_source_impl_success_mock.dart';
import '../repositories/room_gallery_repository_impl_success_mock.dart';
import '../repositories/room_gallery_repository_impl_success_mock_null.dart';

void main() {
  HotelRoomGalleryBloc bloc = HotelRoomGalleryBloc();
  RoomGalleryArgumentModel roomGalleryArgument = RoomGalleryArgumentModel(
    hotelId: 'MA0711050518',
    roomId: 'MA05110034',
  );
  test("Room Gallery Bloc with mocked repository with null data pass", () {
    bloc.galleryUseCases = RoomGalleryUseCasesImpl(
        repository: RoomGalleryRepositoryImplSuccessMock());
    bloc.getGalleryImages(argument: roomGalleryArgument, isPullToRefresh: true);
    expect(bloc.state.galleryListViewModelState,
        RoomGalleryViewModelState.pullDownLoading);
  });
  test("Room Gallery Bloc with mocked repository with null data pass", () {
    bloc.galleryUseCases = RoomGalleryUseCasesImpl(
        repository: RoomGalleryRepositoryImplSuccessMock());
    bloc.getGalleryImages(argument: roomGalleryArgument);
    expect(bloc.state.galleryListViewModelState,
        RoomGalleryViewModelState.loading);
  });
  test("Room Gallery Bloc with mocked repository with Internet Failure", () {
    bloc.galleryUseCases = RoomGalleryUseCasesImpl(
        repository: RoomGalleryRepositoryImpl(
            remoteDataSource: RoomGalleryRemoteDataSourceImplSuccessMock(),
            internetInfo: InternetFailureMock()));
    bloc.getGalleryImages(argument: roomGalleryArgument);
    expect(bloc.state.galleryListViewModelState,
        RoomGalleryViewModelState.loading);
  });
  test("Room Gallery Bloc with mocked repository", () {
    bloc.galleryUseCases = RoomGalleryUseCasesImpl(
        repository: RoomGalleryRepositoryImplSuccessMockNull());
    bloc.getGalleryImages(argument: roomGalleryArgument);
    expect(bloc.state.galleryListViewModelState,
        RoomGalleryViewModelState.loading);
  });
  test("Room Gallery Bloc with null argument", () {
    bloc.getGalleryImages(argument: null);
    expect(bloc.state.galleryListViewModelState,
        RoomGalleryViewModelState.failure);
  });
  test("Room Gallery Bloc with mocked repository and gallery data", () {
    bloc.galleryUseCases = RoomGalleryUseCasesImpl(
        repository: RoomGalleryRepositoryImplSuccessMock());
    bloc.getGalleryImages(argument: roomGalleryArgument);
    expect(bloc.state.galleryListViewModelState,
        RoomGalleryViewModelState.loading);
    bloc.state.galleryList = [RoomGalleryModel(imageUrl: "imageUrl")];
    expect(bloc.state.galleryList.length, 1);
    // expect(bloc.removeImageOnError("abc"), false);
    expect(bloc.removeImageOnError("imageUrl"), true);
  });
}
