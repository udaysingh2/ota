import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_argument_model.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_model_domain.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/usecases/hotel_dynamic_playlist_usecase.dart';
import 'package:ota/modules/hotel/hotel_landing/bloc/hotel_dynamic_playlist_bloc.dart';
import 'package:ota/modules/hotel/hotel_landing/view_model/hotel_dynamic_playlist_view_models.dart';

import 'mocks/hotel_dynamic_playlist_use_cases_failure_mock.dart';
import 'mocks/hotel_dynamic_playlist_use_cases_success_mock.dart';

void main() {
  HotelDynamicPlaylistBloc bloc = HotelDynamicPlaylistBloc();
  HotelDynamicPlaylistUseCases recentSuccessMock =
      HotelDynamicPlayListRecentSuccessMock();
  HotelDynamicPlaylistUseCases dynamicSuccessMock =
      HotelDynamicPlayListDynamicSuccessMock();
  HotelDynamicPlaylistUseCases elseSuccessMock =
      HotelDynamicPlayListElseSuccessMock();
  HotelDynamicPlaylistUseCases failureMock =
      HotelDynamicPlayListUseCasesFailureMock();

  group('For checkIfRecentPlayListExists()', () {
    test('Case of null argument then', () {
      final isExist = bloc.checkIfRecentPlayListExists(null);
      expect(!isExist, true);
    });

    test('If recentViewPlaylist == NULL then', () {
      final isExist = bloc.checkIfRecentPlayListExists(getRecentNull());
      expect(!isExist, true);
    });

    test('If recentViewPlaylist == isEmpty then', () {
      final isExist = bloc.checkIfRecentPlayListExists(getRecentEmpty());
      expect(!isExist, true);
    });

    test('If full data in argument then', () {
      final isExist = bloc.checkIfRecentPlayListExists(getDomainData());
      expect(isExist, true);
    });
  });

  group('For checkIfDynamicPlaylistExists()', () {
    test('Case of null argument then', () {
      final isExist = bloc.checkIfDynamicPlaylistExists(null);
      expect(!isExist, true);
    });

    test('If recentViewPlaylist == NULL then', () {
      final isExist = bloc.checkIfDynamicPlaylistExists(getPlayListNull());

      expect(!isExist, true);
    });

    test('If recentViewPlaylist == isEmpty then', () {
      final isExist = bloc.checkIfDynamicPlaylistExists(getPlayListNull());

      expect(!isExist, true);
    });

    test('If full data in argument then', () {
      final isExist = bloc.checkIfDynamicPlaylistExists(getDomainData());
      expect(isExist, true);
    });
  });

  group('For getDynamicPlayListData in playlistUseCases override method', () {
    test('For getDynamicPlayListData test ==> If Failure case then', () async {
      ///bloc method call
      bloc.playlistUseCases = failureMock;
      await bloc.getDynamicPlayListData(getArgument());

      Either<Failure, HotelDynamicPlayListModelDomainData>? failResult =
          (await failureMock.getDynamicPlayListData());

      expect(failResult?.isLeft, true);
      expect(bloc.state.hotelDynamicPlayListViewModelState,
          HotelDynamicPlayListViewModelState.failure);
    });

    group('For getDynamicPlayListData test ==> If "SUCCESS" case then', () {
      test('When checkIfRecentPlayListExists() is "TRUE"', () async {
        ///bloc method call
        bloc.playlistUseCases = recentSuccessMock;
        await bloc.getDynamicPlayListData(getArgument());

        Either<Failure, HotelDynamicPlayListModelDomainData>? failResult =
            (await recentSuccessMock.getDynamicPlayListData());

        expect(failResult?.isRight, true);
        expect(bloc.state.hotelDynamicPlayListViewModelState,
            HotelDynamicPlayListViewModelState.recentPlayListSuccess);
      });

      test('When checkIfDynamicPlaylistExists() is "TRUE"', () async {
        ///bloc method call
        bloc.playlistUseCases = dynamicSuccessMock;
        await bloc.getDynamicPlayListData(getArgument());

        Either<Failure, HotelDynamicPlayListModelDomainData>? failResult =
            (await dynamicSuccessMock.getDynamicPlayListData());

        expect(failResult?.isRight, true);
        expect(bloc.state.hotelDynamicPlayListViewModelState,
            HotelDynamicPlayListViewModelState.dynamicPlayListSuccess);
      });

      test('When Recent + Dynamic both playlist false then else is "TRUE"',
          () async {
        ///bloc method call
        bloc.playlistUseCases = elseSuccessMock;
        await bloc.getDynamicPlayListData(getArgument());

        Either<Failure, HotelDynamicPlayListModelDomainData>? failResult =
            (await elseSuccessMock.getDynamicPlayListData());

        expect(failResult?.isRight, true);
        expect(bloc.state.hotelDynamicPlayListViewModelState,
            HotelDynamicPlayListViewModelState.failure);
      });
    });
  });
}

HotelDynamicPlayListModelDomainData? getDomainData() {
  return HotelDynamicPlayListModelDomainData(
    getRecentViewPlaylist: GetRecentViewPlaylist(
      listType: 'vertical',
      dynamicPlaylist: DynamicPlaylist(
        playlist: [
          Playlist(
            playlistId: 'playlistId',
            playlistName: 'playlistName',
          ),
        ],
      ),
      recentViewPlaylist: [
        RecentViewPlaylist(
            hotelId: 'MA1111000019',
            hotelName: '',
            cityId: 'MA05110041',
            countryId: 'MA05110001',
            rating: 4,
            image: '',
            locationName: 'Thailand',
            promotionList: [
              PromotionList(
                promotionType: 'CAPSULE',
                name: 'name1',
                productId: 'productId',
                productType: 'productType',
                line1: 'line111',
                line2: 'line222',
                promotionCode: 'promotionCode',
              ),
              PromotionList(
                promotionType: 'OVERLAY',
                name: 'name2',
                productId: 'productId',
                productType: 'productType',
                line1: 'line333',
                line2: 'line444',
                promotionCode: 'promotionCode',
              ),
            ]),
      ],
    ),
  );
}

HotelDynamicPlayListModelDomainData? getRecentNull() {
  return HotelDynamicPlayListModelDomainData(
    getRecentViewPlaylist: GetRecentViewPlaylist(
      recentViewPlaylist: null,
    ),
  );
}

HotelDynamicPlayListModelDomainData? getRecentEmpty() {
  return HotelDynamicPlayListModelDomainData(
    getRecentViewPlaylist: GetRecentViewPlaylist(
      recentViewPlaylist: [],
    ),
  );
}

HotelDynamicPlayListModelDomainData? getPlayListNull() {
  return HotelDynamicPlayListModelDomainData(
    getRecentViewPlaylist: GetRecentViewPlaylist(
      dynamicPlaylist: DynamicPlaylist(
        playlist: null,
      ),
    ),
  );
}

HotelDynamicPlayListModelDomainData? getPlayListEmpty() {
  return HotelDynamicPlayListModelDomainData(
    getRecentViewPlaylist: GetRecentViewPlaylist(
      dynamicPlaylist: DynamicPlaylist(
        playlist: [],
      ),
    ),
  );
}

HotelDynamicPlayListDataArgumentModelDomain getArgument() {
  return HotelDynamicPlayListDataArgumentModelDomain(
    userId: 'userId',
    lat: 73.54365,
    long: 28.43778,
    epoch: '1646302633',
  );
}
