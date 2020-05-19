import 'package:flutter/material.dart';
import 'package:transitions/src/abstraction/transition.dart';

abstract class SimpleSlideTransition extends Transition {
  const SimpleSlideTransition(Widget child) : super(child);

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

abstract class ComplexSlideTransition extends SimpleSlideTransition {
  const ComplexSlideTransition(Widget child) : super(child);

  Offset get popBeginOffset;
  Offset get popEndOffset;

  @override
  Widget animate(
    BuildContext context,
    Animation<double> enterAnimation,
    Animation<double> popAnimation,
    Widget child,
  ) {
    final simpleAnimation = super.animate(
      context,
      enterAnimation,
      popAnimation,
      child,
    );

    final slideTransition = Tween<Offset>(
      begin: popBeginOffset,
      end: popEndOffset,
    ).animate(
      CurvedAnimation(
        curve: curve,
        parent: popAnimation,
      ),
    );

    return SlideTransition(
      position: slideTransition,
      child: simpleAnimation,
    );
  }
}
