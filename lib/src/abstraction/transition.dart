import 'package:flutter/material.dart';

abstract class Transition extends PageRoute {
  final Widget _child;

  Transition(
    this._child, {
    bool fullscreenDialog = false,
    this.barrierColor,
    this.barrierLabel,
  }) : super(fullscreenDialog: fullscreenDialog);

  Duration get transitionDuration => const Duration(milliseconds: 750);

  @override
  final Color barrierColor;

  @override
  final String barrierLabel;

  @override
  bool get opaque => true;

  @override
  bool get barrierDismissible => false;

  @override
  bool get maintainState => true;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return animate(context, animation, secondaryAnimation, child);
  }

  @override
  Widget buildPage(
    _,
    __,
    ___,
  ) {
    return _child;
  }

  Widget animate(
    BuildContext context,
    Animation<double> enterAnimation,
    Animation<double> popAnimation,
    Widget child,
  );
}
