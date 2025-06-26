import 'package:flutter/material.dart';

class Layout {
  final BuildContext context;

  Layout(this.context);

  double get _width => MediaQuery.of(context).size.width;

  /// Standard breakpoints
  bool get isMobile => _width < 600;

  /// Covers foldables like Z Fold unfolded, small landscape tablets
  bool get isFoldableOrSmallTablet => _width >= 600 && _width < 900;

  /// Covers iPads and larger tablets
  bool get isTablet => _width >= 900 && _width < 1200;

  /// Standard desktop and wide web
  bool get isDesktop => _width >= 1200;

  /// Optional: current device type
  String get currentType {
    if (isMobile) return "Mobile";
    if (isFoldableOrSmallTablet) return "Foldable/Small Tablet";
    if (isTablet) return "Tablet";
    return "Desktop";
  }
}
