import 'package:flutter/material.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/modules/search/ota_filters/bloc/filter_ota_bloc.dart';
import 'package:ota/modules/search/ota_filters/view/widgets/search_sort.dart';

const BorderRadius _kBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(20),
  topRight: Radius.circular(20),
);

class CustomOtaSearchSortSheet {
  void showCustomModelSheet(
    BuildContext context,
    FilterOtaBloc filterOtaBloc,
    String title,
  ) {
    showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: _kBorderRadius,
        ),
        builder: (BuildContext context) {
          return BlocBuilder(
              bloc: filterOtaBloc,
              builder: () {
                return SearchSort(
                  title: title,
                  selectedIndex: filterOtaBloc.getSelectedSortingIndex(),
                  labelList: filterOtaBloc.state.listOfSortString
                          ?.map((e) => e.stringValue ?? "")
                          .toList() ??
                      [],
                  onPressed: (value) {
                    filterOtaBloc.onSortIndexChanged(value);
                  },
                );
              });
        });
  }
}
