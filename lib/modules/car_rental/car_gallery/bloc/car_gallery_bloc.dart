import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_argument_domain.dart';
import 'package:ota/domain/car_rental/car_gallery/models/car_gallery_model_domain.dart';
import 'package:ota/domain/car_rental/car_gallery/usecases/car_gallery_use_cases.dart';
import 'package:ota/modules/car_rental/car_gallery/view_model/car_gallery_argument_model.dart';
import 'package:ota/modules/car_rental/car_gallery/view_model/car_gallery_view_model.dart';

const int _kImageLimit = 20;

class CarGalleryBloc extends Bloc<CarGalleryViewModel> {
  int _imageOffset = 0;
  CarGalleryUseCases galleryUseCases = CarGalleryUseCasesImpl();

  @override
  initDefaultValue() {
    return CarGalleryViewModel(
      galleryList: [],
    );
  }

  Future<void> getGalleryImages({
    required CarGalleryArgumentModel? argument,
    bool isPullToRefresh = false,
  }) async {
    if (argument == null) {
      state.galleryListViewModelState = CarGalleryViewModelState.failure;
      emit(state);
      return;
    }

    state.galleryListViewModelState = isPullToRefresh
        ? CarGalleryViewModelState.pullDownLoading
        : CarGalleryViewModelState.loading;
    emit(state);

    Either<Failure, CarGalleryModelDomain>? result =
        (await galleryUseCases.getCarGalleryData(
      argument: CarGalleryArgumentDomain(carId: argument.carId),
      offset: _imageOffset,
      limit: _kImageLimit,
    ));

    if (result != null && result.isRight) {
      if (result.right.getAllCarRentalImages == null ||
          result.right.getAllCarRentalImages!.data == null ||
          result.right.getAllCarRentalImages!.data!.images == null ||
          result.right.getAllCarRentalImages!.data!.images == null) {
        state.galleryListViewModelState = CarGalleryViewModelState.success;
        emit(state);
        return;
      }

      List<CarGalleryModel> resultImageList = _getGalleryViewModelList(
          result.right.getAllCarRentalImages!.data!.images!);

      /// Setting offset here, since state gallery list item might get removed
      /// if there is any error in image fetch
      _imageOffset += _kImageLimit;

      if (isPullToRefresh) {
        _imageOffset = 0;
        state.galleryList.clear();
        emit(state);
      }

      if (state.galleryList.isEmpty) {
        state.galleryList = resultImageList;
        state.galleryListViewModelState = CarGalleryViewModelState.success;
        emit(state);
        return;
      }

      if (state.galleryList.isNotEmpty) {
        state.galleryListViewModelState = CarGalleryViewModelState.success;
        state.galleryList.addAll(resultImageList);
        emit(state);
      }
    } else {
      if (result?.left is InternetFailure) {
        state.galleryListViewModelState =
            CarGalleryViewModelState.failureNetwork;
        emit(state);
      } else {
        state.galleryListViewModelState = CarGalleryViewModelState.failure;
        emit(state);
      }
    }
  }

  List<CarGalleryModel> _getGalleryViewModelList(List<Image> images) {
    return images
        .map((e) => CarGalleryModel.fromModel(e.thumb, e.full))
        .toList();
  }

  bool removeImageOnError(String imgUrl) {
    if (state.galleryList.isNotEmpty) {
      final index =
          state.galleryList.indexWhere((element) => element.thumb == imgUrl);
      if (index == -1) {
        return false;
      } else {
        state.galleryList.removeAt(index);
        emit(state);
      }
      return true;
    } else {
      return false;
    }
  }
}
