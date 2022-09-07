import 'package:flutter/material.dart';
import 'package:ota/modules/gallery/view/gallery_details/gallery_detail_screen.dart';
import 'package:ota/modules/gallery/view_model/gallery_view_model.dart';

const int _defaultPage = 0;

class OverlayImageViewer extends PopupRoute<void> {
  final List<GalleryViewModel> imageList;
  final int initialPage;

  OverlayImageViewer({
    required this.imageList,
    this.initialPage = _defaultPage,
  });

  @override
  Color get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => 'close';

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // return OtaFrostedTransition(
    //   animation: new Tween<double>(begin: 0, end: 10).animate(animation),
    //   child: child,
    // );
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return GalleryDetailScreen(
      imageList: imageList,
      initialPage: initialPage,
    );
  }
}
