import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core/app_routes.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/modules/landing/view/widgets/progress_indicator/ota_dot_progess_bloc.dart';
import 'package:ota/modules/landing/view/widgets/progress_indicator/ota_dot_progress_indicator.dart';
import 'package:ota/modules/landing/view_model/banner_view_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

double _kPixelValue = 0;
const double _kScreenConst = 0.4;
const String _kPlaceHolderBanner = "assets/images/icons/banner_placeholder.svg";

class BannerWidget extends StatelessWidget {
  final List<BannerDataModel> bannerList;
  final OtaProgressBloc otaProgressBloc = OtaProgressBloc();
  final bool launchBannerInApp;
  final ScrollController scrollController = ScrollController();
  final Function(int index)? onBannerTap;

  BannerWidget(
      {Key? key,
      required this.bannerList,
      required this.launchBannerInApp,
      required this.onBannerTap})
      : super(key: key) {
    scrollController.addListener(() {
      _kPixelValue =
          (scrollController.position.pixels / kSize328) + _kScreenConst;
      otaProgressBloc.setSelected(_kPixelValue.floor());
    });
  }
  void _launchDeepLinkUrl(String? url, BuildContext context) {
    if (url != null && url.isNotEmpty) {
      if (launchBannerInApp) {
        Navigator.pushNamed(context, AppRoutes.webViewScreen, arguments: url);
      } else {
        _openDeepLinkUrl(url);
      }
    }
  }

  void _openDeepLinkUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: kSize8),
            height: kSize80,
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowIndicator();
                return true;
              },
              child: ListView.separated(
                controller: scrollController,
                itemCount: bannerList.length,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: kSize24),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    key: const Key("banner"),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(kSize12)),
                    onTap: () {
                      onBannerTap!(index);
                      _launchDeepLinkUrl(
                          bannerList[index].deepLinkUrl, context);
                    },
                    child: Ink(
                      height: kSize80,
                      width: kSize328,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(kSize12)),
                        child: CachedNetworkImage(
                          imageUrl: bannerList[index].imageUrl,
                          placeholder: (context, url) =>
                              SvgPicture.asset(_kPlaceHolderBanner),
                          errorWidget: (context, url, error) =>
                              SvgPicture.asset(_kPlaceHolderBanner),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: kSize16);
                },
              ),
            ),
          ),
          BlocBuilder(
              bloc: otaProgressBloc,
              builder: () {
                return OtaProgressDot(
                  numberOfDots: bannerList.length,
                  onIndex: otaProgressBloc.getSelectedIndex(),
                );
              })
        ],
      ),
    );
  }
}
