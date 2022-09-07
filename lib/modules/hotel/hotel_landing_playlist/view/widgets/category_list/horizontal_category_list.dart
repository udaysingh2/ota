import 'package:flutter/material.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/core_pack/custom_widgets/ota_chip_button/ota_chip_button.dart';
import 'package:ota/modules/hotel/hotel_landing_playlist/view/widgets/category_list/horizontal_category_list_bloc.dart';

const _kContainerHeight = 40.0;
const _kContainerHorizontalPadding = 24.0;
const _kContainerVerticalPadding = 8.0;
const _kItemRightPadding = 10.0;

class HorizontalCategoryList extends StatelessWidget {
  final List<String> categories;
  final int? selectedCatIndex;
  final double containerHeight;
  final ValueChanged<String>? onCategorySelected;
  final ValueChanged<int>? onCategorySelectedIndex;

  final HorizontalCategoryListBloc _bloc = HorizontalCategoryListBloc();

  HorizontalCategoryList(
      {Key? key,
      required this.categories,
      this.selectedCatIndex = 0,
      this.containerHeight = _kContainerHeight,
      this.onCategorySelected,
      this.onCategorySelectedIndex})
      : super(key: key) {
    _bloc.setCategories(categories, selectedCatIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: containerHeight,
      child: BlocBuilder(
        bloc: _bloc,
        builder: () {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: _kContainerVerticalPadding,
              horizontal: _kContainerHorizontalPadding,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: _bloc.state.categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: _kItemRightPadding),
                child: OtaChipButton(
                  key: const Key("ota_button"),
                  title: _bloc.state.categories[index],
                  isSelected: index == _bloc.state.selectedCategoryIndex,
                  onPressed: () {
                    if (onCategorySelected != null) {
                      onCategorySelected!(_bloc.state.categories[index]);
                    }
                    if (onCategorySelectedIndex != null) {
                      onCategorySelectedIndex!(index);
                    }
                    _bloc.setSelectedCategory(index);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
