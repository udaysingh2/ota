import 'package:either_dart/src/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/models/hotel_detail_interest_data_argument.dart';
import 'package:ota/domain/hotel/hotel_detail_interest/usecases/hotel_detail_interest_use_cases.dart';

class HotelDetailInterestImplSuccessMock
    extends HotelDetailInterestUseCasesImpl {
  @override
  Future<Either<Failure, HotelDetailInterestData>?> getHotelDetailInterest(
      HotelDetailInterestDataArgument argument) async {
    return Right(
      HotelDetailInterestData(
        data: HotelDetailInterestDataData(
          getHotelsYouMayLike: GetHotelsYouMayLike(
            data: GetHotelsYouMayLikeData(
              hotelList: [
                HotelList(
                  hotelId: '',
                  totalPrice: 1000.0,
                  hotelName: 'Hotel',
                  image: '',
                  capsulePromotions: [],
                  rating: 5,
                  pricePerNight: 800.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HotelDetailInterestImplFailureMock
    extends HotelDetailInterestUseCasesImpl {
  @override
  Future<Either<Failure, HotelDetailInterestData>?> getHotelDetailInterest(
      HotelDetailInterestDataArgument argument) async {
    return Left(InternetFailure());
  }
}
