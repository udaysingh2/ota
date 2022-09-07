import 'package:ota/domain/tickets/details/models/ticket_details_model.dart';
import 'package:ota/modules/tickets/details/view_model/ticket_detail_view_model.dart';

const int _kDefaultMinTicketCount = 1;
const double _kDefaultDouble = 0;
const int _kDefaultInt = 0;
const List<TicketTypes> _kTicketTypeList = [];

class TicketBookingCalendarViewModel {
  TicketPackageModel ticketPackageModel;
  TicketBookingCalendarState ticketBookingCalendarState;

  TicketBookingCalendarViewModel({
    required this.ticketPackageModel,
    this.ticketBookingCalendarState = TicketBookingCalendarState.none,
  });
}

class TicketPackageModel {
  String packageName;
  List<TicketTypes> ticketTypes;
  double totalPrice;
  int availableSeats;

  TicketPackageModel({
    this.packageName = '',
    this.ticketTypes = _kTicketTypeList,
    this.totalPrice = _kDefaultDouble,
    this.availableSeats = _kDefaultInt,
  });

  factory TicketPackageModel.fromTicketPackage(Package package) {
    return TicketPackageModel(
      packageName: package.name ?? '',
      ticketTypes: List.generate(
        package.ticketTypes?.length ?? 0,
        (index) => TicketTypes.mapFromTicketType(
            package.ticketTypes!.elementAt(index), index),
      ),
      totalPrice: package.ticketTypes!.first.price!,
      availableSeats: package.availableSeats!,
    );
  }
}

class TicketTypes {
  String name;
  String paxId;
  double price;
  int minimum;
  int available;
  int ticketCount;

  TicketTypes({
    this.name = '',
    this.paxId = '',
    this.price = _kDefaultDouble,
    this.minimum = _kDefaultInt,
    this.available = _kDefaultInt,
    this.ticketCount = _kDefaultInt,
  });

  factory TicketTypes.mapFromTicketType(TicketType ticketType, int index) {
    return TicketTypes(
      name: ticketType.name!,
      price: ticketType.price!,
      minimum: ticketType.minimum!,
      available: ticketType.available!,
      paxId: ticketType.paxId!,
      ticketCount: index == 0 ? _kDefaultMinTicketCount : _kDefaultInt,
    );
  }

  factory TicketTypes.mapFromTicketTypeData(
      TicketTypeData ticketType, int index) {
    return TicketTypes(
      name: ticketType.name!,
      price: ticketType.price!,
      minimum: ticketType.minimum!,
      available: ticketType.available!,
      paxId: ticketType.paxId!,
      ticketCount: index == 0 ? _kDefaultMinTicketCount : _kDefaultInt,
    );
  }
}

enum TicketBookingCalendarState {
  none,
  initial,
  success,
  noTickets,
  ticketsSoldOut,
  failure,
  failureNetwork,
  failure1899,
  failure1999,
}
