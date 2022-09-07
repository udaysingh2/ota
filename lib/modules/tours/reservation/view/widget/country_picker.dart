import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';

const int _kMaxLines = 1;

class CountryPicker extends StatelessWidget {
  final List<String> countriesName;
  final String screenTitle;
  final String? selectedCountry;
  const CountryPicker({
    Key? key,
    required this.countriesName,
    required this.screenTitle,
    this.selectedCountry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: kSize4,
          width: kSize58,
          margin: const EdgeInsets.only(bottom: kSize4, top: kSize46),
          decoration: BoxDecoration(
            color: AppColors.kWhiteColor,
            borderRadius: BorderRadius.circular(kSize2),
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.kWhiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kSize24),
                topRight: Radius.circular(kSize24),
              ),
            ),
            child: Column(
              children: [
                _buildHeaderView(context),
                const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
                _buildCountryView(context),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildHeaderView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kSize18),
      child: Row(
        children: [
          OtaIconButton(
            icon: const Icon(
              Icons.close_rounded,
              size: kSize20,
            ),
            onTap: () => Navigator.pop(context),
          ),
          Expanded(
            child: Text(
              screenTitle,
              style: AppTheme.kHeading1,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: kSize40)
        ],
      ),
    );
  }

  Widget _buildCountryView(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        thumbVisibility: true,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: kSize24),
          itemCount: countriesName.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context, countriesName[index]),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: kSize16),
                      child: Text(
                        countriesName[index],
                        overflow: TextOverflow.ellipsis,
                        maxLines: _kMaxLines,
                        style: AppTheme.kBody,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
              ],
            );
          },
        ),
      ),
    );
  }
}
