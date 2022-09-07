import 'package:flutter/material.dart';
import 'package:ota/modules/room_gallery/view/gallery_details/hotel_room_gallery_detail_screen.dart';
import 'package:ota/modules/room_gallery/view_model/room_gallery_view_model.dart';

const int _defaultPage = 0;

class HotelRoomOverlayImageViewer extends PopupRoute<void> {
  final List<RoomGalleryModel> imageList;
  final int initialPage;

  HotelRoomOverlayImageViewer({
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
    return HotelRoomGalleryDetailScreen(
      imageList: imageList,
      initialPage: initialPage,
    );
  }
}
