import 'package:flutter/material.dart';
import './slide.dart';

class RuntimeComplexSlideTransition extends ComplexSlideTransition {
  RuntimeComplexSlideTransition(
    Widget child, {
    this.enterBeginOffset = Offset.zero,
    this.enterEndOffset = Offset.zero,
    this.popBeginOffset = Offset.zero,
    this.popEndOffset = Offset.zero,
  }) : super(child);

  @override
  final Offset enterBeginOffset;

  final Offset enterEndOffset;

  @override
  final Offset popBeginOffset;

  @override
  final Offset popEndOffset;
}

class RightCenterComplexSlideTransition extends ComplexSlideTransition {
  RightCenterComplexSlideTransition(Widget child) : super(child);

  @override
  Offset get enterBeginOffset => Offset(1, 0);

  @override
  Offset get enterEndOffset => Offset.zero;

  @override
  Offset get popBeginOffset => Offset.zero;

  @override
  Offset get popEndOffset => Offset(-1, 0);
}

class LeftCenterComplexSlideTransition extends ComplexSlideTransition {
  LeftCenterComplexSlideTransition(Widget child) : super(child);

  @override
  Offset get enterBeginOffset => Offset(-1, 0);

  @override
  Offset get enterEndOffset => Offset.zero;

  @override
  Offset get popBeginOffset => Offset.zero;

  @override
  Offset get popEndOffset => Offset(1, 0);
}

class TopCenterComplexSlideTransition extends ComplexSlideTransition {
  TopCenterComplexSlideTransition(Widget child) : super(child);

  @override
  Offset get enterBeginOffset => Offset(0, 1);

  @override
  Offset get enterEndOffset => Offset.zero;

  @override
  Offset get popBeginOffset => Offset.zero;

  @override
  Offset get popEndOffset => Offset(0, -1);
}

class BottomCenterComplexSlideTransition extends ComplexSlideTransition {
  BottomCenterComplexSlideTransition(Widget child) : super(child);

  @override
  Offset get enterBeginOffset => Offset(0, -1);

  @override
  Offset get enterEndOffset => Offset.zero;

  @override
  Offset get popBeginOffset => Offset.zero;

  @override
  Offset get popEndOffset => Offset(0, 1);
}
