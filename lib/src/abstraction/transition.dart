import 'package:flutter/material.dart';

abstract class Transition {
  final Widget _child;

  const Transition(this._child);

  Route<dynamic> call() {}

  Widget animate(
    BuildContext context,
    Animation<double> enterAnimation,
    Animation<double> popAnimation,
    Widget child,
  );
}
