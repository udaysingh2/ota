import 'package:flutter/cupertino.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_search_no_result_widget.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double _kTopPadding = 24;
const String _networkErrorImage = "assets/images/icons/search_empty_error.svg";

class FavoritesNetworkErrorWidget extends StatelessWidget {
  final double height;
  const FavoritesNetworkErrorWidget({Key? key, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: height - _kTopPadding,
          child: OtaSearchNoResultWidget(
            imageUrl: _networkErrorImage,
            errorTextHeader: getTranslated(
              context,
              AppLocalizationsStrings.sorry,
            ),
            errorTextFooter: getTranslated(
              context,
              AppLocalizationsStrings.informationNotAvialable,
            ),
            paddingHeight: kSize8,
          ),
        )
      ],
    );
  }
}
