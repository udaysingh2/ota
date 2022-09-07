import 'package:flutter/material.dart';
import 'package:ota/common/utils/app_colors.dart';
import 'package:ota/common/utils/app_theme.dart';
import 'package:ota/common/utils/consts.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';

import 'counter_bloc.dart';
import 'plus_minus_button.dart';

const int _kMaxLines = 2;

class FilterRowWidget extends StatelessWidget {
  final String title;
  final int initialValue;
  final TextStyle titleStyle;
  final FilterRowType filterRowWidgetType;
  final ValueChanged<int>? onValueAdded;
  final ValueChanged<int>? onValueRemoved;
  final int? maxValue;
  final int? minValue;
  final Widget? subTitleWidget;
  final Widget? postTitleWidget;

  const FilterRowWidget({
    Key? key,
    required this.title,
    this.initialValue = 0,
    this.titleStyle = AppTheme.kBodyRegular,
    this.filterRowWidgetType = FilterRowType.room,
    this.onValueAdded,
    this.onValueRemoved,
    this.maxValue,
    this.minValue,
    this.subTitleWidget,
    this.postTitleWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = CounterBloc(
        filterRowWidgetType, initialValue, maxValue,
        minValue: minValue);
    return BlocBuilder(
      bloc: counterBloc,
      builder: () {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: kSize4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: [
                        Flexible(
                          child: Text(title,
                              maxLines: _kMaxLines,
                              overflow: TextOverflow.ellipsis,
                              style: titleStyle),
                        ),
                        const SizedBox(width: kSize8),
                        if (postTitleWidget != null) postTitleWidget!,
                      ],
                    ),
                    if (subTitleWidget != null) subTitleWidget!,
                  ],
                ),
              ),
              PlusMinusButton(
                key: Key(ButtonType.minusButton.toString()),
                buttonType: ButtonType.minusButton,
                isEnabled: initialValue != counterBloc.minLimit,
                onPressed: () {
                  counterBloc.valueChanged(CounterEvent.decrement);
                  if (onValueRemoved != null) {
                    onValueRemoved!(counterBloc.state.value);
                  }
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: kSize10),
                width: kSize32,
                child: _getGradientTextWidget(context, '$initialValue'),
              ),
              PlusMinusButton(
                key: Key(ButtonType.plusButton.toString()),
                buttonType: ButtonType.plusButton,
                isEnabled: initialValue != counterBloc.maxLimit,
                onPressed: () {
                  counterBloc.valueChanged(CounterEvent.increment);
                  if (onValueAdded != null) {
                    onValueAdded!(counterBloc.state.value);
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  Widget _getGradientTextWidget(BuildContext context, String text) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return AppColors.gradient1.createShader(Offset.zero & bounds.size);
      },
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTheme.kBodyRegular.copyWith(color: AppColors.kGradientStart),
      ),
    );
  }
}
