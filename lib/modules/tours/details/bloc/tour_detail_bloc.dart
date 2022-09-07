import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/domain/tours/details/models/tour_details_models.dart';
import 'package:ota/domain/tours/details/usecases/tours_details_usecases.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_argument.dart';
import 'package:ota/modules/tours/details/view_model/tour_detail_view_model.dart';

class TourDetailBloc extends Bloc<TourDetailViewModel> {
  @override
  TourDetailViewModel initDefaultValue() {
    return TourDetailViewModel(pageState: TourDetailScreenPageState.initial);
  }

  Future<void> getTourDetail(
      TourDetailArgument? argument, bool isRefresh) async {
    if (argument == null) {
      emit(TourDetailViewModel(pageState: TourDetailScreenPageState.failure));
      return;
    }
    if (!isRefresh) {
      emit(TourDetailViewModel(pageState: TourDetailScreenPageState.loading));
    }

    TourDetailsUseCasesImpl tourDetailsUseCases = TourDetailsUseCasesImpl();
    await mapTourDetail(tourDetailsUseCases, argument, isRefresh);
  }

  Future<void> mapTourDetail(TourDetailsUseCasesImpl tourDetailsUseCases,
      TourDetailArgument argument, bool isRefresh) async {
    Either<Failure, TourDetail>? result = await tourDetailsUseCases
        .getToursDetails(argument.toTourDomainArgument());

    if (result?.isRight ?? false) {
      TourDetail data = result!.right;
      String? statusCode = data.getTourDetails?.status?.code;
      if (statusCode == kErrorCode1899) {
        emit(TourDetailViewModel(
            pageState: TourDetailScreenPageState.failure1899));
      } else if (statusCode == kErrorCode1999) {
        emit(TourDetailViewModel(
            pageState: TourDetailScreenPageState.failure1999));
      } else if (statusCode == kSuccessCode) {
        Tour? tourDetail = data.getTourDetails?.data?.tour;
        List<TourDetailPromotionList>? promotionList =
            data.getTourDetails?.data?.promotionList ?? [];
        if (tourDetail != null) {
          emit(TourDetailViewModel(
              pageState: TourDetailScreenPageState.success,
              data: TourDetailModel.mapFromTourDetail(
                  tourDetail, argument, promotionList)));
        } else {
          emit(TourDetailViewModel(
              pageState: TourDetailScreenPageState.failure));
        }
      } else {
        emit(TourDetailViewModel(pageState: TourDetailScreenPageState.failure));
      }
    } else if (result?.left is InternetFailure) {
      emit(TourDetailViewModel(
          pageState: TourDetailScreenPageState.internetFailure));
    } else {
      emit(TourDetailViewModel(pageState: TourDetailScreenPageState.failure));
    }
  }

  bool get isPackagesEmpty => packages.isEmpty;

  List<TourPackage> get packages => state.data?.packages ?? [];

}
