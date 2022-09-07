import 'dart:async';

import 'package:flutter/material.dart';

import 'bloc.dart';

class BlocBuilder extends StatelessWidget {
  final Widget Function() builder;
  final Bloc bloc;
  const BlocBuilder({Key? key, required this.bloc, required this.builder})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.stream,
        initialData: bloc.state,
        builder: (context, snapshot) {
          return builder();
        });
  }
}

// Todo : Experimental Bloc builder needs More Testing: And state handling. Not used yet in the project
class BlocBuilderExperimental extends StatefulWidget {
  final Widget Function() builder;
  final Bloc bloc;
  final bool Function()? isUpdateRequired;
  const BlocBuilderExperimental(
      {Key? key,
      required this.bloc,
      required this.builder,
      this.isUpdateRequired})
      : super(key: key);
  @override
  BlocBuilderExperimentalState createState() => BlocBuilderExperimentalState();
}

class BlocBuilderExperimentalState extends State<BlocBuilderExperimental> {
  StreamSubscription? _subscription;

  @override
  Widget build(BuildContext context) {
    return widget.builder();
  }

  void _subscribe() {
    _subscription = widget.bloc.stream.listen((data) {
      if (widget.isUpdateRequired != null) {
        if (!widget.isUpdateRequired!()) return;
      }
      setState(() {});
    }, onError: (Object error, StackTrace stackTrace) {
      if (widget.isUpdateRequired != null) {
        if (!widget.isUpdateRequired!()) return;
      }
      setState(() {});
    }, onDone: () {
      if (widget.isUpdateRequired != null) {
        if (!widget.isUpdateRequired!()) return;
      }
      setState(() {});
    });
  }

  void _unsubscribe() {
    if (_subscription != null) {
      _subscription?.cancel();
      _subscription = null;
    }
  }

  @override
  void didUpdateWidget(BlocBuilderExperimental oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bloc.stream != widget.bloc.stream) {
      if (_subscription != null) {
        _unsubscribe();
      }
      _subscribe();
    }
  }
}
