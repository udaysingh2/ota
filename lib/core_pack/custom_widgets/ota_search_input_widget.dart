import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';

const double _kIconPadding = 5.6;
const double _kLoaderWidth = 2.5;
const double _kTextBoxHeight = 40.0;

const int _kMaxLine = 1;
const String _kSearchIconPath = "assets/images/icons/feather_search.svg";
const String _kCloseIconPath = "assets/images/icons/close.svg";
const String _searchFormatter = r"[A-Za-z\u0E00-\u0E7F0-9-'’#&()@ *:,./ ]";

class OtaSearchInputWidget extends StatefulWidget {
  final String searchHintText;
  final TextEditingController searchTextController;
  final FocusNode focusNode;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onCrossButtonTap;
  final Function()? onTextFieldTap;
  final bool isEditingEnabled;
  final bool isLoading;

  const OtaSearchInputWidget({
    Key? key,
    required this.searchHintText,
    required this.searchTextController,
    required this.onChanged,
    required this.focusNode,
    this.onCrossButtonTap,
    this.onTextFieldTap,
    this.isEditingEnabled = true,
    this.isLoading = false,
    this.onSubmitted,
  }) : super(key: key);

  @override
  State<OtaSearchInputWidget> createState() => _OtaSearchInputWidgetState();
}

class _OtaSearchInputWidgetState extends State<OtaSearchInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kTextBoxHeight,
      padding: const EdgeInsets.only(left: kSize12),
      margin: const EdgeInsets.symmetric(horizontal: kSize24, vertical: kSize8),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(kSize8)),
        color: AppColors.kGrey4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTextField(),
          _buildProgressIndicator(),
          _getSearchBarTrailingIcon(),
        ],
      ),
    );
  }

  Widget _getSearchBarTrailingIcon() {
    if (widget.searchTextController.text.trim().isEmpty) {
      return _buildSearchIcon();
    }
    return _buildCrossButton();
  }

  Widget _buildSearchIcon() {
    return Padding(
      padding: const EdgeInsets.only(right: _kIconPadding),
      child: SvgPicture.asset(
        _kSearchIconPath,
        height: kSize20,
        width: kSize16,
        color: AppColors.kGrey20,
      ),
    );
  }

  Widget _buildTextField() {
    return Expanded(
      child: TextField(
        enabled: widget.isEditingEnabled,
        focusNode: widget.focusNode,
        controller: widget.searchTextController,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey20),
          fillColor: AppColors.kGrey4,
          hintText: widget.searchHintText,
          isCollapsed: true,
        ),
        maxLines: _kMaxLine,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(_searchFormatter),
          ),
        ],
        onTap: widget.onTextFieldTap,
        style: AppTheme.kBodyRegular,
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }

  Widget _buildCrossButton() {
    return OtaIconButton(
      icon: Center(
        child: SvgPicture.asset(
          _kCloseIconPath,
          color: AppColors.kGrey20,
          height: kSize16,
          width: kSize16,
        ),
      ),
      onTap: widget.onCrossButtonTap,
    );
  }

  Widget _buildProgressIndicator() {
    return Offstage(
      offstage: !widget.isLoading,
      child: const SizedBox(
        height: kSize16,
        width: kSize16,
        child: CircularProgressIndicator(strokeWidth: _kLoaderWidth),
      ),
    );
  }
}
