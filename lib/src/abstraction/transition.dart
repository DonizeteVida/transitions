import 'package:flutter/material.dart';

abstract class Transition {
  final Widget _child;

  const Transition(this._child);

  Duration get transitionDuration => const Duration(milliseconds: 300);
  bool get opaque => true;
  bool get barrierDismissible => false;
  bool get maintainState => true;
  bool get fullscreenDialog => false;

  Route<dynamic> call() {
    return PageRouteBuilder(
      pageBuilder: (
        _,
        __,
        ___,
      ) {
        return _child;
      },
      transitionsBuilder: animate,
      transitionDuration: transitionDuration,
      opaque: opaque,
      barrierDismissible: barrierDismissible,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
    );
  }

  Widget animate(
    BuildContext context,
    Animation<double> enterAnimation,
    Animation<double> popAnimation,
    Widget child,
  );
}
