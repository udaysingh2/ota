import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/landing/banner/models/banner_models.dart';
import 'package:ota/domain/landing/banner/usecases/banner_usecases.dart';
import 'package:ota/modules/landing/bloc/banner_bloc.dart';
import 'package:ota/modules/landing/view_model/banner_view_model.dart';

import 'mocks/banner_use_cases_mock.dart';

void main() {
  BannerBloc bloc = BannerBloc();

  test('For BannerBloc class ==> initDefaultValue()', () async {
    final actual = bloc.initDefaultValue();

    expect(actual.bannerViewModelState, BannerViewModelState.none);
  });

  group('For BannerBloc class ==> getBannerData() method ', () {
    LandingBannerUseCasesImpl successMock = LandingBannerUseCasesSuccessMock();
    LandingBannerUseCasesImpl bannerEmptyMock =
        LandingBannerUseCasesBannerEmptyMock();

    // test('If argument is Null data then', () async {
    //   await bloc.getBannerData('');
    //
    //   expect(bloc.state.bannerViewModelState, BannerViewModelState.failure);
    // });

    test('If argument has valid data but banner is Empty then', () async {
      bloc.bannerUseCases = bannerEmptyMock;
      await bloc.getBannerData('static');

      Either<Failure, LandingBannerModelDomain?>? result =
          await bannerEmptyMock.getLandingBanner('static');

      expect(result?.isRight, true);
      expect(bloc.state.bannerViewModelState, BannerViewModelState.failure);
    });

    test('If argument has valid all data then', () async {
      bloc.bannerUseCases = successMock;
      await bloc.getBannerData('static');

      Either<Failure, LandingBannerModelDomain?>? result =
          await successMock.getLandingBanner('static');

      expect(result?.isRight, true);
      expect(bloc.state.bannerViewModelState, BannerViewModelState.success);
    });
  });
}
