import 'package:flutter_test/flutter_test.dart';

import 'package:ota/domain/car_rental/car_gallery/repositories/car_gallery_repository_impl.dart';
import 'package:ota/domain/car_rental/car_gallery/usecases/car_gallery_use_cases.dart';
import 'package:ota/modules/car_rental/car_gallery/bloc/car_gallery_bloc.dart';
import 'package:ota/modules/car_rental/car_gallery/view_model/car_gallery_argument_model.dart';
import 'package:ota/modules/car_rental/car_gallery/view_model/car_gallery_view_model.dart';

import '../../../hotel/repositories/internet_failure_mock.dart';
import '../repositories/car_gallery_remote_datascource_impl_mock.dart';
import '../repositories/car_gallery_repository_impl_success_mock_with_null_data.dart';
import '../repositories/car_gallery_usecase_impl_mock.dart';

void main() {
  String id = "2";
  CarGalleryBloc bloc = CarGalleryBloc();
  CarGalleryArgumentModel carGalleryArgumentModel =
      CarGalleryArgumentModel(carId: id);
  test('Car Gallery bloc with Mocked repository with null data pass', () async {
    bloc.galleryUseCases = CarGalleryUseCasesImpl(
        repository: CarGalleryRepositoryImplSuccessMock());
    bloc.getGalleryImages(
      argument: carGalleryArgumentModel,
      isPullToRefresh: true,
    );
    expect(bloc.state.galleryListViewModelState,
        CarGalleryViewModelState.pullDownLoading);
  });

  test("Car Gallery Bloc with mocked repository with null data pass", () {
    bloc.galleryUseCases = CarGalleryUseCasesImpl(
        repository: CarGalleryRepositoryImplSuccessMock());
    bloc.getGalleryImages(argument: carGalleryArgumentModel);
    expect(
        bloc.state.galleryListViewModelState, CarGalleryViewModelState.loading);
  });
  test("Car Gallery Bloc with mocked repository with Internet Failure", () {
    bloc.galleryUseCases = CarGalleryUseCasesImpl(
        repository: CarGalleryRepositoryImpl(
            remoteDataSource: CarGalleryRemoteDataSourceImplSuccessMock(),
            internetInfo: InternetFailureMock()));
    bloc.getGalleryImages(argument: carGalleryArgumentModel);
    expect(
        bloc.state.galleryListViewModelState, CarGalleryViewModelState.loading);
  });
  test("Car Gallery Bloc with mocked repository", () {
    bloc.galleryUseCases = CarGalleryUseCasesImpl(
        repository: CarGalleryRepositoryImplSuccessMockNull());
    bloc.getGalleryImages(argument: carGalleryArgumentModel);
    expect(
        bloc.state.galleryListViewModelState, CarGalleryViewModelState.loading);
  });

  test("Car Gallery Bloc with null argument", () {
    bloc.getGalleryImages(argument: null);
    expect(
        bloc.state.galleryListViewModelState, CarGalleryViewModelState.failure);
  });
  test("Car Gallery Bloc with mocked repository and gallery data", () {
    bloc.galleryUseCases = CarGalleryUseCasesImpl(
        repository: CarGalleryRepositoryImplSuccessMock());
    bloc.getGalleryImages(argument: carGalleryArgumentModel);
    expect(
        bloc.state.galleryListViewModelState, CarGalleryViewModelState.loading);
    bloc.state.galleryList = [CarGalleryModel(full: "full", thumb: "thumb")];
    expect(bloc.state.galleryList.length, 1);
    expect(bloc.state.galleryList[0].full, isNotEmpty);
    expect(bloc.removeImageOnError("fjk"), false);
    expect(bloc.removeImageOnError("thumb"), true);
  });
}
