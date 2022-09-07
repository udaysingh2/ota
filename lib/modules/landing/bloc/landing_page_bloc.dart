// import 'package:either_dart/either.dart';
// import 'package:ota/common/network/failures.dart';
// import 'package:ota/core_components/bloc/bloc.dart';
// import 'package:ota/domain/landing/models/landing_models.dart';
// import 'package:ota/domain/landing/usecases/landing_page_usecases.dart';
// import 'package:ota/modules/landing/view_model/landing_page_view_model.dart';
//
// class LandingPageViewBloc extends Bloc<LandingViewModel> {
//   @override
//   LandingViewModel initDefaultValue() {
//     return LandingViewModel(pageState: LandingViewPageState.initial);
//   }
//
//   Future<void> getLandingPageData(bool isRefresh) async {
//     if (!isRefresh) {
//       emit(LandingViewModel(pageState: LandingViewPageState.loading));
//     }
//     LandingPageUseCasesImpl landingPageUseCasesImpl = LandingPageUseCasesImpl();
//     await mapLandingPage(landingPageUseCasesImpl, isRefresh);
//   }
//
//   Future<void> mapLandingPage(
//       LandingPageUseCasesImpl landingPageUseCasesImpl, bool isRefresh) async {
//     Either<Failure, LandingData?>? result =
//         await landingPageUseCasesImpl.getLandingPage();
//
//     if (result?.isRight ?? false) {
//       LandingData? _landingData = result!.right;
//
//       GetLandingPageDetailsData? _landingModelData =
//           _landingData?.getLandingPageDetails?.data;
//       if (_landingModelData != null) {
//         LandingPageViewModel _landingPageViewModel =
//             LandingPageViewModel.mapFromLandingModelData(_landingModelData);
//         final PreferenceScreenState isPrefrenceScreenShow =
//             _landingPageViewModel.isPreferenceListAvailable()
//                 ? PreferenceScreenState.show
//                 : PreferenceScreenState.dontshow;
//         _landingPageViewModel.setPopup(0);
//         emit(LandingViewModel(
//             pageState: LandingViewPageState.success,
//             preferenceScreenState: isPrefrenceScreenShow,
//             data: _landingPageViewModel));
//       } else {
//         emit(LandingViewModel(
//           pageState: LandingViewPageState.failure,
//           preferenceScreenState: PreferenceScreenState.dontshow,
//         ));
//       }
//     } else {
//       emit(LandingViewModel(
//         pageState: LandingViewPageState.failure,
//         preferenceScreenState: PreferenceScreenState.dontshow,
//       ));
//     }
//   }
//
//   bool get shouldShowPreferenceScreen =>
//       state.data?.preferencesList != null &&
//       state.data!.preferencesList!.isNotEmpty;
//
//   void updateSearchString(String? data) {
//     state.data?.previousSearchText = data;
//     state.preferenceScreenState = PreferenceScreenState.dontshow;
//     emit(state);
//   }
//
//   void setPreferenceSubmitSuccess() {
//     state.data?.preferencesList = [];
//     state.preferenceScreenState = PreferenceScreenState.dontshow;
//   }
// }
