import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';

const double _kIconPadding = 5.6;
const double _kLoaderWidth = 2.5;

const int _kMaxLine = 1;
const String _kSearchIconPath = "assets/images/icons/feather_search.svg";
const String _kCloseIconPath = "assets/images/icons/close.svg";
const String _searchFormatter = "[0-9a-zA-Z]";

class PromoSearchInputWidget extends StatefulWidget {
  final String searchHintText;
  final TextEditingController searchTextController;
  final FocusNode focusNode;
  //final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onCrossButtonTap;
  final Function()? onTextFieldTap;
  final bool isEditingEnabled;
  final bool isLoading;

  const PromoSearchInputWidget({
    Key? key,
    required this.searchHintText,
    required this.searchTextController,
    // this.onChanged,
    required this.focusNode,
    this.onCrossButtonTap,
    this.onTextFieldTap,
    this.isEditingEnabled = true,
    this.isLoading = false,
    this.onSubmitted,
  }) : super(key: key);

  @override
  State<PromoSearchInputWidget> createState() => _CarSearchInputWidgetState();
}

class _CarSearchInputWidgetState extends State<PromoSearchInputWidget> {
  String searchText = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSize12),
      margin: const EdgeInsets.symmetric(horizontal: kSize24, vertical: kSize8),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(kSize8)),
        color: AppColors.kGrey4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          searchText.isEmpty ? _buildSearchIcon() : Container(),
          _buildTextField(),
          _buildProgressIndicator(),
          searchText.isNotEmpty ? _buildCrossButton() : Container(),
          // _getSearchBarLeadingIcon()
        ],
      ),
    );
  }

  Widget _buildSearchIcon() {
    return Container(
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
        // onChanged: (txt) {
        //   setState(() {
        //     searchText = txt;
        //   });
        //   widget.onChanged!(txt);
        // },
        onSubmitted: widget.onSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey20),
          fillColor: AppColors.kGrey4,
          hintText: widget.searchHintText,
        ),
        maxLines: _kMaxLine,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(_searchFormatter)),
          LengthLimitingTextInputFormatter(15),
        ],
        onTap: widget.onTextFieldTap,
        style: AppTheme.kBodyRegular,
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
      onTap: () {
        setState(() {
          searchText = "";
        });
        widget.searchTextController.clear();
        widget.onCrossButtonTap!();
      },
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
