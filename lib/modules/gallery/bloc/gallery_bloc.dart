import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/gallery/models/gallery_model_domain.dart';
import 'package:ota/domain/gallery/models/gallery_result_model.dart';
import 'package:ota/domain/gallery/models/images_model.dart';
import 'package:ota/domain/gallery/usecases/gallery_use_cases.dart';
import 'package:ota/modules/favourites/view_model/ota_favourite_service_type.dart';
import 'package:ota/modules/gallery/view_model/gallery_argument_model.dart';
import 'package:ota/modules/gallery/view_model/gallery_list_view_model.dart';
import 'package:ota/modules/gallery/view_model/gallery_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';

const int _kImageLimit = 20;

class GalleryBloc extends Bloc<GalleryListViewModel> {
  int _imageOffset = 0;
  int _invalidUrl = 0;
  int currentPageNumber = 0;
  GalleryUseCases galleryUseCases = GalleryUseCasesImpl();

  @override
  initDefaultValue() {
    return GalleryListViewModel(
      galleryList: [],
    );
  }

  bool isNewDataRequired(int index) {
    return ((_kImageLimit * currentPageNumber - _invalidUrl) == (index + 1))
        ? true
        : false;
  }

  Future<void> getGalleryImagesForService({
    required GalleryArgument? argument,
    bool isPullToRefresh = false,
  }) async {
    if (isPullToRefresh) {
      currentPageNumber = 0;
      _invalidUrl = 0;
      state.galleryListViewModelState =
          GalleryListViewModelState.pullDownLoading;
      emit(state);
    } else if (state.galleryList.isEmpty) {
      state.galleryListViewModelState = GalleryListViewModelState.loading;
      emit(state);
    } else {
      state.galleryListViewModelState =
          GalleryListViewModelState.lazyDownLoading;
      emit(state);
    }
    currentPageNumber++;
    if (argument == null) {
      state.galleryListViewModelState = GalleryListViewModelState.failure;
      emit(state);
      return;
    }

    Either<Failure, GalleryModelDomain>? result =
        (await galleryUseCases.getGalleryImages(
      argument: argument.toGalleryDataArgumentDomain(),
      offset: ((currentPageNumber - 1) * _kImageLimit).toString(),
      limit: _kImageLimit.toString(),
    ));

    if (result != null && result.isRight) {
      final List<String>? images;
      if (argument.serviceName == OtaFavouriteServiceType.tour) {
        images = result.right.getAllTourImages?.data?.images;
      } else {
        images = result.right.getAllTicketImages?.data?.images;
      }
      if (images == null) {
        state.galleryListViewModelState = GalleryListViewModelState.success;
        emit(state);
        return;
      }

      List<GalleryViewModel> resultImageList =
          List.generate(images.length, (index) {
        return GalleryViewModel(imageUrl: images!.elementAt(index));
      });

      for (GalleryViewModel element in resultImageList) {
        await element.updateUrlStatus();
      }
      resultImageList.removeWhere((element) {
        if (!element.isValid) {
          _invalidUrl++;
        }
        return !element.isValid;
      });

      /// Setting offset here, since state gallery list item might get removed
      /// if there is any error in image fetch
      _imageOffset += _kImageLimit;

      if (isPullToRefresh) {
        _imageOffset = 0;
        state.galleryListViewModelState = GalleryListViewModelState.success;
        state.galleryList.clear();
        emit(state);
      }

      if (state.galleryList.isEmpty) {
        state.galleryList = resultImageList;
        state.galleryListViewModelState = GalleryListViewModelState.success;
        emit(state);
        return;
      }

      if (state.galleryList.isNotEmpty) {
        state.galleryListViewModelState = GalleryListViewModelState.success;
        state.galleryList.addAll(resultImageList);
        emit(state);
      }
    } else if (result?.left is InternetFailure) {
      if (state.galleryList.isNotEmpty) {
        state.galleryListViewModelState =
            GalleryListViewModelState.internetFailureRefresh;
        emit(state);
      } else {
        state.galleryListViewModelState =
            GalleryListViewModelState.internetFailure;
        emit(state);
      }
    } else {
      state.galleryListViewModelState = GalleryListViewModelState.failure;
      emit(state);
    }
  }

  void setInternetPopupShown() {
    state.isInternetFailurePopupShown = true;
  }

  Future<void> getGalleryImages({
    required HotelDetailArgument? argument,
    bool isPullToRefresh = false,
  }) async {
    if (argument == null) {
      state.galleryListViewModelState = GalleryListViewModelState.failure;
      emit(state);
      return;
    }

    state.galleryListViewModelState = isPullToRefresh
        ? GalleryListViewModelState.pullDownLoading
        : GalleryListViewModelState.loading;
    emit(state);

    Either<Failure, GalleryResultModel>? result =
        (await galleryUseCases.getGalleryData(
      argument: argument.toHotelDataArgument(),
      offset: _imageOffset.toString(),
      limit: _kImageLimit.toString(),
    ));

    if (result != null && result.isRight) {
      if (result.right.data == null ||
          result.right.data!.hotelDetail == null ||
          result.right.data!.hotelDetail!.images == null) {
        state.galleryListViewModelState = GalleryListViewModelState.success;
        emit(state);
        return;
      }

      List<GalleryViewModel> resultImageList =
          _getGalleryViewModelList(result.right.data!.hotelDetail!.images!);

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
        state.galleryListViewModelState = GalleryListViewModelState.success;
        emit(state);
        return;
      }

      if (state.galleryList.isNotEmpty) {
        state.galleryListViewModelState = GalleryListViewModelState.success;
        state.galleryList.addAll(resultImageList);
        emit(state);
      }
    } else if (result?.left is InternetFailure) {
      if (state.galleryList.isNotEmpty) {
        state.galleryListViewModelState =
            GalleryListViewModelState.internetFailureRefresh;
      } else {
        state.galleryListViewModelState =
            GalleryListViewModelState.internetFailure;
      }
      emit(state);
    } else {
      state.galleryListViewModelState = GalleryListViewModelState.failure;
      emit(state);
    }
  }

  List<GalleryViewModel> _getGalleryViewModelList(ImagesModel imagesModel) {
    List<String?> imagePathList =
        imagesModel.gallery != null ? imagesModel.gallery! : [];
    return imagePathList
        .map((e) => GalleryViewModel.fromModel(imagesModel.baseUri, e))
        .toList();
  }

  bool removeImageOnError(String imgUrl) {
    if (state.galleryList.isNotEmpty) {
      final imageModel =
          state.galleryList.firstWhere((element) => element.imageUrl == imgUrl);
      state.galleryList.remove(imageModel);
      emit(state);
      return true;
    } else {
      return false;
    }
  }
}
