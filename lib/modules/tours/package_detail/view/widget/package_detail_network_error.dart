import 'package:flutter/cupertino.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_no_result_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double _kTopPadding = 24;
const String _kNetworkImageUrl = "assets/images/icons/network_error_image.svg";

class PackageDetailErrorWidget extends StatelessWidget {
  final double height;
  const PackageDetailErrorWidget({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: height - _kTopPadding,
          child: OtaSearchNoResultWidget(
            imageUrl: _kNetworkImageUrl,
            errorTextHeader: getTranslated(
              context,
              AppLocalizationsStrings.infoNotAvailable,
            ),
            errorTextFooter: getTranslated(
              context,
              AppLocalizationsStrings.pleasePullToRefresh,
            ),
            paddingHeight: kSize8,
          ),
        )
      ],
    );
  }
}
