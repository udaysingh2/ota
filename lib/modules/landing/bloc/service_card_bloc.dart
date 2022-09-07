import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/landing/service_card/models/service_card_model_domain.dart';
import 'package:ota/domain/landing/service_card/usecases/service_card_usecases.dart';
import 'package:ota/modules/landing/view_model/landing_page_view_model.dart';

class ServiceCardBloc extends Bloc<LandingViewModel> {
  ServiceCardUseCasesImpl serviceCardUseCasesImpl = ServiceCardUseCasesImpl();

  @override
  LandingViewModel initDefaultValue() {
    return LandingViewModel(
        pageState: LandingViewPageState.initial,
        data: LandingPageViewModel.setDefault());
  }

  Future<void> getServiceCardData(bool isRefresh) async {
    if (!isRefresh) {
      emit(LandingViewModel(
          pageState: LandingViewPageState.loading,
          data: LandingPageViewModel.setDefault()));
    }
    await mapServiceCardData(serviceCardUseCasesImpl, isRefresh);
  }

  Future<void> mapServiceCardData(
      ServiceCardUseCasesImpl serviceCardUseCasesImpl, bool isRefresh) async {
    Either<Failure, ServiceCardModelDomainData?>? result =
        await serviceCardUseCasesImpl.getServiceCard();

    if (result?.isRight ?? false) {
      ServiceCardModelDomainData? serviceCardModelDomainData = result!.right;

      GetServiceCardData? serviceCardData =
          serviceCardModelDomainData?.getServiceCard?.data;
      if (serviceCardData != null) {
        LandingPageViewModel landingPageViewModel =
            LandingPageViewModel.mapFromLandingModelData(serviceCardData);
        emit(LandingViewModel(
            pageState: LandingViewPageState.success,
            data: landingPageViewModel));
      } else {
        emit(LandingViewModel(
            pageState: LandingViewPageState.failure,
            preferenceScreenState: PreferenceScreenState.dontshow,
            data: LandingPageViewModel.setDefault()));
      }
    } else if (result?.left is InternetFailure) {
      emit(LandingViewModel(
          pageState: LandingViewPageState.internetFailure,
          preferenceScreenState: PreferenceScreenState.dontshow,
          data: LandingPageViewModel.setDefault()));
    } else {
      emit(LandingViewModel(
          pageState: LandingViewPageState.failure,
          preferenceScreenState: PreferenceScreenState.dontshow,
          data: LandingPageViewModel.setDefault()));
    }
  }

  void updateSearchString(String? data) {
    state.data.previousSearchText = data ?? "";
    state.preferenceScreenState = PreferenceScreenState.dontshow;
    emit(state);
  }
}
