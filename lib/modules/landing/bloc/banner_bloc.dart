import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/landing/banner/models/banner_models.dart';
import 'package:ota/domain/landing/banner/usecases/banner_usecases.dart';
import 'package:ota/modules/landing/helper/landing_page_helper.dart';
import 'package:ota/modules/landing/view_model/banner_view_model.dart';

class BannerBloc extends Bloc<BannerViewModel> {
  LandingBannerUseCases bannerUseCases = LandingBannerUseCasesImpl();

  @override
  BannerViewModel initDefaultValue() {
    return BannerViewModel();
  }

  Future<void> getBannerData(String bannerType) async {
    state.bannerViewModelState = BannerViewModelState.loading;
    emit(state);
    Either<Failure, LandingBannerModelDomain?>? result =
        (await bannerUseCases.getLandingBanner(bannerType));
    if (result != null && result.isRight) {
      GetBannersData? getBannersData = result.right?.getBanners?.data;
      if (getBannersData?.banner == null || getBannersData!.banner!.isEmpty) {
        state.bannerViewModelState = BannerViewModelState.failure;
      } else {
        state.bannerViewModelState = BannerViewModelState.success;
        state.data = LandingPageHelper.generateBannerList(getBannersData) ?? [];
      }
      emit(state);
    } else if (result?.left is InternetFailure) {
      state.bannerViewModelState = BannerViewModelState.internetFailure;
      emit(state);
    } else {
      state.bannerViewModelState = BannerViewModelState.failure;
      emit(state);
    }
  }
}
