import 'package:flutter/material.dart';

extension ScreenUtils on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

  Orientation get orientation => MediaQuery.orientationOf(this);

  double w(double percent) {
    assert(
      percent >= 0 && percent <= 100,
      'Percent should be between 0 and 100',
    );
    return width * percent / 100;
  }

  double h(double percent) {
    assert(
      percent >= 0 && percent <= 100,
      'Percent should be between 0 and 100',
    );
    return height * percent / 100;
  }

  bool get isMobile => width <= 450;
  bool get isTablet => width >= 451 && width <= 800;
  bool get isDesktop => width >= 801;

  bool get isPortrait => orientation == Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;

  double get safeWidth => width - MediaQuery.viewPaddingOf(this).horizontal;
  double get safeHeight => height - MediaQuery.viewPaddingOf(this).vertical;
}