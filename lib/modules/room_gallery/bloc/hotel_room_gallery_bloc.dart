import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_argument_domain.dart';
import 'package:ota/domain/room_gallery/models/room_gallery_model_domain.dart';
import 'package:ota/domain/room_gallery/usecases/room_gallery_use_cases.dart';
import 'package:ota/modules/room_gallery/view_model/room_gallery_argument_model.dart';
import 'package:ota/modules/room_gallery/view_model/room_gallery_view_model.dart';

const int _kImageLimit = 20;

class HotelRoomGalleryBloc extends Bloc<RoomGalleryViewModel> {
  int _imageOffset = 0;
  RoomGalleryUseCases galleryUseCases = RoomGalleryUseCasesImpl();

  @override
  initDefaultValue() {
    return RoomGalleryViewModel(
      galleryList: [],
    );
  }

  void setInternetPopupShown() {
    state.isInternetFailurePopupShown = true;
  }

  Future<void> getGalleryImages({
    required RoomGalleryArgumentModel? argument,
    bool isPullToRefresh = false,
  }) async {
    if (argument == null) {
      state.galleryListViewModelState = RoomGalleryViewModelState.failure;
      emit(state);
      return;
    }

    state.galleryListViewModelState = isPullToRefresh
        ? RoomGalleryViewModelState.pullDownLoading
        : RoomGalleryViewModelState.loading;
    emit(state);

    Either<Failure, RoomGalleryModelDomain>? result =
        (await galleryUseCases.getRoomGalleryData(
      argument: RoomGalleryArgumentDomain(
          hotelId: argument.hotelId, roomId: argument.roomId),
      offset: _imageOffset,
      limit: _kImageLimit,
    ));

    if (result != null && result.isRight) {
      if (result.right.getRoomImages == null ||
          result.right.getRoomImages!.data == null ||
          result.right.getRoomImages!.data!.images == null) {
        state.galleryListViewModelState = RoomGalleryViewModelState.success;
        emit(state);
        return;
      }

      List<RoomGalleryModel> resultImageList =
          _getGalleryViewModelList(result.right.getRoomImages!.data!.images!);

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
        state.galleryListViewModelState = RoomGalleryViewModelState.success;
        emit(state);
        return;
      }

      if (state.galleryList.isNotEmpty) {
        state.galleryListViewModelState = RoomGalleryViewModelState.success;
        state.galleryList.addAll(resultImageList);
        emit(state);
      }
    } else if (result?.left is InternetFailure) {
      if (state.galleryList.isNotEmpty) {
        state.galleryListViewModelState =
            RoomGalleryViewModelState.internetFailureRefresh;
        emit(state);
      } else {
        state.galleryListViewModelState =
            RoomGalleryViewModelState.internetFailure;
        emit(state);
      }
    } else {
      state.galleryListViewModelState = RoomGalleryViewModelState.failure;
      emit(state);
    }
  }

  List<RoomGalleryModel> _getGalleryViewModelList(List<Image> images) {
    return images.map((e) => RoomGalleryModel.fromModel(e.url)).toList();
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
