import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/helpers/print_helper.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/landing/bloc/preference_popup_bloc.dart';
import 'package:ota/modules/landing/helper/landing_page_helper.dart';
import 'package:ota/modules/landing/view/widgets/popup_widget/popup_controller.dart';
import 'package:ota/modules/landing/view/widgets/popup_widget/popup_model.dart';
import 'package:ota/modules/landing/view/widgets/popup_widget/popup_radio_button.dart';
import 'package:ota/modules/landing/view_model/popup_view_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

const String _kcrossUrl = "assets/images/icons/cross.svg";
const _kDelayDuration = Duration(milliseconds: 500);

class PopupDialog extends StatefulWidget {
  final PopupDataModel popupViewModel;
  const PopupDialog({Key? key, required this.popupViewModel}) : super(key: key);

  @override
  PopupDialogState createState() => PopupDialogState();
}

class PopupDialogState extends State<PopupDialog> {
  final PopupController controller = PopupController();
  final PreferencePopUpBloc bloc = PreferencePopUpBloc();

  bool _isVisible = true;
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: controller,
        builder: () {
          printDebug(controller.state);
          return AnimatedOpacity(
            opacity: controller.isLoaded() ? kSize1 : kSize0,
            duration: _kDelayDuration,
            child: Offstage(
              offstage: controller.state == PopupModelState.loaded
                  ? !_isVisible
                  : _isVisible,
              child: Container(
                padding: kPaddingHori24,
                color: AppColors.kBlackOpacity40,
                child: SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _getCrossIcon(context),
                        const SizedBox(
                          height: kSize4,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(kSize12),
                                  topRight: Radius.circular(kSize12)),
                              child: GestureDetector(
                                key: const Key("deepLinkUrl"),
                                onTap: () {
                                  _openDeepLinkUrl(
                                      widget.popupViewModel.deepLinkUrl);
                                },
                                child: CachedNetworkImage(
                                  imageUrl: widget.popupViewModel.imageUrl,
                                  fit: BoxFit.cover,
                                  imageBuilder: (context, imageProvider) {
                                    controller.setAsLoaded();
                                    return Image(image: imageProvider);
                                  },
                                ),
                              ),
                            ),
                            _getBottomRadioButton(context)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _openDeepLinkUrl(String? url) async {
    if (url != null && await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  Widget _getCrossIcon(BuildContext context) {
    return Container(
        color: Colors.transparent,
        alignment: Alignment.centerRight,
        child: OtaIconButton(
            key: const Key("closeButton"),
            icon: SvgPicture.asset(
              _kcrossUrl,
              color: AppColors.kLight100,
            ),
            height: kSize32,
            width: kSize32,
            onTap: () async {
              bloc.updatePopUpState(
                  widget.popupViewModel.id,
                  LandingPageHelper.getIntentType(_isSelected),
                  widget.popupViewModel.endDate);
              setState(() {
                controller.setAsClosed();
                _isVisible = !_isVisible;
              });
            }));
  }

  Widget _getBottomRadioButton(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(kSize12),
            bottomRight: Radius.circular(kSize12)),
      ),
      child: Center(
        child: Material(
          child: PopUpRadioButton(
            onClicked: () {
              setState(() {
                _isSelected = !_isSelected;
              });
            },
            label:
                getTranslated(context, AppLocalizationsStrings.doNotShowAgain),
            isSelected: _isSelected,
          ),
        ),
      ),
    );
  }
}
