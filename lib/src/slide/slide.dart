import 'package:flutter/material.dart';
import 'package:transitions/src/abstraction/transition.dart';

abstract class SimpleSlideTransition extends Transition {
  SimpleSlideTransition(Widget child) : super(child);

  Offset get enterBeginOffset;
  Offset get enterEndOffset;
  Curve get curve => Curves.linear;

  @override
  Widget animate(
    BuildContext context,
    Animation<double> enterAnimation,
    Animation<double> popAnimation,
    Widget child,
  ) {
    final slideTransition = Tween<Offset>(
      begin: enterBeginOffset,
      end: enterEndOffset,
    ).animate(
      CurvedAnimation(
        curve: curve,
        parent: enterAnimation,
      ),
    );
    return SlideTransition(
      position: slideTransition,
      child: child,
    );
  }
}
