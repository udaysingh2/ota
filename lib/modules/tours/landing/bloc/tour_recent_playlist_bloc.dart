import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/tours/tour_recent_playlist/models/tour_recent_playlist_argument_model.dart';
import 'package:ota/domain/tours/tour_recent_playlist/models/tour_recent_playlist_model_domain.dart';
import 'package:ota/domain/tours/tour_recent_playlist/use_cases/tour_recent_playlist_usecases.dart';
import 'package:ota/modules/tours/landing/view_model/tour_recent_playlist_view_model.dart';

class TourRecentPlaylistBloc extends Bloc<TourRecentPlaylistViewModel> {
  @override
  TourRecentPlaylistViewModel initDefaultValue() {
    return TourRecentPlaylistViewModel();
  }

  void getTourRecentPlaylist( ) async {
    state.pageState = TourRecentPlaylistViewModelState.loading;
    emit(state);

    TourRecentPlaylistUseCasesImpl tourRecentPlaylistUseCases =
    TourRecentPlaylistUseCasesImpl();
    Either<Failure, TourRecentPlaylistModelDomain?>? result =
    await tourRecentPlaylistUseCases.getTourRecentPlaylist(TourRecentPlaylistArgumentDomain.getDefaultInitialArguments());
    if (result?.isRight ?? false) {
      TourRecentPlaylistModelDomain? playListResult = result!.right;
      if(playListResult!=null && playListResult.getTourRecentlyViewedItems !=null && playListResult.getTourRecentlyViewedItems!.data !=null){
        TourRecentPlaylistViewModel viewModel=TourRecentPlaylistViewModel.fromData(playListResult.getTourRecentlyViewedItems!.data!);
        state.listItem = viewModel.listItem;
        state.pageState = TourRecentPlaylistViewModelState.success;
        emit(state);
      }else{
        state.pageState = TourRecentPlaylistViewModelState.failure;
        emit(state);
      }
    } else {
      state.pageState = TourRecentPlaylistViewModelState.failure;
      emit(state);
    }
  }
  bool get isSuccess => state.pageState == TourRecentPlaylistViewModelState.success;
}