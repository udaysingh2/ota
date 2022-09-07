import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/helper.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/facility_helper.dart';
import 'package:ota/modules/tickets/confirm_booking/bloc/ticket_confirm_booking_expand_bloc.dart';
import 'package:ota/modules/tickets/confirm_booking/view_model/ticket_confirm_booking_model.dart';

const String _kPlaceholderImage =
    'assets/images/icons/suggetion_card_palceholder.svg';
const int _kDefaultMaxLines = 1;
const int _kMaxTwoLines = 2;
const double _kHeadLineHeight = 1.25;
const String _kUpArrow = "assets/images/icons/arrow_up.svg";
const String _kDownArrow = "assets/images/icons/arrow_down.svg";

class TicketConfirmBookingReviewInfo extends StatelessWidget {
  final String ticketName;
  final String packageName;
  final DateTime bookingDate;
  final List<TicketTypeViewModel> ticketTypeList;
  final TicketConfirmBookingExpandBloc ticketConfirmBookingExpandBloc;
  final String? cancellationHeader;
  final String? imageUrl;
  final String? startTime;
  final List<TicketHighlightViewModel>? facilityMap;
  final String? noOfDays;

  const TicketConfirmBookingReviewInfo({
    Key? key,
    required this.ticketName,
    required this.packageName,
    required this.bookingDate,
    required this.ticketTypeList,
    required this.ticketConfirmBookingExpandBloc,
    this.cancellationHeader,
    this.imageUrl,
    this.startTime,
    this.facilityMap,
    this.noOfDays,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: kSize44,
                height: kSize44,
                child: imageUrl != null
                    ? _getImageCard()
                    : _getDefaultImage(context),
              ),
              const SizedBox(width: kSize16),
              Expanded(
                child: BlocBuilder(
                    bloc: ticketConfirmBookingExpandBloc,
                    builder: () {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _getInfo(
                            ticketName,
                            AppTheme.kBodyMedium
                                .copyWith(height: _kHeadLineHeight),
                            maxLines: _kMaxTwoLines,
                          ),
                          _getInfo(
                            packageName,
                            AppTheme.kSmallRegular.copyWith(
                              color: AppColors.kGrey50,
                            ),
                            maxLines: _kMaxTwoLines,
                          ),
                          if (ticketConfirmBookingExpandBloc.state ==
                              TicketConfirmBookingMinMaxState.isExpanded)
                            ...getListOfWidget(context),
                          if (ticketConfirmBookingExpandBloc.state ==
                              TicketConfirmBookingMinMaxState.isCollapsed)
                            ..._getOnCollapseInfo(context),
                        ],
                      );
                    }),
              ),
              const SizedBox(width: kSize16),
              InkWell(
                key: const Key("ticketPaymentCollapseExpandKey"),
                onTap: () {
                  ticketConfirmBookingExpandBloc.toggle();
                },
                child: SizedBox(
                  width: kSize20,
                  height: kSize20,
                  child: BlocBuilder(
                      bloc: ticketConfirmBookingExpandBloc,
                      builder: () {
                        return SvgPicture.asset(
                          (ticketConfirmBookingExpandBloc.state ==
                                  TicketConfirmBookingMinMaxState.isExpanded)
                              ? _kUpArrow
                              : _kDownArrow,
                        );
                      }),
                ),
              ),
            ],
          ),
          BlocBuilder(
            bloc: ticketConfirmBookingExpandBloc,
            builder: () {
              if (ticketConfirmBookingExpandBloc.state ==
                  TicketConfirmBookingMinMaxState.isExpanded) {
                return Column(
                  children: _getTicketList(context),
                );
              }
              return const SizedBox(
                height: kSize16,
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _getTicketList(BuildContext context) {
    List<Widget> ticketList = [];
    for (TicketTypeViewModel ticket in ticketTypeList) {
      if (ticket.noOfTickets > 0) {
        ticketList.add(const SizedBox(height: kSize16));
        ticketList.add(_getTicketPrice(context, ticket));
      }
    }
    return ticketList;
  }

  List<Widget> _getOnCollapseInfo(BuildContext context) {
    List<Widget> infoList = [];

    if (noOfDays != null && noOfDays!.isNotEmpty) {
      infoList.add(_getInfo(
          (noOfDays!.addTrailingSpace() +
              getTranslated(context, AppLocalizationsStrings.days)),
          AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50)));
    }
    infoList.add(_getInfo(_getDateTime(),
        AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50)));

    if (cancellationHeader != null && cancellationHeader!.isNotEmpty) {
      infoList.add(_getInfo(cancellationHeader!, AppTheme.kSmallRegular));
    }
    return infoList;
  }

  List<Widget> getListOfWidget(BuildContext context) {
    return [
      const SizedBox(height: kSize8),
      _getFacilityView(context, facilityMap),
    ];
  }

  Widget _getImageCard() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
      child: CachedNetworkImage(
          imageUrl: imageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          errorWidget: (context, url, error) => _getDefaultImage(context),
          placeholder: (context, url) => _getDefaultImage(context)),
    );
  }

  Widget _getDefaultImage(BuildContext context) {
    return SvgPicture.asset(_kPlaceholderImage,
        fit: BoxFit.cover, width: MediaQuery.of(context).size.width - kSize48);
  }

  Widget _getInfo(String name, TextStyle? textStyle, {int? maxLines}) {
    return Text(
      name,
      style: textStyle,
      maxLines: maxLines ?? _kDefaultMaxLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getTicketPrice(BuildContext context, TicketTypeViewModel ticket) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(ticket.name, style: AppTheme.kBodyRegular),
        _getPrice(context, ticket.price),
      ],
    );
  }

  String _getDateTime() {
    return Helpers.getwwddMMMyy(bookingDate).addTrailingComma() +
        (startTime ?? "");
  }

  Widget _getPrice(BuildContext context, double price) {
    CurrencyUtil currencyUtil = CurrencyUtil();
    return Align(
        alignment: Alignment.centerRight,
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: currencyUtil.getFormattedPrice(price).addTrailingSpace(),
                style: AppTheme.kRichTextStyle(AppTheme.kBodyMedium)),
            TextSpan(
                text: getTranslated(
                        context, AppLocalizationsStrings.perTicketPriceLabel)
                    .addLeadingSlash(),
                style: AppTheme.kRichTextStyle(AppTheme.kBodyRegularGrey50)),
          ]),
        ));
  }

  Widget _getFacilityView(
      BuildContext context, List<TicketHighlightViewModel>? facilityMap) {
    return Column(
      children: _getFacilityList(context, facilityMap),
    );
  }

  List<Widget> _getFacilityList(
      BuildContext context, List<TicketHighlightViewModel>? facilityMap) {
    List<Widget> facilityList = [];
    if (facilityMap != null && facilityMap.isNotEmpty) {
      for (TicketHighlightViewModel facility in facilityMap) {
        if (facility.value != null) {
          facilityList.add(_getService(facility.key!, facility.value!));
          facilityList.add(const SizedBox(
            height: kSize4,
          ));
        }
      }
    }
    return facilityList;
  }

  Widget _getService(String assetId, String offerId) {
    String imageName = FacilityHelper.getAssetName(assetId);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          imageName,
          width: kSize16,
          height: kSize16,
          color: AppColors.kGrey70,
        ),
        const SizedBox(
          width: kSize4,
        ),
        Expanded(
          child: Text(
            offerId,
            maxLines: _kDefaultMaxLines,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.kSmallRegular,
          ),
        ),
      ],
    );
  }
}
