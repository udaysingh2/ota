import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_argument_model.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/models/hotel_dynamic_playlist_model_domain.dart';
import 'package:ota/domain/hotel_playlist/hotel_dynamic_playlist/usecases/hotel_dynamic_playlist_usecase.dart';

class HotelDynamicPlayListUseCasesFailureMock
    extends HotelDynamicPlaylistUseCases {
  @override
  Future<Either<Failure, HotelDynamicPlayListModelDomainData>?>
      getDynamicPlayListData({
    HotelDynamicPlayListDataArgumentModelDomain? argument,
  }) async {
    return Left(InternetFailure());
  }
}
