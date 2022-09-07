import 'package:flutter/material.dart';
import 'package:ota/common/utils/consts.dart';

//@Todo we are using WrappedGridView class instead of this class (can remove this class after testing done)
const double _kSize28 = 28;

class HotelSuccessPaymentServiceCardGridView extends StatelessWidget {
  final List<Widget> listOfWidget;
  const HotelSuccessPaymentServiceCardGridView({Key? key, required this.listOfWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return getItemOnIndex(index, context);
      },
      itemCount: (listOfWidget.length / 3).ceil(),
    );
  }

  Widget getItemOnIndex(int index, BuildContext context) {
    ///Calculate number of rows based on 3 items in a row.
    int numberOfRows = (listOfWidget.length / 3).ceil();

    ///Check if it is the last row
    if (numberOfRows == index + 1) {
      ///Check if last row has a single item
      if (listOfWidget.length % 3 == 1) {
        return getRow([
          Expanded(child: listOfWidget[(index * 3) + 0]),
        ]);
      }

      ///Check if last row has two items
      else if (listOfWidget.length % 3 == 2) {
        return getRow(
          [
            listOfWidget[(index * 3) + 0],
            listOfWidget[(index * 3) + 1],
            SizedBox(
              width:
                  (MediaQuery.of(context).size.width - kSize48 - _kSize28) / 3,
            )
          ],
        );
      }
    }

    ///Return if row has three items
    return getRow([
      listOfWidget[(index * 3) + 0],
      listOfWidget[(index * 3) + 1],
      listOfWidget[(index * 3) + 2],
    ]);
  }

  Widget getRow(List<Widget> list, {MainAxisAlignment? mainAxisAlignment}) {
    return Container(
      padding: const EdgeInsets.only(bottom: kSize16),
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
        children: list,
      ),
    );
  }
}
