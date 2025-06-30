import 'package:flutter/material.dart';

class LayoutHelper {
  final BuildContext context;
  final double width;

  LayoutHelper(this.context) : width = MediaQuery.of(context).size.width;

  bool get isMobileS => width < 360;
  bool get isMobileM => width >= 360 && width < 400;
  bool get isMobileL => width >= 400 && width < 600;

  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1024;
  bool get isLaptop => width >= 1024 && width < 1440;
  bool get isDesktop => width >= 1440 && width < 2560;
  bool get isUltraHD => width >= 2560;

  double scale(double value) {
    if (isUltraHD) return value * 1.5;
    if (isDesktop) return value * 1.2;
    if (isLaptop) return value * 1.1;
    if (isTablet) return value * 0.95;
    return value * 0.85;
  }

  double get screenWidth => width;
}
