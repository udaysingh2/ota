import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_app_bar.dart';
import 'package:ota/core_pack/custom_widgets/ota_gallery_detail_placeholder.dart';
import 'package:ota/modules/room_gallery/view_model/room_gallery_view_model.dart';
import 'package:photo_view/photo_view.dart';

const _kSwipeDuration = Duration(milliseconds: 400);
const _kMaxScale = 2.0;
const _kOpacity = 0.4;
const _kAnimationDuration = 225;
const int _defaultPage = 0;

class HotelRoomGalleryDetailScreen extends StatefulWidget {
  final List<RoomGalleryModel>? imageList;
  final int initialPage;

  const HotelRoomGalleryDetailScreen({
    Key? key,
    this.imageList,
    this.initialPage = _defaultPage,
  }) : super(key: key);
  @override
  HotelRoomGalleryDetailScreenState createState() =>
      HotelRoomGalleryDetailScreenState();
}

class HotelRoomGalleryDetailScreenState
    extends State<HotelRoomGalleryDetailScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  PageController? _pageController;

  int _currentPage = _defaultPage;
  bool _shouldScroll = true;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage);
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: _kAnimationDuration))
      ..addListener(() {
        setState(() {});
      });
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!);
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  Future<bool> reverseAnimation() async {
    return _animationController!.reverse().then((value) => true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: reverseAnimation,
      child: Opacity(
        opacity: _animation!.value,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: OtaAppBar(
            backgroundColor: Colors.transparent,
            actions: const [OtaAppBarAction.closeButton],
            onCloseButtonPressed: () async {
              await Navigator.of(context).maybePop();
            },
          ),
          backgroundColor: Colors.black.withOpacity(_kOpacity),
          body: ScaleTransition(
            scale: _animation!,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildPageViewBuilder(_pageController!),
                _buildArrowControlView(_pageController!),
                _buildPageCountView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoView(String imageUrl) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => const OtaGalleryDetailPlaceholder(),
        errorWidget: (context, url, error) => const OtaGalleryDetailPlaceholder(
              isError: true,
            ),
        imageBuilder: (context, imageProvider) {
          return PhotoView(
            backgroundDecoration:
                const BoxDecoration(color: Colors.transparent),
            imageProvider: imageProvider,
            filterQuality: FilterQuality.medium,
            maxScale: _kMaxScale,
            minScale: PhotoViewComputedScale.contained,
            scaleStateChangedCallback: (value) {
              setState(() {
                _shouldScroll = value == PhotoViewScaleState.initial;
              });
            },
          );
        });
  }

  Widget _buildPageCountView() {
    final countText = widget.imageList!.isNotEmpty
        ? '${_currentPage + 1}/${widget.imageList!.length}'
        : '';
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: kSize24),
      child: Text(
        countText,
        style: AppTheme.kHeadline2.copyWith(fontSize: kSize16),
      ),
    );
  }

  Widget _buildArrowControlView(PageController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _currentPage != 0
            ? _buildArrowIcon(true, controller)
            : const SizedBox(),
        widget.imageList!.isNotEmpty &&
                _currentPage != (widget.imageList!.length - 1)
            ? _buildArrowIcon(false, controller)
            : const SizedBox(),
      ],
    );
  }

  Widget _buildArrowIcon(bool isLeftArrow, PageController controller) {
    return IconButton(
      key: isLeftArrow ? const Key("left_icon") : const Key("right_icon"),
      icon: Icon(
        isLeftArrow
            ? Icons.keyboard_arrow_left_outlined
            : Icons.keyboard_arrow_right_outlined,
        color: AppColors.kLight100,
        size: kSize24,
      ),
      onPressed: () => {
        isLeftArrow
            ? controller.previousPage(
                duration: _kSwipeDuration, curve: Curves.easeOut)
            : controller.nextPage(
                duration: _kSwipeDuration, curve: Curves.easeIn),
      },
    );
  }

  Widget _buildPageViewBuilder(PageController controller) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      physics: _shouldScroll
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      controller: controller,
      itemBuilder: (context, position) {
        return _buildPhotoView(widget.imageList![position].imageUrl);
      },
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
      itemCount: widget.imageList!.length,
    );
  }
}
