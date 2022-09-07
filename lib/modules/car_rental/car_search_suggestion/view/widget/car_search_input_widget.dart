import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_icon_button.dart';

const double _kLoaderWidth = 2.5;

const int _kMaxLine = 1;
const String _kSearchIconPath = "assets/images/icons/feather_search.svg";
const String _kCloseIconPath = "assets/images/icons/close.svg";
const String _searchFormatter = r"[A-Za-z\u0E00-\u0E7F0-9-'’#&()@ *:,./ ]";

class CarSearchInputWidget extends StatefulWidget {
  final String searchHintText;
  final TextEditingController searchTextController;
  final FocusNode focusNode;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onCrossButtonTap;
  final Function()? onTextFieldTap;
  final bool isEditingEnabled;
  final bool isLoading;

  const CarSearchInputWidget({
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
  State<CarSearchInputWidget> createState() => _CarSearchInputWidgetState();
}

class _CarSearchInputWidgetState extends State<CarSearchInputWidget> {
  String searchText = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: kSize12, right: kSize10),
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
          searchText.isNotEmpty ? _buildCrossButton() : Container(),
          searchText.isEmpty ? _buildSearchIcon() : Container(),
        ],
      ),
    );
  }

  Widget _buildSearchIcon() {
    return SvgPicture.asset(
      _kSearchIconPath,
      height: kSize20,
      width: kSize16,
      color: AppColors.kGrey20,
    );
  }

  Widget _buildTextField() {
    return Expanded(
      child: TextField(
        enabled: widget.isEditingEnabled,
        focusNode: widget.focusNode,
        controller: widget.searchTextController,
        onChanged: (txt) {
          setState(() {
            searchText = txt;
          });
          widget.onChanged!(txt);
        },
        onSubmitted: widget.onSubmitted,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: AppTheme.kBodyRegular.copyWith(color: AppColors.kGrey20),
          fillColor: AppColors.kGrey4,
          hintText: widget.searchHintText,
        ),
        maxLines: _kMaxLine,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp(_searchFormatter),
          ),
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
