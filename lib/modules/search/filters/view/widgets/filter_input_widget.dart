import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_localization_strings.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_pack/custom_widgets/ota_horizontal_divider.dart';
import 'package:ota/core_pack/i18n/language_constants.dart';

const double _kHeaderHeight = 68.0;

class FilterInputWidget extends StatefulWidget {
  final String title;
  final int? initialValue;
  final String? hintText;
  final int? maxInputValueLimit;
  final int minInputValueLimit;
  final bool showErrorMessage;
  final ValueChanged<int>? onAgreeClicked;
  final Function? onClose;

  const FilterInputWidget({
    Key? key,
    required this.title,
    this.initialValue,
    this.hintText,
    this.maxInputValueLimit,
    this.minInputValueLimit = 1,
    this.showErrorMessage = false,
    this.onAgreeClicked,
    this.onClose,
  }) : super(key: key);

  @override
  FilterInputWidgetState createState() => FilterInputWidgetState();
}

class FilterInputWidgetState extends State<FilterInputWidget> {
  TextEditingController? _textFieldController;
  bool _isValidAge = false;
  FocusNode? _focusNode;

  void validateAge(String inputAge) {
    if (inputAge.isNotEmpty && widget.maxInputValueLimit != null) {
      final int age = int.tryParse(inputAge) ?? 0;
      setAgeState(age >= widget.minInputValueLimit &&
          age <= widget.maxInputValueLimit!);
    } else {
      setAgeState(false);
    }
  }

  void setAgeState(bool isValid) {
    setState(() {
      _isValidAge = isValid;
    });
  }

  void _setInitialValue() {
    String initialValue = '';
    if (widget.initialValue != null && widget.initialValue != 0) {
      initialValue = widget.initialValue.toString();
      validateAge(initialValue);
    }
    _textFieldController = TextEditingController(text: initialValue);
  }

  bool get _shouldShowErrorMessage {
    return !_isValidAge &&
        widget.showErrorMessage &&
        _textFieldController!.text.isNotEmpty;
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _setInitialValue();
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildHeaderView(context),
          const OtaHorizontalDivider(dividerColor: AppColors.kGrey10),
          _buildTextFieldView(context),
          _buildErrorMessage(context),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  Widget _buildHeaderView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: kSize24),
      height: _kHeaderHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            key: const Key('childAgePopUp'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            iconSize: kSize20,
            splashRadius: kSize14,
            icon: const Icon(
              Icons.close_rounded,
              size: kSize20,
            ),
            onPressed: () {
              _focusNode?.unfocus();
              Navigator.pop(context);
            },
          ),
          Text(
            widget.title,
            style: AppTheme.kHeading1,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(kSize12),
            onTap: _isValidAge ? _submitAge : null,
            child: Ink(
              padding: const EdgeInsets.symmetric(
                  horizontal: kSize12, vertical: kSize2),
              child: Text(
                getTranslated(context, AppLocalizationsStrings.agree),
                style: AppTheme.kButton.copyWith(
                    color: _isValidAge
                        ? AppColors.kGradientStart
                        : AppColors.kGrey10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorMessage(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: kSize36, right: kSize24, bottom: kSize48),
      child: Text(
        _shouldShowErrorMessage
            ? getTranslated(
                context, AppLocalizationsStrings.childAgeConditionErrorMessage)
            : '',
        style: AppTheme.kSmall1.copyWith(color: AppColors.kSystemWrong),
      ),
    );
  }

  Widget _buildTextFieldView(BuildContext context) {
    return Container(
      height: kSize40,
      margin:
          const EdgeInsets.only(left: kSize24, right: kSize24, top: kSize16),
      padding: const EdgeInsets.only(left: kSize12, right: kSize12),
      decoration: BoxDecoration(
        color: AppColors.kGrey4,
        borderRadius: const BorderRadius.all(Radius.circular(kSize8)),
        border: _shouldShowErrorMessage
            ? Border.all(color: AppColors.kSystemWrong)
            : null,
      ),
      child: TextField(
        controller: _textFieldController,
        focusNode: _focusNode,
        autofocus: true,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: widget.hintText ?? '',
          hintStyle: AppTheme.kBody.copyWith(
              fontFamily: kFontFamily, color: AppColors.kGrey20, height: 1.25),
        ),
        style: AppTheme.kBody.copyWith(
            fontFamily: kFontFamily, color: AppColors.kGrey20, height: 1.25),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(2),
        ], // Only numbers can be entered
        onSubmitted: _isValidAge ? (_) => _submitAge() : null,
        onChanged: validateAge,
      ),
    );
  }

  void _submitAge() {
    if (widget.onAgreeClicked != null) {
      widget.onAgreeClicked!(
          int.tryParse(_textFieldController?.text ?? '1') ?? 1);
    }
    Navigator.pop(context);
  }
}
