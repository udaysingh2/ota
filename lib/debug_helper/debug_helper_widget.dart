import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/debug_helper/debug_utilities.dart';

import 'debug_helper_bloc.dart';
import 'debug_log_bloc.dart';

//This code will be the part of debugger // No performance test needed or
//Extensive review needed
class DebugHelperWidget extends StatelessWidget {
  final TestBloc testBloc;
  DebugHelperWidget(this.testBloc, {Key? key}) : super(key: key);

  Widget getCancelButton() {
    return GestureDetector(
      onTap: () {
        testBloc.setFalse();
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Icon(
          Icons.close_fullscreen_outlined,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget getClearButton() {
    return GestureDetector(
      onTap: () {
        DebugUtils.debugLogBloc.clearAll();
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Icon(
          Icons.phonelink_erase,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget getCopyButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Icon(
          Icons.copy,
          color: Colors.white,
        ),
      ),
    );
  }

  final ShowOverlayBloc showOverlayBloc = ShowOverlayBloc();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: showOverlayBloc,
        builder: () {
          if (showOverlayBloc.state) {
            return ShowOverlay(showOverlayBloc);
          }
          return getListerWidget();
        });
  }

  Widget getListerWidget() {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                getCancelButton(),
                const SizedBox(
                  width: 10,
                ),
                getClearButton(),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            Expanded(
              child: getListView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget getListView() {
    return BlocBuilder(
        bloc: DebugUtils.debugLogBloc,
        builder: () {
          return ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  ShowOverlay.bloc.setData(DebugUtils.debugLogBloc.state.logs
                      .elementAt(index)
                      .logStrings);
                  showOverlayBloc.show();
                },
                child: Container(
                  height: 60,
                  color: getColorBasedOnLogType(DebugUtils
                      .debugLogBloc.state.logs
                      .elementAt(index)
                      .debugLogBannerType),
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            DebugUtils.debugLogBloc.state.logs
                                .elementAt(index)
                                .logTitle,
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              getFormatedDate(index),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              "Log Count : $index",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: DebugUtils.debugLogBloc.state.logs.length,
          );
        });
  }

  String getFormatedDate(int index) {
    return "${DebugUtils.debugLogBloc.state.logs.elementAt(index).dateTime?.hour ?? 00}-${DebugUtils.debugLogBloc.state.logs.elementAt(index).dateTime?.minute ?? 00}-${DebugUtils.debugLogBloc.state.logs.elementAt(index).dateTime?.second ?? 00}";
  }

  Color getColorBasedOnLogType(DebugLogBannerType type) {
    switch (type) {
      case DebugLogBannerType.happy:
        return Colors.green;
      case DebugLogBannerType.danger:
        return Colors.red;
      case DebugLogBannerType.blue:
        return Colors.blue;
      case DebugLogBannerType.yellow:
        return Colors.yellow;
    }
  }
}

class ShowOverlay extends StatelessWidget {
  final ShowOverlayBloc showOverlayBloc;
  static SingleDebugLogBloc bloc = SingleDebugLogBloc();
  const ShowOverlay(this.showOverlayBloc, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocBuilder(
          bloc: bloc,
          builder: () {
            return getListerDetailWidget(context);
          });
    });
  }

  Widget getCopyButton({String copyText = ""}) {
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: copyText));
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Icon(
          Icons.copy,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget getCancelButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showOverlayBloc.hide();
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Icon(
          Icons.close_fullscreen_outlined,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget getListerDetailWidget(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                getCancelButton(context),
                const SizedBox(
                  width: 10,
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            Expanded(
              child: getTitledListerCreater(bloc.state),
            ),
          ],
        ),
      ),
    );
  }

  Widget getTitledListerCreater(List<DebugLogString> data) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        children: listOfDebugData(data),
        animationDuration: const Duration(milliseconds: 200),
        expandedHeaderPadding: const EdgeInsets.all(8),
        expansionCallback: (panelIndex, isExpanded) {
          bloc.toggleBasedOnIndex(panelIndex);
        },
      ),
    );
  }

  List<ExpansionPanel> listOfDebugData(List<DebugLogString> data) {
    List<ExpansionPanel> pannels = [];
    for (DebugLogString datas in data) {
      pannels.add(
        ExpansionPanel(
          headerBuilder: (context, isExpanded) {
            return Text(
              datas.logTitle,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            );
          },
          canTapOnHeader: true,
          isExpanded: datas.isExpanded,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getCopyButton(copyText: datas.logsDescription),
              const SizedBox(
                height: 10,
                width: double.infinity,
              ),
              Text(
                datas.logsDescription,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return pannels;
  }
}
