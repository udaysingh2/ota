import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/domain/tours/review_reservation/models/pickup_point_model_domain.dart';
import 'package:ota/domain/tours/review_reservation/usecases/pickup_point_reservation_usecases.dart';
import 'package:ota/modules/tours/reservation/view_model/pickup_point_view_model.dart';

class PickUpPointBloc extends Bloc<PickupPointViewModel> {
  @override
  PickupPointViewModel initDefaultValue() {
    return PickupPointViewModel(
      pageState: PickupPointState.none,
    );
  }

  Future<void> getPickUpPointDetail(String zoneId) async {
    PickUpPointUseCases pickUpPointUseCases = PickUpPointUseCasesImpl();

    Either<Failure, PickUpPointDomain>? result =
        await pickUpPointUseCases.getPickUpPointDetail(zoneId);
    if (result?.isRight ?? false) {
      PickUpPointDomain data = result!.right;
      List<PickupPoint>? pickupPoints =
          data.getPickUpDetails?.data?.pickupPoints;
      if (pickupPoints == null) {
        emit(PickupPointViewModel(pageState: PickupPointState.failure));
        return;
      }
      if (pickupPoints.isEmpty) {
        emit(PickupPointViewModel(pageState: PickupPointState.failure));
        return;
      }
      List<PickupPointData>? pickupPointsTemp =
          List.generate(pickupPoints.length, (index) {
        return PickupPointData.fromPickUpPoint(pickupPoints.elementAt(index));
      });
      emit(
        PickupPointViewModel(
            pickUpPoints: pickupPointsTemp,
            pageState: PickupPointState.success),
      );
    } else {
      emit(PickupPointViewModel(pageState: PickupPointState.failure));
    }
  }
}
