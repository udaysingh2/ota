import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_argument_domain.dart';
import 'package:ota/domain/tours/playlist/models/tour_ticket_playlist_model_domain.dart';
import 'package:ota/domain/tours/playlist/repositories/tour_ticket_playlist_repository_impl.dart';

abstract class TourTicketPlaylistUseCases {
  Future<Either<Failure, TourTicketPlaylistModelDomain?>?>
      getTourTicketPlaylistData(TourTicketPlaylistArgumentDomain argument);
}

class TourTicketPlaylistUseCasesImpl implements TourTicketPlaylistUseCases {
  TourTicketPlaylistRepository? tourTicketPlaylistRepository;

  TourTicketPlaylistUseCasesImpl({TourTicketPlaylistRepository? repository}) {
    if (repository == null) {
      tourTicketPlaylistRepository = TourAndTicketPlaylistRepositoryImpl();
    } else {
      tourTicketPlaylistRepository = repository;
    }
  }
  @override
  Future<Either<Failure, TourTicketPlaylistModelDomain?>?>
      getTourTicketPlaylistData(
          TourTicketPlaylistArgumentDomain argument) async {
    return await tourTicketPlaylistRepository
        ?.getTourTicketPlayListData(argument);
  }
}
