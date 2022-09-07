import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/gallery/repositories/gallery_repository_impl.dart';
import 'package:ota/domain/gallery/usecases/gallery_use_cases.dart';
import 'package:ota/modules/gallery/bloc/gallery_bloc.dart';
import 'package:ota/modules/gallery/view_model/gallery_list_view_model.dart';
import 'package:ota/modules/gallery/view_model/gallery_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';

import '../../../mocks/hotel/hotel_details/hotel_detail_mock.dart';
import '../../hotel/repositories/internet_failure_mock.dart';
import '../repositories/gallery_remote_datasource_impl_mock.dart';
import '../repositories/gallery_repository_impl_success_mock.dart';
import '../repositories/gallery_repository_impl_success_mock_with_null_data.dart';

void main() {
  GalleryBloc bloc = GalleryBloc();
  HotelDetailArgument hotelDetailArgument = getHotelDetailArgumentMock();

  test("Gallery Bloc with mocked repository with null data pass", () {
    bloc.galleryUseCases =
        GalleryUseCasesImpl(repository: GalleryRepositoryImplSuccessMock());
    bloc.getGalleryImages(argument: hotelDetailArgument, isPullToRefresh: true);
    expect(bloc.state.galleryListViewModelState,
        GalleryListViewModelState.pullDownLoading);
  });
  test("Gallery Bloc with mocked repository with null data pass", () {
    bloc.galleryUseCases =
        GalleryUseCasesImpl(repository: GalleryRepositoryImplSuccessMock());
    bloc.getGalleryImages(argument: hotelDetailArgument);
    expect(bloc.state.galleryListViewModelState,
        GalleryListViewModelState.loading);
  });
  test("Gallery Bloc with mocked repository with Internet Failure", () {
    bloc.galleryUseCases = GalleryUseCasesImpl(
        repository: GalleryRepositoryImpl(
            remoteDataSource: GalleryRemoteDataSourceImplSuccessMock(),
            internetInfo: InternetFailureMock()));
    bloc.getGalleryImages(argument: hotelDetailArgument);
    expect(bloc.state.galleryListViewModelState,
        GalleryListViewModelState.loading);
  });
  test("Gallery Bloc with mocked repository", () {
    bloc.galleryUseCases =
        GalleryUseCasesImpl(repository: GalleryRepositoryImplSuccessMockNull());
    bloc.getGalleryImages(argument: hotelDetailArgument);
    expect(bloc.state.galleryListViewModelState,
        GalleryListViewModelState.loading);
  });
  test("Gallery Bloc with null argument", () {
    bloc.getGalleryImages(argument: null);
    expect(bloc.state.galleryListViewModelState,
        GalleryListViewModelState.failure);
  });
  test("Gallery Bloc with mocked repository and gallery data", () {
    bloc.galleryUseCases =
        GalleryUseCasesImpl(repository: GalleryRepositoryImplSuccessMock());
    bloc.getGalleryImages(argument: hotelDetailArgument);
    expect(bloc.state.galleryListViewModelState,
        GalleryListViewModelState.loading);
    bloc.state.galleryList = [GalleryViewModel(imageUrl: "imageUrl")];
    expect(bloc.state.galleryList.length, 1);
    // expect(bloc.removeImageOnError("fjk"), false);
    expect(bloc.removeImageOnError("imageUrl"), true);
  });
}
