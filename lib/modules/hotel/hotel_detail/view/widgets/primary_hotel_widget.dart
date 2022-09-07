import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/common/utils/currency_code.dart';
import 'package:ota/common/utils/string_extension.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/hotel/hotel_detail/helpers/room_helper.dart';
import 'package:ota/modules/hotel/hotel_detail/view/widgets/secondary_hotel_widget.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/argument_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/primary_view_model.dart';
import 'package:ota/modules/hotel/hotel_detail/view_model/secondary_view_model.dart';

const int _kMaxRoomName = 2;
const _kImagePlaceholder = 'assets/images/icons/suggetion_card_palceholder.svg';
const double _kPriceAlign = 36;
const int _kMaxLines = 1;

class PrimaryHotelView extends StatefulWidget {
  final PrimaryViewModel primaryViewModel;
  const PrimaryHotelView({Key? key, required this.primaryViewModel})
      : super(key: key);

  @override
  PrimaryHotelViewState createState() => PrimaryHotelViewState();
}

class PrimaryHotelViewState extends State<PrimaryHotelView> {
  bool isExpanded = false;
  @override
  void initState() {
    if (widget.primaryViewModel.secondaryViewState ==
        SecondaryViewState.expanded) {
      isExpanded = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kSize16),
        if (widget.primaryViewModel.imageUrl.isNotEmpty)
          Padding(
            padding: kPaddingHori24,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
                child: _buildImage()),
          ),
        IgnorePointer(
          ignoring: _isSecondaryRoomAvailable(),
          child: Container(
            padding: kPaddingHori8,
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: (widget.primaryViewModel.secondaryViewState ==
                      SecondaryViewState.initial)
                  ? FutureBuilder<List<Widget>>(
                      future: getChildren(),
                      builder: (context, snapshot) {
                        return getExpansionTile((snapshot.data ?? []));
                      },
                    )
                  : getExpansionTile(
                      _secondaryRoomComputer(widget.primaryViewModel.children)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getDefaultImage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width - kSize48,
      child: SvgPicture.asset(
        _kImagePlaceholder,
        height: kSize152,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildImage() {
    return CachedNetworkImage(
        imageUrl: widget.primaryViewModel.imageUrl,
        fit: BoxFit.cover,
        height: kSize152,
        width: MediaQuery.of(context).size.width - kSize48,
        errorWidget: (context, url, error) => _getDefaultImage(),
        placeholder: (context, url) => _getDefaultImage());
  }

  Widget getExpansionTile(List<Widget> child) {
    return Column(
      children: [
        ExpansionTile(
          maintainState: true,
          title: _getTitle(),
          initiallyExpanded: isExpanded,
          tilePadding: const EdgeInsets.symmetric(horizontal: kSize16),
          trailing: _getTrailing(),
          onExpansionChanged: (value) {
            setState(() {
              isExpanded = value;
              if (value) {
                widget.primaryViewModel.secondaryViewState =
                    SecondaryViewState.expanded;
              } else {
                widget.primaryViewModel.secondaryViewState =
                    SecondaryViewState.collapsed;
              }
            });
          },
          children: child,
        ),
        const Padding(
          padding: kPaddingHori16,
          child: OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        ),
      ],
    );
  }

  Future<List<Widget>> getChildren() async {
    final res =
        await compute(_secondaryRoomComputer, widget.primaryViewModel.children);
    return res;
  }

  Widget _getTrailing() {
    return Container(
      transform:
          Matrix4.translationValues(Offset.zero.dx, -kSize8, Offset.zero.dy),
      child: _isSecondaryRoomAvailable()
          ? const SizedBox.shrink()
          : isExpanded
              ? SvgPicture.asset("assets/images/icons/arrow_up.svg")
              : SvgPicture.asset("assets/images/icons/arrow_down.svg"),
    );
  }

  Widget _getTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: kSize12, top: kSize4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getRoomTypeInfo(),
          const SizedBox(
            height: kSize8,
          ),
          _getRoomFeatures(),
          if (!isExpanded)
            const SizedBox(
              height: kSize8,
            ),
          if (!isExpanded) _getRoomPriceInfo(),
        ],
      ),
    );
  }

  Widget _getRoomFeatures() {
    List<FacilityViewModel> facilitiesList =
        widget.primaryViewModel.facilitiesList;
    return ListView.separated(
      itemCount: facilitiesList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: kPaddingVert0,
      itemBuilder: (context, index) {
        return RoomHelper.getName(facilitiesList[index], context,
                    widget.primaryViewModel.children)
                .isNotEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                      RoomHelper.getSvgIcon(facilitiesList[index].key),
                      color: AppColors.kGrey70,
                      height: kSize20,
                      width: kSize20),
                  const SizedBox(width: kSize8),
                  Expanded(
                    child: Text(
                      RoomHelper.getName(facilitiesList[index], context,
                          widget.primaryViewModel.children),
                      style: AppTheme.kSmallRegular,
                      maxLines: _kMaxLines,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink();
      },
      separatorBuilder: (context, index) {
        return RoomHelper.getName(facilitiesList[index], context,
                    widget.primaryViewModel.children)
                .isNotEmpty
            ? const SizedBox(height: kSize8)
            : const SizedBox.shrink();
      },
    );
  }

  bool _isSecondaryRoomAvailable() {
    return widget.primaryViewModel.children.isEmpty;
  }

  Widget _getRoomTypeInfo() {
    return Text(
      widget.primaryViewModel.roomName,
      style: AppTheme.kBodyMedium,
      maxLines: _kMaxRoomName,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _getRoomPriceInfo() {
    HotelDetailArgument arguments =
        ModalRoute.of(context)?.settings.arguments as HotelDetailArgument;
    CurrencyUtil currencyUtil =
        CurrencyUtil(currency: arguments.currencyCode, decimalDigits: 2);
    return Container(
      transform: Matrix4.translationValues(
          _kPriceAlign, Offset.zero.dy, Offset.zero.dy),
      alignment: Alignment.centerRight,
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(
              text: getTranslated(context, AppLocalizationsStrings.start),
              style: AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey50),
            ),
            TextSpan(
              text: currencyUtil
                  .getFormattedPrice(widget.primaryViewModel.nightPrice)
                  .addLeadingSpace()
                  .addTrailingSpace(),
              style: AppTheme.kBodyMedium.copyWith(color: AppColors.kSecondary),
            ),
            TextSpan(
              text: getTranslated(context, AppLocalizationsStrings.night)
                  .addLeadingSlash(),
              style: AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey50),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> _secondaryRoomComputer(List<SecondaryViewModel> children) {
  List<Widget> secondaryRooms = [];
  for (int i = 0; i < children.length; i++) {
    secondaryRooms
        .add(SecondaryHotelView(secondaryViewModel: children.elementAt(i)));
  }
  return secondaryRooms;
}
