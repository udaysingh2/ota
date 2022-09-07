import 'package:either_dart/either.dart';
import 'package:ota/common/network/failures.dart';
import 'package:ota/core_components/bloc/bloc.dart';
import 'package:ota/core_pack/graphql/status_codes.dart';
import 'package:ota/domain/tickets/details/models/ticket_details_model.dart';
import 'package:ota/domain/tickets/details/usecases/ticket_details_usecase.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_argument.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_view_model.dart';

class TicketDetailBloc extends Bloc<TicketDetailViewModel> {
  @override
  TicketDetailViewModel initDefaultValue() {
    return TicketDetailViewModel(
        pageState: TicketDetailScreenPageState.initial);
  }

  Future<void> getTicketDetail(
      TicketDetailArgument? argument, bool isRefresh) async {
    if (argument == null) {
      emit(TicketDetailViewModel(
          pageState: TicketDetailScreenPageState.failure));
      return;
    }
    if (!isRefresh) {
      emit(TicketDetailViewModel(
          pageState: TicketDetailScreenPageState.loading));
    }
    TicketDetailsUseCasesImpl ticketDetailsUseCasesImpl =
        TicketDetailsUseCasesImpl();
    await mapTicketDetail(ticketDetailsUseCasesImpl, argument, isRefresh);
  }

  Future<void> mapTicketDetail(
      TicketDetailsUseCasesImpl ticketDetailsUseCasesImpl,
      TicketDetailArgument argument,
      bool isRefresh) async {
    Either<Failure, TicketDetail>? result = await ticketDetailsUseCasesImpl
        .getTicketDetails(argument.toTicketDomainArgument());
    if (result?.isRight ?? false) {
      TicketDetail ticketData = result!.right;
      String? statusCode = ticketData.getTicketDetails?.status?.code;
      if (statusCode == kErrorCode1899) {
        emit(TicketDetailViewModel(
            pageState: TicketDetailScreenPageState.failure1899));
      } else if (statusCode == kErrorCode1999) {
        emit(TicketDetailViewModel(
            pageState: TicketDetailScreenPageState.failure1999));
      } else if (statusCode == kSuccessCode) {
        Ticket? ticketDetail = ticketData.getTicketDetails?.data?.ticket;
        List<TicketDetailPromotionList>? promotionList =
            ticketData.getTicketDetails?.data?.promotionList ?? [];
        if (ticketDetail != null) {
          emit(TicketDetailViewModel(
              pageState: TicketDetailScreenPageState.success,
              data: TicketDetailModel.mapFromTicketDetail(
                  ticketDetail, argument, promotionList)));
        } else {
          emit(TicketDetailViewModel(
              pageState: TicketDetailScreenPageState.failure));
        }
      } else {
        emit(TicketDetailViewModel(
            pageState: TicketDetailScreenPageState.failure));
      }
    } else if (result?.left is InternetFailure) {
      emit(TicketDetailViewModel(
          pageState: TicketDetailScreenPageState.internetFailure));
    } else {
      emit(TicketDetailViewModel(
          pageState: TicketDetailScreenPageState.failure));
    }
  }

  bool get isPackageEmpty => packages.isEmpty;

  List<TicketPackage> get packages => state.data?.packages ?? [];
}
