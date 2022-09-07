///TODO: Need to remove this file after testing.
// import 'package:either_dart/either.dart';
// import 'package:ota/common/network/failures.dart';
// import 'package:ota/core_components/bloc/bloc.dart';
// import 'package:ota/domain/playlist/dynamic_playlist/models/dynamic_playlist_data_argument_domain.dart';
// import 'package:ota/domain/playlist/dynamic_playlist/models/dynamic_playlist_model_domain.dart';
// import 'package:ota/domain/playlist/dynamic_playlist/usecases/dynamic_playlist_usecase.dart';
// import 'package:ota/modules/playlist/view_model/playlist_view_argument.dart';
// import 'package:ota/modules/playlist/view_model/playlist_view_model.dart';
//
// const int _kMax = 200;
// const int _kDynamicPlaylistLimit = 20;
//
// class FullDynamicPlayListBloc extends Bloc<PlaylistViewModel> {
//   DynamicPlaylistUseCases playlistUseCases = DynamicPlaylistUseCasesImpl();
//
//   @override
//   PlaylistViewModel initDefaultValue() {
//     return PlaylistViewModel(
//         playlistMap: <String, List<FullPlaylistCardViewModel>>{});
//   }
//
//   Future<void> getDynamicPlayListData({
//     required PlaylistViewArgument? argument,
//   }) async {
//     if (argument == null) {
//       state.playlistState = PlaylistViewModelState.failure;
//       emit(state);
//       return;
//     }
//
//     state.playlistState = PlaylistViewModelState.loading;
//     emit(state);
//
//     Either<Failure, DynamicPlaylistModel>? result =
//         (await playlistUseCases.getDynamicPlayListData(
//       argument: _getPlayListDataArgument(argument),
//     ));
//
//     if (result != null && result.isRight) {
//       List<Datum>? getDynamicPlaylists = result.right.getDynamicPlaylists?.data;
//       if (getDynamicPlaylists == null) {
//         state.playlistState = PlaylistViewModelState.failure;
//         emit(state);
//         return;
//       }
//
//       _updatePlaylistMapInState(getDynamicPlaylists);
//       if (argument.serviceName.isEmpty) {
//         state.selectedCategory = getAllCategories().first;
//       } else {
//         state.selectedCategory = argument.serviceName;
//       }
//       state.playlistState = PlaylistViewModelState.success;
//       emit(state);
//     } else {
//       state.playlistState = PlaylistViewModelState.failure;
//       emit(state);
//     }
//   }
//
//   // _updatePlaylistMapInState(List<Datum> playlist) {
//   //   if (playlist.isNotEmpty) {
//   //     for (Datum playlistItem in playlist) {
//   //       String categoryName = playlistItem.serviceName ?? '';
//   //       List<FullPlaylistCardViewModel> playlistCardModelList =
//   //           PlaylistHelper.getPlaylistCardViewModelList(playlistItem.list) ??
//   //               [];
//   //
//   //       /// Skip if categoryName (serviceName) or its playlist (list) are empty
//   //       if (categoryName.isNotEmpty && playlistCardModelList.isNotEmpty) {
//   //         if (!state.fullPlayList.containsKey(categoryName)) {
//   //           state.fullPlayList[categoryName] = playlistCardModelList;
//   //         } else {
//   //           state.playlistMap[categoryName]?.addAll(playlistCardModelList);
//   //         }
//   //       }
//   //     }
//   //   }
//   // }
//
//   setSelectedCategory(String _selectedCategory) {
//     state.selectedCategory = _selectedCategory;
//     emit(state);
//   }
//
//   int getSelectedCatIndex() {
//     List<String> categories = getAllCategories();
//     int index = categories.indexOf(state.selectedCategory);
//     return index >= 0 && index < categories.length ? index : 0;
//   }
//
//   List<String> getAllCategories() {
//     return state.playlistMap.keys.toList();
//   }
//
//   List<PlaylistCardViewModel> getPlaylistOfSelectedCategory() {
//     if (state.playlistMap.containsKey(state.selectedCategory)) {
//       return state.playlistMap[state.selectedCategory] ?? [];
//     }
//     return [];
//   }
//
//   DynamicPlayListDataArgumentModelDomain _getPlayListDataArgument(
//       PlaylistViewArgument argument) {
//     /// It's initial playlist load
//     if (state.playlistMap.isEmpty) {
//       return DynamicPlayListDataArgumentModelDomain.fromViewArgument(
//         argument,
//         _kMax,
//         _getPlaylistCountOfSelectedCat(),
//         _kDynamicPlaylistLimit,
//       );
//     } else {
//       /// lazy load
//       return DynamicPlayListDataArgumentModelDomain.fromViewArgument(
//         argument,
//         _kMax,
//         _getPlaylistCountOfSelectedCat(),
//         _kDynamicPlaylistLimit,
//         serviceName: state.selectedCategory,
//       );
//     }
//   }
//
//   int _getPlaylistCountOfSelectedCat() {
//     List<PlaylistCardViewModel>? playlist =
//         state.playlistMap[state.selectedCategory];
//     return playlist != null && playlist.isNotEmpty ? playlist.length : 0;
//   }
// }
