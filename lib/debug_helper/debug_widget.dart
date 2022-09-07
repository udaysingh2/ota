import 'package:flutter/material.dart';
import 'package:ota/core_components/bloc/bloc_builder.dart';
import 'package:ota/debug_helper/debug_helper_widget.dart';
import 'package:ota/debug_helper/debug_utilities.dart';

import 'debug_helper_bloc.dart';

//This code will be the part of debugger // No performance test needed or
//Extensive review needed
class DebugWidget extends StatefulWidget {
  const DebugWidget({Key? key}) : super(key: key);

  @override
  DebugWidgetState createState() => DebugWidgetState();
}

class DebugWidgetState extends State<DebugWidget> {
  Offset position = const Offset(20.0, 20.0);

  @override
  Widget build(BuildContext context) {
    return getWidget(DebugUtils.testBloc);
  }

  Widget getWidget(TestBloc testBloc) {
    return BlocBuilder(
        bloc: testBloc,
        builder: () {
          return Stack(
            children: [
              if (testBloc.state) DebugHelperWidget(testBloc),
              if (!testBloc.state)
                Positioned(
                    left: position.dx,
                    top: position.dy,
                    child: Draggable(
                        feedback: getButton(),
                        childWhenDragging: Container(),
                        onDragEnd: (details) {
                          setState(() {
                            position = details.offset;
                          });
                        },
                        child: getButton())),
            ],
          );
        });
  }

  Widget getButton() {
    return GestureDetector(
      onTap: () {
        DebugUtils.testBloc.setTrue();
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Icon(
          Icons.developer_mode,
          color: Colors.white,
        ),
      ),
    );
  }
}
