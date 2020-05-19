import 'package:flutter/material.dart';
import 'package:transitions/src/abstraction/transition.dart';
export './slide_impl.dart';

abstract class SimpleSlideTransition extends Transition {
  SimpleSlideTransition(Widget child) : super(child);

  Offset get enterBeginOffset;
  Offset get enterEndOffset;
  Curve get curve => Curves.easeInOut;

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

abstract class SimpleExitSlideTransition extends Transition {
  SimpleExitSlideTransition(Widget child) : super(child);

  Offset get exitBeginOffset;
  Offset get exitEndOffset;
  Curve get curve => Curves.easeInOut;

  @override
  Widget animate(
    BuildContext context,
    Animation<double> enterAnimation,
    Animation<double> popAnimation,
    Widget child,
  ) {
    final slideTransition = Tween<Offset>(
      begin: exitBeginOffset,
      end: exitEndOffset,
    ).animate(
      CurvedAnimation(
        curve: curve,
        parent: popAnimation,
      ),
    );
    return SlideTransition(
      position: slideTransition,
      child: child,
    );
  }
}

abstract class ComplexSlideTransition extends SimpleSlideTransition {
  ComplexSlideTransition(Widget child) : super(child);

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

class RuntimeComplexSlideTransition extends SimpleExitSlideTransition {
  RuntimeComplexSlideTransition(
    Widget child, {
    this.exitBeginOffset,
    this.exitEndOffset,
    this.curve = Curves.easeInOut,
  }) : super(child);

  @override
  final Offset exitBeginOffset;

  @override
  final Offset exitEndOffset;

  final Curve curve;

  @override
  Widget animate(
    BuildContext context,
    Animation<double> enterAnimation,
    Animation<double> popAnimation,
    Widget child,
  ) {
    final oldTransition = MutableComplexSlideTransition.of(context);
    final enterBeginOffset = -(oldTransition?.exitEndOffset ?? Offset.zero);
    final enterEndOffset = -(oldTransition?.exitBeginOffset ?? Offset.zero);

    final enterSlideAnimation = Tween<Offset>(
      begin: enterBeginOffset,
      end: enterEndOffset,
    ).animate(
      CurvedAnimation(
        curve: curve,
        parent: enterAnimation,
      ),
    );

    final exitSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        curve: curve,
        parent: popAnimation,
      ),
    );

    final animatedWidget = SlideTransition(
      position: enterSlideAnimation,
      child: SlideTransition(
        position: exitSlideAnimation,
        child: child,
      ),
    );

    return MutableComplexSlideTransition(
      this,
      animatedWidget,
    );
  }
}

class MutableComplexSlideTransition extends InheritedWidget {
  final RuntimeComplexSlideTransition runtimeComplexSlideTransition;

  MutableComplexSlideTransition(
    this.runtimeComplexSlideTransition,
    Widget child,
  ) : super(child: child);

  static RuntimeComplexSlideTransition of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<MutableComplexSlideTransition>();

    return scope?.runtimeComplexSlideTransition;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
