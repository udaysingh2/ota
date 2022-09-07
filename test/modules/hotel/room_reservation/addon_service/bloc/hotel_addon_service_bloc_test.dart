import 'package:flutter_test/flutter_test.dart';
import 'package:ota/domain/hotel/hotel_addon_service/data_sources/hotel_service_remote_data_source.dart';
import 'package:ota/domain/hotel/hotel_addon_service/repositories/hotel_service_repository_impl.dart';
import 'package:ota/domain/hotel/hotel_addon_service/usecases/hotel_service_use_cases.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/bloc/hotel_addon_service_bloc.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/view_model/hotel_service_view_argument.dart';
import 'package:ota/modules/hotel/room_reservation/addon_service/view_model/hotel_service_view_model.dart';

import '../../../repositories/internet_failure_mock.dart';
import '../../repositories/hotel_addon_repository_success_mock.dart';

void main() {
  HotelServiceUseCases searchUseCase;
  HotelServiceUseCases searchUseCaseFailureMock;

  HotelServiceViewArgument _getHotelServiceViewArgumentMock() {
    return HotelServiceViewArgument(
      hotelId: 'MA0711050518',
      checkInDate: '2021-10-24',
      checkOutDate: '2021-10-25',
      currency: 'TBH',
      selectedAddons: [],
      noOfAdults: 1,
    );
  }

  List<AddonServiceModel> _getDefaultArgument() {
    return <AddonServiceModel>[
      AddonServiceModel(
        serviceId: '1211',
        selectedDate: DateTime.now(),
      ),
    ];
  }

  HotelServiceViewArgument _getHotelServiceArguentWithAddon() {
    return HotelServiceViewArgument(
      hotelId: 'MA0711050518',
      checkInDate: '2021-10-24',
      checkOutDate: '2021-10-25',
      currency: 'TBH',
      selectedAddons: _getDefaultArgument(),
      noOfAdults: 1,
    );
  }

  HotelServiceViewArgument playlistViewArgument =
      _getHotelServiceViewArgumentMock();

  HotelServiceViewArgument playlistViewArgumentWithAddon =
      _getHotelServiceArguentWithAddon();

  /// Code coverage for mock class
  searchUseCase = HotelServiceUseCasesImpl(
      repository: HotelAddOnRepositoryImplSuccessMock());

  /// Internet Failure
  searchUseCaseFailureMock = HotelServiceUseCasesImpl(
      repository: HotelServiceRepositoryImpl(
          remoteDataSource: HotelServiceRemoteDataSourceImpl(),
          internetInfo: InternetFailureMock()));

  HotelAddonServiceBloc bloc = HotelAddonServiceBloc();

  test("Ota Suggestion Bloc with empty argument Test1", () {
    ///default
    expect(bloc.state.addonServiceState, HotelServiceViewModelState.none);

    // /Case when full data available
    bloc.hotelServiceUseCases = searchUseCase;
    bloc.getHotelAddonServiceData(viewArgument: playlistViewArgument);
    expect(bloc.state.addonServiceState, HotelServiceViewModelState.loading);
  });

  test("Ota Suggestion Bloc with empty argument Test2", () {
    ///default
    expect(bloc.state.addonServiceState, HotelServiceViewModelState.success);

    // /Case when full data available
    bloc.hotelServiceUseCases = searchUseCase;
    bloc.getHotelAddonServiceData(
        viewArgument: playlistViewArgumentWithAddon, isPullToRefresh: true);
    expect(bloc.state.addonServiceState,
        HotelServiceViewModelState.pullDownLoading);
  });

  test("Ota Suggestion Bloc with argument Test3", () {
    // /Case when argument are null
    bloc.hotelServiceUseCases = searchUseCase;
    bloc.getHotelAddonServiceData(viewArgument: null);
    expect(bloc.state.addonServiceState, HotelServiceViewModelState.failure);

    bloc.getHotelAddonServiceData(viewArgument: playlistViewArgument);
    expect(bloc.state.addonServiceState, HotelServiceViewModelState.loading);
  });

  test("Ota Recommendation Failure Data test4", () {
    ///Case of Failure
    bloc.hotelServiceUseCases = searchUseCaseFailureMock;
    bloc.getHotelAddonServiceData(viewArgument: playlistViewArgument);
    expect(bloc.state.addonServiceState, HotelServiceViewModelState.loading);
  });

  test("Ota Recommendation Failure Data test5", () {
    expect(
        bloc.isLoading,
        bloc.state.addonServiceState == HotelServiceViewModelState.loading &&
            bloc.state.addonServiceList.isNotEmpty);
  });

  test("Ota Recommendation Failure Data test6", () {
    expect(
        bloc.isLazyLoading,
        bloc.state.addonServiceState == HotelServiceViewModelState.loading &&
            bloc.state.addonServiceList.isEmpty);
  });

  test("Ota Recommendation Failure Data test7", () {
    expect(
        bloc.isFailure,
        bloc.state.addonServiceState == HotelServiceViewModelState.failure &&
            bloc.state.addonServiceList.isEmpty);
  });

  test("Ota Recommendation Failure Data test8", () {
    bloc.getHotelAddonServiceData(viewArgument: playlistViewArgument);
    expect(
        bloc.isSuccessEmpty,
        bloc.state.addonServiceState == HotelServiceViewModelState.success &&
            bloc.state.addonServiceList.isEmpty);
  });

  test("Ota Recommendation Failure Data test9", () {
    expect(
        bloc.pullDownLoading,
        bloc.state.addonServiceState ==
                HotelServiceViewModelState.pullDownLoading &&
            bloc.state.addonServiceList.isNotEmpty);
  });
}
