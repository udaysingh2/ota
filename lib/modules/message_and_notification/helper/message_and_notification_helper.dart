const String _kAnnouncement = "ANNOUNCEMENT";
const String _kPromotion = "PROMOTION";
const String _kEreceipt = "E_RECEIPT";

class MessageAndNotificationHelper {
  static String getSvgType(String category) {
    switch (category) {
      case _kAnnouncement:
        return "assets/images/icons/annoucement.svg";
      case _kPromotion:
        return "assets/images/icons/promotion.svg";
      case _kEreceipt:
        return "assets/images/icons/ereceipts.svg";
      default:
        return "assets/images/icons/promotion.svg";
    }
  }

  static String getSvg(String category) {
    switch (category) {
      case _kAnnouncement:
        return "assets/images/icons/annoucement_without_border.svg";
      case _kPromotion:
        return "assets/images/icons/promotion_without_border.svg";
      default:
        return "assets/images/icons/promotion_without_border.svg";
    }
  }
}
