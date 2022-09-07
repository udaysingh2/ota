import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/modules/tours/landing/view_model/service_card_view_model.dart';

const _kServiceCardImageKey = 'service_card_image_key';
const _kPlaceholderImage = 'assets/images/icons/suggetion_card_palceholder.svg';

class ServiceCardsWidget extends StatelessWidget {
  final ServiceCardModel? tourService;
  final ServiceCardModel? ticketService;
  final Function()? onTourServicePress;
  final Function()? onTicketServicePress;

  const ServiceCardsWidget({
    Key? key,
    this.tourService,
    this.ticketService,
    this.onTourServicePress,
    this.onTicketServicePress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageSize =
        (MediaQuery.of(context).size.width - (2 * kSize24) - kSize7_5) / 2;
    return _buildServiceCardsWidget(imageSize);
  }

  Widget _buildServiceCardsWidget(double imageSize) {
    List<Widget> widgetList = [];
    if (tourService != null && ticketService != null) {
      if (tourService!.sortSequence == 1) {
        widgetList.insert(0, _buildServiceCard(tourService!, imageSize, true));
        widgetList.insert(1, const SizedBox(width: kSize7_5));
        widgetList.insert(
            2, _buildServiceCard(ticketService!, imageSize, false));
      } else {
        widgetList.insert(
            0, _buildServiceCard(ticketService!, imageSize, false));
        widgetList.insert(1, const SizedBox(width: kSize7_5));
        widgetList.insert(2, _buildServiceCard(tourService!, imageSize, true));
      }
    } else if (ticketService != null) {
      widgetList.insert(0, _buildServiceCard(ticketService!, imageSize, false));
    } else if (tourService != null) {
      widgetList.insert(0, _buildServiceCard(tourService!, imageSize, true));
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(kSize24, kSize24, kSize24, kSize0),
      child: Row(children: widgetList),
    );
  }

  Widget _buildServiceCard(
      ServiceCardModel serviceCardModel, double imageSize, bool isTourService) {
    return InkWell(
      borderRadius: kBorderRad12,
      onTap: isTourService ? onTourServicePress : onTicketServicePress,
      child: SizedBox(
        width: imageSize,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  key: const Key(_kServiceCardImageKey),
                  borderRadius: kBorderRad12,
                  child: serviceCardModel.imageUrl != null &&
                          serviceCardModel.imageUrl!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: serviceCardModel.imageUrl!,
                          fit: BoxFit.cover,
                          height: imageSize,
                          width: imageSize,
                          errorWidget: (context, url, error) =>
                              _buildPlaceHolderImage(),
                          placeholder: (context, url) =>
                              _buildPlaceHolderImage())
                      : _buildPlaceHolderImage(),
                ),
                if (serviceCardModel.imageTitle != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kSize2),
                    child: Text(
                      serviceCardModel.imageTitle!,
                      style: AppTheme.kHeading1Medium.copyWith(color: AppColors.kLight100),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: kSize4),
            Text(
              serviceCardModel.title!,
              style: AppTheme.kBodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              serviceCardModel.description!,
              style: AppTheme.kSmallRegular.copyWith(color: AppColors.kGrey50),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceHolderImage() {
    return SvgPicture.asset(_kPlaceholderImage, fit: BoxFit.cover);
  }
}
