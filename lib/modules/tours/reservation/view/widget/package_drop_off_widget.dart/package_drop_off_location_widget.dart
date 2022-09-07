import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_drop_off_widget.dart/drop_off_option_controller.dart';
import 'package:ota/modules/tours/reservation/view/widget/package_drop_off_widget.dart/dropoff_bottom_sheet_widget.dart';
import 'package:ota/modules/tours/reservation/view_model/pickup_point_view_model.dart';

const String _dropDownWidget = "assets/images/icons/arrow_down.svg";

class PackageDropOffLocationWidget extends StatelessWidget {
  final EdgeInsets padding;
  final List<PickupPointData> labelList;
  final DropOffController dropOffController;
  const PackageDropOffLocationWidget({
    Key? key,
    this.padding = kPaddingHori24,
    required this.labelList,
    required this.dropOffController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kSize24),
          Text(
            getTranslated(context, AppLocalizationsStrings.pickUpPoint),
            style: AppTheme.kHeading1Medium,
          ),
          const SizedBox(height: kSize16),
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) {
                  return DropOffBottomSheetWidget(
                      selectedIndex: dropOffController.state.chosenOption == -1 ? 0 : dropOffController.state.chosenOption,
                      onPressed: (chosenOption) {
                        dropOffController.updateChosenOption(chosenOption);
                      },
                      title: getTranslated(
                          context, AppLocalizationsStrings.pickUpPointLabel),
                      labelList: labelList);
                },
              );
            },
            child: Ink(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(kSize8)),
                color: AppColors.kGrey4,
              ),
              child: BlocBuilder(
                bloc: dropOffController,
                builder: () {
                  return Padding(
                    padding: const EdgeInsets.all(kSize12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            dropOffController.state.chosenOption == -1
                                ? getTranslated(context,
                                    AppLocalizationsStrings.pickUpPointLabel)
                                : labelList[
                                        dropOffController.state.chosenOption]
                                    .name,
                            style: AppTheme.kBodyRegular,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        OtaIconButton(
                          icon: SvgPicture.asset(_dropDownWidget),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: kSize24),
          const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
        ],
      ),
    );
  }
}
